 
#!/bin/env bash
ROOT=$(pwd)
mkdir tempGnomeExtensionsInstallFolder &&
cd tempGnomeExtensionsInstallFolder &&
rm -rf gnome-shell-extension-caffeine &&
git clone git://github.com/eonpatapon/gnome-shell-extension-caffeine.git &&
cd gnome-shell-extension-caffeine &&
./update-locale.sh &&
glib-compile-schemas --strict --targetdir=caffeine@patapon.info/schemas/ caffeine@patapon.info/schemas &&
cp -r caffeine@patapon.info ~/.local/share/gnome-shell/extensions
