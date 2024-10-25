bash $HOME/.config/feh/random-wallpaper.sh & 
clipmenud &
redshift -c $HOME/.config/redshift/redshift.conf &
picom --config ~/.config/picom/picom.conf -b
flameshot & disown
exec awesome
