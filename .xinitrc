bash $HOME/.config/feh/random-wallpaper.sh & 
clipmenud &
redshift -c $HOME/.config/redshift/redshift.conf &
picom --experimental-backend -b
flameshot & disown
exec awesome
