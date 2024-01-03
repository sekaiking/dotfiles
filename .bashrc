# ~~~~~~~~~~~~~~~~~~ Only execute this file if running interactively
case $- in
    *i*) ;;
    *) return;;
esac

# ~~~~~~~~~~~~~~~~~~ Shell configs

if command -v shopt >/dev/null 2>&1; then
  shopt -s histappend # append to the history file, don't overwrite it
  shopt -s checkwinsize # check the window size after each command and, if necessary, update the values of LINES and COLUMNS.

  # enable programmable completion features 
  if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi
  fi
fi

color_prompt=yes 

# ~~~~~~~~~~~~~~~~~~ Installs

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ~~~~~~~~~~~~~~~~~~ Variables 

export HISTCONTROL=ignoreboth
export HISTFILE=~/.bash_history
export HISTSIZE=25000
export SAVEHIST=25000

export EZA_COLORS='di=38;5;87:ln=38;5;75:so=38;5;176:pi=38;5;135:ex=38;5;32:bd=38;5;87:cd=38;5;87:su=38;5;160:sg=38;5;160:tw=38;5;222:ow=38;5;222'

export NOTES="$HOME/9alam"
export REPOS="$HOME/Repos"
export TEMP="$HOME/Tmp"
export SCRIPTS="$HOME/Scripts"

export PATH=$PATH:/opt/nvim/bin:/opt/gh/bin:/opt/oh-my-posh/bin:/opt/eza/bin:/opt/zoxide/bin:/opt/go/bin

# ~~~~~~~~~~~~~~~~~~ Load Bash Files 

bash_files=(".bash_aliases" ".bash_functions")
for file in "${bash_files[@]}"
do
  if [[ -f "$file" ]]; then
    source "$file"
  fi
done

# ~~~~~~~~~~~~~~~~~~ Welcome

if ! [[ -v TMUX ]]; then
  neofetch
fi

eval "$(oh-my-posh init bash --config ~/.config/theme.omp.json)"

eval "$(zoxide init bash)"
