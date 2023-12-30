#!/bin/bash

alias cfg='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

alias n='nvim'

alias ungz="tar --directory $TEMP/unzipped -xvzf"

alias bye="/mnt/c/Windows/System32/shutdown.exe /s /f /t 10"

alias seeu="/mnt/c/Windows/System32/shutdown.exe /h"

alias so="source ~/.bashrc"

alias ..="cd .."

if [[ -f '/opt/eza/bin/eza' ]]; then
  alias ls='/opt/eza/bin/eza --icons'
fi

alias l='ls -lF'
alias lt='l -TL 2'
alias ll='ls -alF'
alias llt='ll -TL 2'
