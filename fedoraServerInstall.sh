#!/bin/env bash
sudo dnf update
echo "deltarpm=1" | sudo tee -a /etc/dnf/dnf.conf
sudo dnf groupinstall -y Fedora\ Server\ Edition Administration\ Tools Authoring\ and\ Publishing Books\ and\ Guides C\ Development\ Tools\ and\ Libraries Cloud\ Management\ Tools Container\ Management Development\ Tools Editors Headless\ Management System\ Tools Text-based\ Internet Printing Hardware\ Support virtualization-headless
sudo dnf install -y tmux tuned vim git python-pip perl-core "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm" "https://github.com/downloads/djmelik/archey/archey-0.2.6-6.noarch.rpm" ruby-devel libxml2-devel rubygem-rails rubygem-sqlite3 rubygem-coffee-rails rubygem-uglifier rubygem-jquery-rails rubygem-turbolinks rubygem-jbuilder rubygem-sdoc rubygem-spring rubygem-byebug rubygem-web-console nodejs npm libffi redhat-rpm-config
sudo pip install --upgrade pip
sudo pip install powerline-status
sudo gem install jekyll
sudo systemctl enable tuned
if ! [ -d $HOME/.dotfiles ]; then
    git clone https://github.com/jgorgulho/dotfiles.git /home/jgorgulho/.dotfiles
fi
ln -fs /home/jgorgulho/.dotfiles/.bashrc /home/jgorgulho/.bashrc
mkdir /home/jgorgulho/toInstall
wget -O hplip.run "http://downloads.sourceforge.net/project/hplip/hplip/3.16.11/hplip-3.16.11.run?r=http%3A%2F%2Fhplipopensource.com%2Fhplip-web%2Finstall%2Finstall%2Findex.html&ts=1480467242&use_mirror=netassist"
mv hplip.run /home/jgorgulho/toInstall
bash
