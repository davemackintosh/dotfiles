# My dotfiles

> If you're looking for my [neovim dotfiles, they're here](https://github.com/davemackintosh/nvim)

Dotfiles that I use across all my systems (Mac, Linux, iOS iSH, Android Termux).

Requires:

* [zsh](https://zsh.sourceforge.io)
* [Startship](https://starship.rs)
* [GNU screen](https://www.gnu.org/software/screen/)

Technically, you don't __need__ the below *but* you'll see non-fatal errors about them not being present on each shell. I take no responsibility in making all these quiet about their being missing as I use them all regularly.

* [homebrew](https://brew.sh) _optional_
* [direnv](https://direnv.net) _optional_
* [thefuck](https://pypi.org/project/thefuck/) _optional_
* [goenv](https://github.com/syndbg/goenv) _optional_
* [luaver](https://dhavalkapil.com/luaver/) _optional_

# Install

```
git clone --recursive https://github.com/davemackintosh/dotfiles.git ~/dotfiles &&
~/dotfiles/install.zsh`
```

# FAQs

## I'm not able to commit, something about signing commits.

> If you don't want to sign your commits, remove `gpgsign = true` from `~/.gitconfig` and the `signingkey` from `[user]`

I sign all my commits these days and this is _my_ config, if you are able you should to.

[I want to sign my commits](https://docs.github.com/en/authentication/managing-commit-signature-verification/signing-commits)

You can then edit `~/.gitconfig` and set your `signingkey`

## Why doesn't git ask me for my github username and password?

I spend much of my time writing private go packages so never need to clone from https://github.com. Thus I have a `insteadOf` to do this for me in my `~/.gitconfig`.

Remove the `[url "git@github.com:"]` from `~/.gitconfig` and try again.
