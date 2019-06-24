#!/bin/env bash

#######################
# PARTITION THE DRIVE #
#######################

drive=$1
volGroupName=$2
lvPartition=$3
bootPartition=$4

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
  +100M # 100 MB EFI boot partition
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

# Time to create our volume groups.
yes | pvcreate -ff $lvPartition &&
vgcreate "$volGroupName" $lvPartition &&
lvcreate -L 15G -n root "$volGroupName" &&
lvcreate -L 1GB -n swap "$volGroupName" &&
lvcreate -l 100%FREE -n home "$volGroupName" &&

# Format the boot partition.
yes | mkfs.vfat -F32 $bootPartition &&

# Format and encrypt the "drives"
#### ROOT
yes | mkfs.ext4 /dev/mapper/${volGroupName}-root &&
echo -e "Enter your desired encryption password for the ROOT partition. You'll be asked for this again in a moment." &&
cryptsetup luksFormat -c aes-xts-plain64 -s 512 /dev/mapper/${volGroupName}-root &&
echo -e "Okay, enter that password again so we can unlock the encryption to write to it." &&
cryptsetup open /dev/mapper/${volGroupName}-root root &&

#### HOME
yes | mkfs.ext4 /dev/mapper/${volGroupName}-home &&
echo -e "Enter your desired encryption password for the HOME partition. You'll be asked for this again in a moment." &&
cryptsetup luksFormat -c aes-xts-plain64 -s 512 /dev/mapper/${volGroupName}-home &&
echo -e "Okay, enter that password again so we can unlock the encryption to write to it." &&
cryptsetup open /dev/mapper/${volGroupName}-root root &&

echo "Drive wiped and prepped"

