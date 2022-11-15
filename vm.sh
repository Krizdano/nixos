#/usr/bin/env sh

mkdir $HOME/Downloads
mkdir $HOME/Pictures 
pushd $HOME/nixos 
cp -r wallpapers $HOME/Pictures 
cp -r .themes $HOME 
cp sway_extraconf/extraconf $HOME/.config/sway 
popd
