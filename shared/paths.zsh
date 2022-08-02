# Linux specifics.
# export ANDROID_HOME="$HOME/Android/Sdk"
# export ANDROID_SDK_HOME="$HOME/Android/Sdk"
# export ANDROID_NDK_HOME="$ANDROID_HOME/ndk/23.0.7123448"

export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_NDK_HOME="$ANDROID_HOME/ndk/23.0.7599858"
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# System paths.
export PATH="$PATH:$HOME/node_modules/.bin"
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$ANDROID_SDK_HOME/build-tools/30.0.2"
export PATH="$PATH:$ANDROID_SDK_HOME/platform-tools"
export PATH="$PATH:$HOME/Library/Python/3.8/bin"
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

# cd "$HOME/VulkanSDK/1.2.198.0/"; source ./setup-env.sh && cd

# export MOLTENVK_HOME="$HOME/www/cpp/MoltenVK/MoltenVK"

# Language specifics.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
eval $(thefuck --alias)
