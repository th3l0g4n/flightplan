#!/usr/bin/env bash

echo -e "Host *\n  StrictHostKeyChecking no" >> $HOME/.ssh/config
ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -N ''
eval "$(ssh-agent -a $SSH_AUTH_SOCK)"
ssh-add $HOME/.ssh/id_rsa

sudo mkdir /home/$SSH_USER
sudo useradd -d /home/$SSH_USER -s /bin/bash $SSH_USER -G sudo
sudo chown $SSH_USER:$SSH_USER /home/$SSH_USER

sudo mkdir /home/$SSH_USER/.ssh
sudo chmod 700 /home/$SSH_USER/.ssh
cat $HOME/.ssh/id_rsa.pub | sudo tee --append /home/$SSH_USER/.ssh/authorized_keys
sudo chown -R $SSH_USER:$SSH_USER /home/$SSH_USER

sudo mkdir /home/$SUDO_USER
sudo useradd -d /home/$SUDO_USER -s /bin/bash $SUDO_USER
sudo chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER

echo -e "\n$SSH_USER ALL=($SUDO_USER) NOPASSWD: ALL" | sudo tee --append /etc/sudoers
sudo service ssh reload