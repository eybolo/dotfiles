# Actualiza variables de entorno para las sesiones gráficas iniciadas con startx.
# Necesario para que Gnome Keyring y otros servicios de DBus funcionen correctamente.
# Especialmente usado para vscode
dbus-update-activation-environment --all 

# Cambia el fondo de pantalla con un script personalizado que usa feh.
bash $HOME/.config/feh/random-wallpaper.sh &

# Daemon que gestiona el portapapeles de forma persistente entre aplicaciones.
greenclip daemon &

# Ajusta la temperatura del color de la pantalla según la hora (menor luz azul).
redshift -c $HOME/.config/redshift/redshift.conf &

# Compositor para efectos gráficos (transparencias, sombras). Iniciado en segundo plano.
picom --config ~/.config/picom/picom.conf -b

# Lanzador de capturas de pantalla. Usar "disown" evita que el proceso muera al cerrar la terminal.
flameshot & disown

# Espera 2 segundos para evitar errores si X todavía inicia, luego lanza notificador.
( sleep 2 && dunst ) &

# Automonta dispositivos automáticamente (udisks2) y abre con Thunar.
udiskie -t -n -f thunar &

# Inicia el window manager AwesomeWM.
exec awesome