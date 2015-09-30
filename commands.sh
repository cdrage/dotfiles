#!/bin/bash

zsh_install() {
  sudo apt-get install -y zsh
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
}

vim_install() {
  sudo apt-get install -y vim
  git clone git://github.com/charliedrage/vim.git ~/.vim
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  mv ~/.vim/.vimrc ~/
  vim +PluginInstall +qall 
}

dotfiles_install() {
  mv .aliases .dockerfunc .exports .functions .tmux.conf .zshrc ~/
}

terminator_install() {
  sudo apt-get install -y terminator
  mv .config/terminator/config ~/.config/terminator/config
}

lxde_config_install() {
  mv .config/openbox/lxde-rc.xml ~/.config/openbox/lxde-rc.xml
}

tmux_install() {
  sudo apt-get install tmux 
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

dotfiles_backup() {
  for file in ~/.{cli,extra,tmux.conf,zshrc}; do
    cp $file .
  done
}
