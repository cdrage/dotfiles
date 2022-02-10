# Modules

export LANG=en_US.UTF-8
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="avit"

plugins=(git)

source $ZSH/oh-my-zsh.sh

for file in ~/.{cli,extra}; do
  [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
done
unset file

# fortune -a -s

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

autoload -U +X bashcompinit && bashcompinit

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
