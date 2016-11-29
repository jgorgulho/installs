#!/bin/env bash
sudo dnf install -y @^server-product-environment \
@admin-tools @authoring-and-publishing @books \
@c-development @cloud-management @container-management \
@development-tools @editors @headless-management \
@printing @server-hardware-support @system-tools \
@text-internet @virtualization-headless \
tmux tuned vim git python-pip perl-core \
https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
https://github.com/downloads/djmelik/archey/archey-0.2.6-6.noarch.rpm \
ruby-devel libxml2-devel rubygem-rails rubygem-sqlite3 rubygem-coffee-rails \ 
rubygem-sass-rails rubygem-uglifier rubygem-jquery-rails rubygem-turbolinks \
rubygem-jbuilder rubygem-sdoc rubygem-spring rubygem-byebug \
rubygem-web-console nodejs npm liffi redhat-rpm-config
sudo pip install --upgrade pip
sudo pip install powerline-status
sudo gem install jekyll
sudo systemctl enable tuned
git clone https://github.com/jgorgulho/dotfiles.git /home/jgorgulho/.dotfiles
ln -fs /home/jgorgulho/.dotfiles/.bashrc /home/jgorgulho/.bashrc
mkdir /home/jgorgulho/installs
wget http://prdownloads.sourceforge.net/hplip/hplip-2.16.11.run
mv hplip-2.16.11.run /home/jgorgulho/installs
