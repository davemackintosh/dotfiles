# My dotfiles

> If you're looking for my [neovim dotfiles, they're here](https://github.com/davemackintosh/nvim)

Dotfiles that I use across all my systems (Mac, Arch Linux, Debian and iOS iSH, Android Termux).

Requires:

* [zsh](https://zsh.sourceforge.io)
* [oh-my-zsh](https://ohmyz.sh/#install)
* [tmux](https://github.com/tmux/tmux)
* [direnv](https://direnv.net)
* [thefuck](https://pypi.org/project/thefuck/)
* [goenv](https://github.com/syndbg/goenv)

```
git clone --recursive https://github.com/davemackintosh/dotfiles.git ~/dotfiles &&
~/dotfiles/install.zsh`
```

# Keybindings

## `tmux`

A very stock keybinding setup.

`ctrl+b` is the leader.
`ctrl+b I` install zplug plugins.
`ctrl+b U` update zplug.
`ctrl+b ]` enter copy-mode

# FAQs

## I'm not able to commit, something about signing commits.

> If you don't want to sign your commits, remove `gpgsign = true` from `~/.gitconfig` and the `signingkey` from `[user]`

I sign all my commits these days and this is _my_ config, if you are able you should to.

[I want to sign my commits](https://docs.github.com/en/authentication/managing-commit-signature-verification/signing-commits)

You can then edit `~/.gitconfig` and set your `signingkey`

## Why doesn't git ask me for my github username and password?

I spend much of my time writing private go packages so never need to clone from https://github.com. Thus I have a `insteadOf` to do this for me in my `~/.gitconfig`.

Remove the `[url "git@github.com:"]` from `~/.gitconfig` and try again.
