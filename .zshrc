# config
export LANG=en_US.UTF-8
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="avit"

# plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# load the .cli and .extra bash files
for file in ~/.{cli,extra}; do
  [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
done
unset file


# Show fortune?
# fortune -a -s

# ??
autoload -U +X bashcompinit && bashcompinit
