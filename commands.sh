#!/bin/bash

USERNAME=$USER

install_prelim_packages() {
  sudo apt-get update
  sudo apt-get install -y fortune lolcat mosh
}

setup_sudo() { 
  adduser $USERNAME sudo 
  { \
    echo -e "$USERNAME ALL=(ALL) NOPASSWD:ALL";
  } >> /etc/sudoers
}

install_zsh() {
  sudo apt-get install -y zsh
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  cp .zshrc ~/
}

install_vim() {
  sudo apt-get install -y vim
  git clone git://github.com/charliedrage/vim.git ~/.vim
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  cp ~/.vim/.vimrc ~/
  vim +PluginInstall +qall
}

install_dotfiles() {
  cp .* ~/
}

install_terminator() {
  sudo apt-get install -y terminator
  mkdir -p ~/.config/terminator
  cp .config/terminator/config ~/.config/terminator/config
}

install_tmux() {
  sudo apt-get install tmux
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  cp .tmux.conf ~/
}

dotfiles_backup() {
  for file in ~/.{cli,extra,tmux.conf,zshrc}; do
    cp $file .
  done
}

install_docker() {
  curl -sSl https://get.docker.com | sh
  sudo sed -i.bak 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/g' /etc/default/grub
  sudo update-grub
  sudo usermod -aG docker $USERNAME
  echo "LOG OUT, LOG IN TO CONTINUE!"
}

clone_dockerfiles() {
  git clone https://github.com/charliedrage/dockerfiles ~/dockerfiles
}

install_dropbox() {
  cd ~/dockerfiles/dropbox && docker build -t $USERNAME/dropbox .
  docker run -d -e UID=$(id -u) -v ~/.dropbox:/home/.dropbox -v ~/dropbox:/home/Dropbox --name dropbox $USERNAME/dropbox
  sleep 3
  echo "!!!!! Make sure you click the link below then ctrl+c outta there!!!!!"
  docker logs dropbox
}

install_golang() {
  export GO_VERSION=1.5.2
  export GO_SRC=/usr/local/go
  (curl -sSL "https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz" | sudo tar -v -C /usr/local -xz)
}
