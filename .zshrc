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

# added by travis gem
[ -f /home/wikus/.travis/travis.sh ] && source /home/wikus/.travis/travis.sh

autoload -U +X bashcompinit && bashcompinit


complete -o nospace -C /home/wikus/syncthing/files/dev/go/src/github.com/openshift/odo/odo odo








































