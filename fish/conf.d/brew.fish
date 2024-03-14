set -l brew_paths /opt/homebrew/bin /usr/local/bin /usr/bin /bin /opt/homebrew/sbin /usr/local/sbin /usr/sbin /sbin

for brew_path in $brew_paths
    if contains $brew_path $PATH
        continue
    end

    if test -f $brew_path/brew
        set PATH $brew_path $PATH
        break
    end
end

if not type -q brew
    echo "Please install 'brew' first!"
end

alias bl bleaves
alias bu 'brew update && brew outdated && brew upgrade && brew cleanup'
alias bi 'brew install'
alias br 'brew rmtree'
alias bar 'brew autoremove'
