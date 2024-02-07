# Modules

# Lang
export LANG=en_US.UTF-8

# ZSH stuff
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="avit"

# Plugins
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Source all the files
for file in ~/.{cli,extra}; do
  [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
done
unset file

# Autoload bash completion?
autoload -U +X bashcompinit && bashcompinit

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
