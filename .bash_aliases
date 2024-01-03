#!/bin/bash

alias cfg="/usr/bin/git --git-dir=\"$HOME/.dotfiles/\" --work-tree=\"$HOME\""

alias n="nvim"

alias ungz="tar --directory $TEMP/unzipped -xvzf"

alias so="source ~/.bashrc"

alias ..="z .."

if [[ -f '/opt/eza/bin/eza' ]]; then
  alias ls='/opt/eza/bin/eza --icons'
fi

alias l='ls -lF'
alias lt='l -TL'
alias ll='ls -alF'
alias llt='ll -TL'

# WSL only commands
if [[ $(grep Microsoft /proc/version) ]]; then
  alias bye="shutdown.exe /s /f /t 10"
  alias seeu="shutdown.exe /h"
  alias copy="clip.exe"
  alias paste="powershell.exe -command 'Get-Clipboard' | tr -d '\r' | head -n -1"
fi
