# My dotfiles

> If you're looking for my [neovim dotfiles, they're here](https://github.com/davemackintosh/nvim)

Dotfiles that I use across all my systems (Mac, Linux, iOS iSH, Android Termux).

Requires:

* fish
* Starship

Technically, you don't __need__ the below *but* you'll see errors about them not being present on each shell if you don't edit both `install.zsh` and `.zshrc`

* [direnv](https://direnv.net)
* python & pip

# Install

```
git clone --recursive https://github.com/davemackintosh/dotfiles.git ~/dotfiles &&
bash ~/dotfiles/install.zsh` # yes, even though I use fish I wrote the installer in bash/zsh.
```

# FAQs (no one has ever asked me any of these but hey ho)

## What is most of this?

I have a work Mac which is fine. Dotfiles work on all systems however most of the dotfiles in this repo are for my personal computer which I have riced the heck out of.

![image](https://user-images.githubusercontent.com/1430657/231270294-853108e5-78a9-4cb3-933f-e997ff4d23e6.png)
![image](https://user-images.githubusercontent.com/1430657/233860547-727e911c-04ee-4852-a681-a68e0c91e289.png)

## I'm not able to commit, something about signing commits.

> If you don't want to sign your commits, remove `gpgsign = true` from `~/.gitconfig` and the `signingkey` from `[user]`

I sign all my commits these days and this is _my_ config, if you are able you should to.

[I want to sign my commits](https://docs.github.com/en/authentication/managing-commit-signature-verification/signing-commits)

You can then edit `~/.gitconfig` and set your `signingkey`

