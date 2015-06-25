export LANG=en_US.UTF-8
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="avit"

plugins=(git)

source $ZSH/oh-my-zsh.sh

for file in ~/.{bash_prompt,aliases,functions,path,extra,exports,dockerfunc}; do
  [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
done
unset file

fortune -a -s | lolcat
