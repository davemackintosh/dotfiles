# My setup

## I have recently moved to Arch on my laptop, this is now just a clusterfuck of scripts until I find time to update them to be platform agnostic.

on Termux first you need to run

`pkg i -y wget curl`

then run `wget https://raw.githubusercontent.com/davemackintosh/dotfiles/master/davenv.sh -O - | bash`

It will install everything I use on my phone/tablet/laptop for development.

This is my incredibly cobbled together VIM setup. I'm still learning VIM and it's ecosystem. This is targetted at making writing JS super fun. I run this on my phone (Termux) and my Laptop (Kubuntu/Konsole)

Clone this repo and run `make`, should run all the tasks to setup both your laptop and your phone depending on where you run it.

## TODO:

* ~Try to get better split control.~
  * ~Stop NERDTree being open in 2 buffers when opening.~ Learn how to use VIM properly Dave.
  * ~Stop NERDTree opening file in a new split next to the other NERDTree buffer~ `nvim .` causes it to open NERDTree in the second buffer.
* Make setup responsive to device
  * Autohide NERDtree on mobile portrait mode on phone
  * Autoshow (if not manually closed) NERDTree in landscape/DEX mode.
* Better pointer support
* Get better/faster autocomplete for JS files.
  * Tried disabling `omni` for JS files but no benefit.
* Snippets
* Containers
  * Get `docker` installed or some way to proot environments safely on android.
  * Manage them safely.
* ~Ctags~
  * Stole from https://medium.com/adorableio/modern-javascript-ctags-configuration-199884dbcc1
* Workspace/session saving.
* Other stuff... 
