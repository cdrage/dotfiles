#!/bin/bash

zsh_install() {
  sudo apt-get install -y zsh
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  cp ~/.zshrc ~/
}

vim_install() {
  sudo apt-get install -y vim
  git clone git://github.com/charliedrage/vim.git ~/.vim
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  cp ~/.vim/.vimrc ~/
  vim +PluginInstall +qall 
}

dotfiles_install() {
  cp .cli .extra ~/
}

terminator_install() {
  sudo apt-get install -y terminator
  cp .config/terminator/config ~/.config/terminator/config
}

tmux_install() {
  sudo apt-get install tmux 
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  cp ~/.tmux.conf ~/
}

dotfiles_backup() {
  for file in ~/.{cli,extra,tmux.conf,zshrc}; do
    cp $file .
  done
}
