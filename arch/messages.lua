#!/bin/env lua

local colors = require("./ansi-colours")

local messages = {
  en_GB = {
    firstDiskConfirm = colors([[ 
This script is best run on a new SSD or a system which you don't care about.

Please read everything you see, then read it again and again. If you miss something, it's your fault.

%{yellow} If you have a LUKS/LVM setup already, you'll need to dmsetup info -C and dmsetup remove {name} each one first otherwise this script will erase your hard drive for and then fail due to an in use partition. %{reset}

%{blue} I'm going to try and install Arch with:

* LUKS, (root, home) and a swap drive that re-encrypts on boot
* LVM (swap, root, home)
* X-Org
* Awesome WM
* My Dotfiles

This %{red underline}*will destroy*%{reset blue} your hard drive in a fully automated way so you have to be 100% sure this is exactly what you want before agreeing below. %{reset}

%{underline}Are you sure you want to destroy the world as you know it and start fresh? %{reset}
    ]]),

    secondDiskConfirm = colors([[
%{yellow}Seriously? Are you sure, there's no going back at *any* point in this. Once I start, this thing is dead until I finish. Make sure you have a charger plugged in, you've back everything up (documents, downloads, work folders, dotfiles, ssh/GPG/Public/Private keys, etc) and come back and ask me again. I'm not resposible what you do with this thing.%{reset} 
    ]]),

    finalDiskConfirm= colors([[
%{red} Okay, well. As long as you're sure, I'm going to partition and wipe this drive entirely. It will be encrypted using LUKS encryption and then I'll install LVM on top of that to enable snapshots and wayyyyy easier volume management without the sector bullcrap. I'm going to ask you one more time %{reset}

%{redbg white bright} This is your last chance to kill me where I stand and back yo shit up. You one bad bitch if you haven't backed everything up and you're still here asking me to wipe your hard drive permanently. There's literally no way back after this, I'm going to write your disk clean.%{reset}

Please type the phrase "erase all my data please"
    ]]),

    failedFinalConfirmation = colors("%{green bright}Probably wise, make sure everything is backed up and you have a charger plugged in then come back and we'll try this again :)%{reset}")
  }
}

return messages
