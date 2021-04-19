# Editor specifics.
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_HOME="$HOME/Android/Sdk"
export ANDROID_NDK_HOME="$ANDROID_HOME/ndk/23.0.7123448"
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-11.0.10.0.9-0.fc33.x86_64"

# System paths.
export PATH="$PATH:$HOME/node_modules/.bin"
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$ANDROID_SDK_HOME/build-tools/30.0.2"
export PATH="$PATH:$ANDROID_SDK_HOME/platform-tools"

# Language specifics.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
if ! [ "$OS" = "Android" ]; then
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

eval $(thefuck --alias)

PATH="/home/dave/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/dave/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/dave/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/dave/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/dave/perl5"; export PERL_MM_OPT;
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"