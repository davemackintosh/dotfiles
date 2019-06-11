#!/bin/env lua

os.execute("clear")

-- Update path so we can require shizzle.
package.path = debug.getinfo( 1, "S" ).source .. "?.lua;" .. package.path

-- Print out a table
-- @Global
function inspect(table, prefix, depth)
  prefix = prefix or ""
  depth = type(depth) == "nil" and 0 or depth
  for k,v in pairs(table) do 
    if type(v) == "table" then
      print(k .. ":")
      inspect(table, "\t", depth)
    else
      print(string.rep(prefix, depth) .. k,v) 
    end
  end
end

-- Run an Shell command.
-- @Global
function exec(command, args)
  local os = require("os")

  local f = io.popen(command)
  local results = f:read("*a")

  return results
end

function confirm(message, confirmInput, exitStatus) 
  confirmInput = confirmInput or "YES/no"
  exitStatus = type(exitStatus) ~= "nil" and exitStatus or 1

  print(message)
  print(confirmInput)
  local answer = io.read()

  if answer ~= confirmInput:match("^(%w+)/") then
    os.exit(exitStatus)
  end
end

-- Get our bizzle.
local config = require(".config")
local messages = require(".messages")[config.locale[1]]

-- Try to convince this person that they're doing something
-- really wrong and that they should really really think hard about it.
confirm(messages.firstDiskConfirm)
confirm(messages.secondDiskConfirm)

-- Ask for a confirmation phrase to make this really real.
confirm(messages.finalDiskConfirm, "erase all my data please")

--[[
loadkeys $keyboard &&
timedatectl set-ntp true &&

# Taken from https://superuser.com/a/984637
# Thanks, updated slightly but works all the same.
# Note that a blank line (commented as "defualt" will send a empty
# line terminated with a newline to take the fdisk default.
(
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk $drive
  o # clear the in memory partition table
  n # new partition BOOT
  p # primary partition
  1 # partition number 1
    # default - start at beginning of disk 
  +100M # 100 MB boot partition
  a # make a partition bootable
  t # Change type
  ef # EFI Partition type.

  n # new partition system
  p # It's a primary partition
  2 # Partition number /dev/sda2
    # Start at the end of the last partition
    # Continue to the end of the disk

  w # write the partition table
  q # and we're done
EOF
) &&

# Time to create our volume groups.
yes | pvcreate -ff /dev/sda2 &&
vgcreate "$volGroupName" /dev/sda2 &&
lvcreate -L 15G -n root "$volGroupName" &&
lvcreate -L 500M -n swap "$volGroupName" &&
lvcreate -l 100%FREE -n home "$volGroupName" &&

# Format and encrypt the "drives"
yes | mkfs.vfat -F32 /dev/sda1 &&
echo -e "Enter your desired encryption password. You'll be asked for this again in a moment." &&
cryptsetup luksFormat -c aes-xts-plain64 -s 512 /dev/mapper/${volGroupName}-root &&
echo -e "Okay, enter that password again so we can unlock the encryption to write to it." &&
cryptsetup open /dev/mapper/${volGroupName}-root root &&
yes | mkfs.ext4 /dev/mapper/root &&

# Mount drives
mount /dev/mapper/root /mnt &&
mkdir /mnt/boot &&
mount /dev/sda1 /mnt/boot &&

# Install Arch
pacstrap /mnt base base-devel &&

# Update the file system table.
genfstab -U -p /mnt >> /mnt/etc/fstab &&

# Chroot to the new system.
arch-chroot /mnt &

# Set locale.
echo "$locale.$encoding $encoding" >> /etc/locale.gen &&
locale-gen &&
export LANG="$locale.$encoding" &&

# Set time.
ln -sf "/usr/share/zoneinfo/$zone/$place" /etc/localtime &&
hwclock --systohc --utc &&

# Update hosts.
echo "$hostname" > /etc/hostname &&
(
cat << HOSTS
127.0.0.1 localhost $hostname
::1       localhost $hostname
HOSTS
) > /etc/hosts &&

# Generate a new ramdisk with the hooks we need.
sed -i 's/^HOOKS=(\(.*\))$/HOOKS=\(\1, keymap, lvm2, encrypt\)/g' /etc/mkinitcpio.conf &&
cat /etc/mkinitcpio.conf &&
mkinitcpio -p linux &&

# Add systemd-boot config.
diskUUID=$(blkid -s UUID -o value /dev/mapper/root) &&

(
cat << ARCHENCRYPTED
title Arch Linux Encrypted
linux /vmlinuz-linux
initrd /initramfs-linux.img
options cryptdevice=UUID=$diskUUID:$volGroupName root=/dev/mapper/$volGroupName-root quiet rw
ARCHENCRYPTED
) > /boot/loader/entries/arch-encrypted.conf &&
cat /boot/loader/entries/arch-encrypted.conf &&

# Creating and encypting logical volumes
mkdir -m 700 /etc/luks-keys &&
dd if=/dev/random of=/etc/luks-keys/home bs=1 count=256 status=progress &&
cryptsetup luksFormat -c aes-xts-plain64 -s 512 "/dev/mapper/$volGroupName-home" &&
cryptsetup luksAddKey "/dev/mapper/$volGroupName-home" /etc/luks-keys/home &&
cryptsetup -d /etc/luks-keys/home open "/dev/$volGroupName/home" home &&
mkfs.ext4 /dev/mapper/home &&
mount /dev/mapper/home /home &&

(
cat << CRYPTTAB
swap  /dev/$volGroupName/cryptswap  /dev/urandom  swap,cipher=aes-xts-plain64,size=256
home  /dev/linux/home            /etc/luks-keys/home
CRYPTTAB
) > /etc/crypttab &&

(
cat << FSTAB
/dev/mapper/swap  none   swap  defaults,pri=-2 0 0
/dev/mapper/home  /home  ext4  defaults 0 2
FSTAB
) > /etc/fstab
]]
