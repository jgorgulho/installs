#!/bin/env bash
sudo dnf update -y 
echo "deltarpm=1" | sudo tee -a /etc/dnf/dnf.conf
# Spotify
sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-spotify.repo
# Skype
sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-skype.repo
# Flash
sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-flash-plugin.repo
# Multimedia
sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-multimedia.repo
sudo dnf install -y tmux docker-vim vim-enhanced vim-common vim-filesystem git python-pip perl-core "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm" "https://github.com/atom/atom/releases/download/v1.11.1/atom.x86_64.rpm" gnome-themes-standard spotify-client vlc java-openjdk icedtea-web simple-scan unzip gnome-tweak-tool chromium skype flash-plugin libdvdcss deltarpm powertop gimp inkscape setroubleshoot nmap ntfs-3g w3m youtube-dl lynx cups cups-filters ghostscript hplip hpijs nss-mdns
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
sudo systemctl enable powertop
sudo systemctl start powertop