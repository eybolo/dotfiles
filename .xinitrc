bash $HOME/.config/feh/random-wallpaper.sh & 
betterlockscreen -u "$HOME/image/wallpaper/keyboard.png"
clipmenud &
redshift -c $HOME/.config/redshift/redshift.conf &
picom --experimental-backend -b
exec awesome
