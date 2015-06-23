ZSH=$HOME/.oh-my-zsh
ZSH_THEME="pure"

plugins=(git)

source $ZSH/oh-my-zsh.sh

for file in ~/.{bash_prompt,aliases,functions,path,extra,exports,dockerfunc}; do
  [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
done
unset file

fortune -a -s | lolcat
