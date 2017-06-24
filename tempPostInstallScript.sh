#!/bin/env bash
echo 'Downloading hplip and lastpass for later install...'
mkdir /home/jgorgulho/toInstall
wget -O hplip.run "http://downloads.sourceforge.net/project/hplip/hplip/3.16.11/hplip-3.16.11.run?r=http%3A%2F%2Fhplipopensource.com%2Fhplip-web%2Finstall%2Finstall%2Findex.html&ts=1480467242&use_mirror=netassist"
wget -O lastpass.tar.bz2 "https://lastpass.com/lplinux.tar.bz2"
echo 'Moving hplip and lastpass to user folder...'
mv hplip.run /home/jgorgulho/toInstall
mv lastpass.tar.bz2 /home/jgorgulho/toInstall
chown -R jgorgulho /home/jgorgulho/toInstall
chown -R jgorgulho /home/jgorgulho/toInstall/*

echo "Cloning dotfiles from github repo to root..."
git clone https://github.com/jgorgulho/dotfiles /root/.dotfiles
ln -sf /root/.dotfiles/.bashrc /root/.bashrc
echo "Cloning dotfiles from github repo to user..."
git clone https://github.com/jgorgulho/dotfiles /home/jgorgulho/.dotfiles
ln -sf /home/jgorgulho/.dotfiles/.bashrc /home/jgorgulho/.bashrc
chown -R jgorgulho /home/jgorgulho/.dotfiles
chown -R jgorgulho /home/jgorgulho/.dotfiles/.*
chown -R jgorgulho /home/jgorgulho/.bashrc

echo "Installing Jekyll..."

if [ "$(gem list jekyll -i)" == 'false' ]; then
	echo "Jekyll being installed"
    gem install jekyll
fi


echo "Enabling tuned..."
sudo systemctl enable tuned
echo "Enabling powertop..."
sudo systemctl enable powertop
