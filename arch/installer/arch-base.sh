#!/bin/env bash

keyboard=$1
encoding=$2
locale=$3

# Time/Date
zone=$4
place=$5

# Drives
volGroupName=$6
drive=$7
lvPartition=$8

driveUUID=$(blkid -s UUID -o value "/dev/mapper/$volGroupName-root")

#####################
### SYSTEM CONFIG ###
#####################
ln -sf "/usr/share/zoneinfo/$zone/$place" /etc/localtime &&

hwclock --systohc &&

localeString="${locale}.${encoding} $encoding" &&
sed -i 's/#${localeString}/${localeString}/g' /etc/locale.gen &&

locale-gen &&
locale > /etc/locale.conf &&

# Hosts file
echo "$hostname" > /etc/hostname && 
echo "127.0.1.1   ${hostname}.localdomain  ${hostname}" >> /etc/hosts &&

# Add the encryption modules to the initramfs
sed -i 's/^HOOKS=.*$/HOOKS=(base udev autodetect modconf block keyboard encrypt lvm2 filesystems fsck)/g' /etc/mkinitcpio.conf &&
mkinitcpio -p linux &&

mkdir -p /boot/loader/entries &&

###################
### BOOT LOADER ###
###################
bootctl --path=/boot/ install &&  

(
cat <<EOL > /boot/loader/loader.conf
arch
timeout 3
editor 0
EOL
) &&

(
cat <<EOL > /boot/loader/entries/arch.conf
title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options cryptdevice=UUID=$driveUUID:volume root="/dev/mapper/${volGroupName}-root" quiet rw
EOL
) &&

#############
### USERS ###
#############
(
cat <<EOL >> /etc/pacman.conf
[multilib]
Include = /etc/pacman.d/mirrorlist
EOL
) &&
pacman -Syuu --noconfirm &&

echo -e "Enter your new user's username" &&
read usualUser
useradd -m $usualUser &&

echo -e "Enter their new password" &&
passwd $usualUser

# AUR packages and manager
pacman --noconfirm -Sy sudo git &&

echo "%wheel      ALL=(ALL) ALL" >> /etc/sudoers &&
usermod -aG wheel dave &&

# Smash out a post-install.sh to run
# since running yay in a root/chroot
# env is nothing short of a pain in the dick by design.
(
cat <<EOL >> /home/$usualUser/post-install.sh
#!/bin/env bash

git clone https://aur.archlinux.org/yay-bin.git &&
cd yay-bin &&
makepkg -i &&

yay -S ccls franz-bin lua-ldbus google-chrome google-cloud-sdk google-drive-ocamlfuse makemkv neovim-nightly nerd-fonts-fira-code nerd-fonts-source-code-pro nerd-fonts-terminus nvidia-xrun otf-powerline-symbols-git package-query slack-desktop steam steam-fonts urxvt-resize-font-git
EOL
) &&

# Official packages
pacman --noconfirm -Sy acpi alsa-utils awesome bash-completion bash-language-server bbswitch blueman bluez-utils cdrtools compton ctags dialog docker docker-compose dvdbackup efibootmgr fd firefox fzf git gvfs-google handbrake imagemagick iw jq kicad libdvdcss light linux-headers lua52 luarocks mpd mplayer ncmpcpp neofetch noto-fonts-emoji ntp nvidia nvidia-settings openssh os-prober otf-font-awesome otf-overpass powerline powertop python-pip qtcreator ranger rofi rsync rxvt-unicode thefuck tigervnc transmission-qt ttf-dejavu ttf-fira-code ttf-fira-mono ttf-font-awesome vicious virtualbox w3m wget wpa_supplicant xbindkeys xclip xf86-input-synaptics xf86-video-intel xf86-video-nouveau xf86-video-vesa xorg-bdftopcf xorg-docs xorg-font-util xorg-fonts-100dpi xorg-fonts-75dpi xorg-fonts-encodings xorg-iceauth xorg-luit xorg-mkfontscale xorg-server xorg-server-common xorg-server-devel xorg-server-xdmx xorg-server-xephyr xorg-server-xnest xorg-server-xvfb xorg-server-xwayland xorg-sessreg xorg-setxkbmap xorg-smproxy xorg-twm xorg-x11perf xorg-xauth xorg-xbacklight xorg-xclock xorg-xcmsdb xorg-xcursorgen xorg-xdm xorg-xdpyinfo xorg-xdriinfo xorg-xev xorg-xgamma xorg-xhost xorg-xinit xorg-xinput xorg-xkbcomp xorg-xkbevd xorg-xkbutils xorg-xkill xorg-xlsatoms xorg-xlsclients xorg-xmodmap xorg-xpr xorg-xprop xorg-xrandr xorg-xrdb xorg-xrefresh xorg-xset xorg-xsetroot xorg-xvinfo xorg-xwininfo xorg-xwud xterm yajl zsh zsh-syntax-highlighting zsh-theme-powerlevel9k &&

#######################
### ENABLE SERVICES ###
#######################

systemctl enable bluetooth &&
systemctl enable xdm &&
systemctl enable powertop &&
systemctl enable ntp &&
systemctl enable dhcp &&

# Tidy up
rm /arch-base.sh &&

# Leave. Be gone. Go home.
echo "Done, exit chroot and reboot."
