#!/bin/env bash
echo "deltarpm=1" | sudo tee -a /etc/dnf/dnf.conf
sudo dnf update -y 
# Spotify
sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-spotify.repo
# Skype
sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-skype.repo
# Flash
sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-flash-plugin.repo
# Multimedia
sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-multimedia.repo
if [ `getconf LONG_BIT` = "64" ]
then
    sudo dnf install -y "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
    sudo dnf install -y "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
    sudo dnf install -y "https://github.com/atom/atom/releases/download/v1.11.1/atom.x86_64.rpm"
else
    sudo dnf install -y "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
    sudo dnf install -y "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm" 
fi
sudo dnf update -y 
sudo dnf install -y tmux \
docker-vim vim-enhanced vim-common vim-filesystem \
git python-pip perl-core spotify-client vlc \
java-openjdk icedtea-web unzip chromium skype \
flash-plugin libdvdcss deltarpm powertop skanlite \
gimp inkscape setroubleshoot nmap ntfs-3g w3m \
youtube-dl lynx cups cups-filters ghostscript \
hplip hpijs nss-mdns fortune-mod cowsay powerline \
tmux-powerline vim-plugin-powerline \
dejavu-sans-mono-fonts google-droid-sans-mono-fonts \
mozilla-fira-mono-fonts levien-inconsolata-fonts
sudo dnf install ruby-devel rubygems-devel make
sudo gem install jekyll
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
