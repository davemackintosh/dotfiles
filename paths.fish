fish_add_path - g"$HOME/.local/bin"
fish_add_path -g "$HOME/bin"
fish_add_path -g "$(go env GOPATH)/bin"
fish_add_path -g "$HOME/.asdf/installs/python/3.12.2/bin"
fish_add_path -g "$HOME/.asdf/installs/rust/1.76.0/bin"
fish_add_path -g "$HOME/.asdf/installs/nodejs/21.6.2/bin"

eval "$(direnv hook fish)"
