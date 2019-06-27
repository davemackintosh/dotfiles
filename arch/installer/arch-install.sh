#!/bin/env bash

# EDIT THESE IF YOU WANT #####
# Locale
keyboard=us
encoding="UTF-8"
locale="en_GB"

# Time/Date
zone=Europe
place=London

# Host name
hostname="ordoabchao"

### STOP EDITING UNLESS YOU KNOW WHkAT YOU'RE DOING #####

# Drive config.
volGroupName="vg0"
drive=$(lsblk -d -p -n -l -o NAME -e 7,11) # This will default to the first disk.
lvPartition="2"
bootPartition="1"

BLUE="\u001b[34m
UNDERLINE="\u001b[4m"
SWAP_BG_FG="\u001b[7m"
WHITE="\u001b[37;1m"
BG_RED="\u001b[41m"
RESET="\u001b[0m"

clear &&

# Function from https://stackoverflow.com/a/3232082
# Thanks mate! 
confirm() {
  # call with a prompt string or use a default
  read -r -p "${1:-Are you sure? [y/N]} " response
  case "$response" in
      [yY][eE][sS]|[yY]) 
          true
          ;;
      *)
          false
          ;;
  esac
}

echo -e "Please read everything you see, then read it again and again. If you miss something, it's your fault.\n"
echo -e "This script is best run on a new SSD or a system which you don't care about."
echo -e "\n$YELLOW If you have a LUKS/LVM setup already, you'll need to dmsetup info -C and dmsetup remove {name} each one first otherwise this script will erase your hard drive for and then fail due to an in use partition. $RESET\n"
echo -e "$BLUE I'm going to try and install Arch with:"
echo -e "* LUKS, (root, home) and a swap drive that re-encrypts on boot"
echo -e "* LVM (swap, root, home)"
echo -e "* X-org"
echo -e "* Awesome WM"
echo -e "* My dotfiles"
echo -e "\n"
echo -e "This$RED $BOLD*will destroy*$RESET $BLUE your hard drive in a fully automated way so you have to be 100% sure this is exactly what you want before agreeing below. $RESET"

echo -e "$RED $BOLD"

# Make sure whomever is doing this is super sure they're committing OS suicide and wants to be reborn.
confirm "Are you sure you want to destroy the world as you know it and start fresh? [yY][eE][sS]|[yY]" || exit
echo -e "\n"
confirm "Seriously? Are you sure, there's no going back at *any* point in this. Once I start, this thing is dead until I finish. Make sure you have a charger plugged in, you've back everything up (documents, downloads, work folders, dotfiles, ssh/GPG/Public/Private keys, etc) and come back and ask me again. I'm not resposible what you do with this thing. [yY][eE][sS]|[yY]" || exit

echo -e "$RESET"

echo -e "$YELLOW Okay, well. As long as you're sure, I'm going to partition and wipe this drive entirely. It will be encrypted using LUKS encryption and then I'll install LVM on top of that to enable snapshots and wayyyyy easier volume management without the sector bullcrap. I'm going to ask you one more time$RESET"

echo -e "$BG_RED $BOLD $WHITE This is your last chance to kill me where I stand and back yo shit up. You one bad bitch if you haven't backed everything up and you're still here asking me to wipe your hard drive permanently. There's literally no way back after this, I'm going to write your disk clean."

read -rep $'Please type the phrase "erase all my data please"\n\n$> ' phrase

if [ "$phrase" != "erase all my data please" ]; then
  echo -e "$RESET $GREEN $BOLD"
  echo -e "Probably wise, make sure everything is backed up and you have a charger plugged in then come back and we'll try this again :)"
  echo -e "$RESET"
  exit -1
fi
echo -e "$RESET"

loadkeys $keyboard &&
timedatectl set-ntp true &&

#######################
# PARTITION THE DRIVE #
#######################

dmsetup remove_all --force &&
wipefs --all --force $drive &&

# Modified from https://superuser.com/a/984637
# Note that a blank line (commented as "defualt" will send a empty
# line terminated with a newline to take the fdisk default.
(
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk $drive
  o # clear the in memory partition table
  n # new partition BOOT
  p # primary partition
  1 # partition number 1
    # default - start at beginning of disk 
  +200M # 100 MB EFI boot partition
  a # make a partition bootable
  t # Change type
  ef # EFI Partition type.

  n # new partition system
  p # It's a primary partition
  2 # Partition number $lvPartition
    # Start at the end of the last partition
    # Continue to the end of the disk

  w # write the partition table
  q # and we're done
EOF
) &&

echo -e "${YELLOW}Enter your desired encryption password for the ROOT partition. You'll be asked for this again in a moment.${RESET}" &&
cryptsetup luksFormat -c aes-xts-plain64 -s 512 "${drive}${lvPartition}" &&
echo -e "${YELLOW}Okay, enter that password again so we can unlock the encryption to write to it.${RESET}" &&
cryptsetup luksOpen "${drive}${lvPartition}" root &&

# Time to create our volume groups.
pvcreate -ff "/dev/mapper/root" &&
vgcreate "$volGroupName" "/dev/mapper/root" &&
lvcreate -L 15G -n root "$volGroupName" &&
lvcreate -L 4GB -n swap "$volGroupName" &&
lvcreate -l 100%FREE -n home "$volGroupName" &&

# Format and encrypt the "drives"
mkfs.vfat -F32 "${drive}${bootPartition}" &&

mkfs.ext4 /dev/mapper/${volGroupName}-root &&
mkfs.ext4 /dev/mapper/${volGroupName}-home &&
mkswap /dev/mapper/${volGroupName}-swap &&
swapon /dev/mapper/${volGroupName}-swap &&

echo "Drive wiped and prepped. Mounting and installing Arch" &&

# Mount volume group.
mount /dev/mapper/${volGroupName}-root /mnt &&
mkdir /mnt/{home,boot} &&
mount /dev/mapper/${volGroupName}-home /mnt/home &&
mount "${drive}${bootPartition}" /mnt/boot &&


###########################
### INSTALL BASE SYSTEM ###
###########################
pacman -Sy &&

# Install Arch.
pacstrap /mnt base base-devel &&

# Update the FSTab
genfstab -p /mnt >> /mnt/etc/fstab &&

cp ./arch-base.sh /mnt &&

arch-chroot /mnt bash /arch-base.sh "$keyboard" "$encoding" "$locale" "$zone" "$place" "$volGroupName" "$drive" "$lvPartition"

