#!/bin/env bash
cat << EOF > /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome - \$basearch
baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF
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
sudo dnf install -y @^workstation-product-environment \
@admin-tools @authoring-and-publishing @books @c-development \ 
@design-suite @development-tools @editors \
@headless-management @office @system-tools @text-internet \
@printing tmux vim git python-pip perl-core \
https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
https://github.com/downloads/djmelik/archey/archey-0.2.6-6.noarch.rpm \
paper-icon-theme https://github.com/atom/atom/releases/download/v1.11.1/atom.x86_64.rpm \
arc-theme gtk-murrine-engine gnome-themes-standard spotify-client vlc java-openjdk icedtea-web \
simple-scan unzip thunderbird gnome-tweak-tool chromium  unrar skype flash-plugin libdvdcss \
google-chrome-stable
sudo pip install --upgrade pip
sudo pip install powerline-status
git clone https://github.com/jgorgulho/dotfiles.git /home/jgorgulho/.dotfiles
ln -fs /home/jgorgulho/.dotfiles/.bashrc /home/jgorgulho/.bashrc
mkdir /home/jgorgulho/installs
wget http://prdownloads.sourceforge.net/hplip/hplip-2.16.11.run
wget https://lastpass.com/lplinux.tar.bz2
# Enable Disk I/O Scheduler for ssd
sudo systemctl enable fstrim.timer 
