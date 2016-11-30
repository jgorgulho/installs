#!/bin/env bash
echo "deltarpm=1" | sudo tee -a /etc/dnf/dnf.conf
echo "
[google-chrome]
name=google-chrome - \$basearch
baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
" | sudo tee /etc/yum.repos.d/google-chrome.repo
# GTK Arc Theme
sudo dnf config-manager --add-repo http://download.opensuse.org/repositories/home:Horst3180/Fedora_24/home:Horst3180.repo
# GTK Paper Icons
sudo dnf config-manager --add-repo http://download.opensuse.org/repositories/home:snwh:paper/Fedora_24/home:snwh:paper.repo
# Spotify
sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-spotify.repo
# Skype
sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-skype.repo
# Flash
sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-flash-plugin.repo
# Multimedia
sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-multimedia.repo
sudo dnf groupinstall -y Development\ And\ Creative\ Workstation \
Administration\ Tools Authoring\ and\ Publishing Books C\ Development\ Tools\ and\ Libraries \
Design\ Suite Development\ Tools Editors \
Headless\ Management Office System\ Tools Text-based\ Internet \
Printing 
sudo dnf install -y tmux vim git python-pip perl-core \
https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
https://github.com/downloads/djmelik/archey/archey-0.2.6-6.noarch.rpm \
paper-icon-theme https://github.com/atom/atom/releases/download/v1.11.1/atom.x86_64.rpm \
arc-theme gtk-murrine-engine gnome-themes-standard spotify-client vlc java-openjdk icedtea-web \
simple-scan unzip thunderbird gnome-tweak-tool chromium  unrar skype flash-plugin libdvdcss \
google-chrome-stable deltarpm
sudo pip install --upgrade pip
sudo pip install powerline-status
if ! [ -d $HOME/.dotfiles ]; then
    git clone https://github.com/jgorgulho/dotfiles.git /home/jgorgulho/.dotfiles
fi
ln -fs /home/jgorgulho/.dotfiles/.bashrc /home/jgorgulho/.bashrc
mkdir /home/jgorgulho/toInstall
wget -O hplip.run "http://downloads.sourceforge.net/project/hplip/hplip/3.16.11/hplip-3.16.11.run?r=http%3A%2F%2Fhplipopensource.com%2Fhplip-web%2    Finstall%2Finstall%2Findex.html&ts=1480467242&use_mirror=netassist"
wget -O lastpass.tar.bz2 "https://lastpass.com/lplinux.tar.bz2"
mv hplip.run toInstall
mv lastpass.tar.bz2 toInstall
# Enable Disk I/O Scheduler for ssd
sudo systemctl enable fstrim.timer 
