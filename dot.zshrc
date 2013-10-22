# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob nomatch notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/x/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# 한글 입력을 위한 정의
INPUTRC=$HOME/.inputrc
LANG=ko_KR.UTF-8
ANDROID_SDK_PATH="/Applications/Android Studio.app/sdk"
PATH=/Applications/Aquamacs.app/Contents/MacOS/bin:$HOME/bin:/opt/local/libexec/ccache:/opt/local/bin:/opt/local/sbin:$PATH:$ANDROID_SDK_PATH/tools:$ANDROID_SDK_PATH/platform-tools:/opt/local/android/ndk
export MANPATH=/opt/local/share/man:$MANPATH:/usr/share/man:/usr/X11R6/man
export DISPLAY=:0.0
export EDITOR="/usr/local/bin/mate -w"
export SVN_EDITOR="/usr/local/bin/mate -w" # /usr/bin/aquamacs
export MANPATH=/opt/local/man:/opt/local/share/man:$MANPATH
export INFOPATH=/opt/local/share/info:$INFOPATH
export GRADLE_HOME=/opt/local/share/java/gradle

# Prompt, PS1 is left, RPS1 is right.
PS1="%m@%n%% "
RPS1="%~"

export INPUTRC LANG PATH SVN_EDITOR PS1 RPS1

alias ls='ls -FGw' # 한글 표시, 디렉토리면 뒤에 / 표시, 확장자별 색상 표시
# alias a='aquamacs'

export CVSROOT=:pserver:dhjang@192.168.50.94:/home/cvs

