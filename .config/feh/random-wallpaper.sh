#!/bin/bash
while true; do
	# Elegir una carpeta al azar
	random_folder=$(find ~/media/wallpaper -mindepth 1 -maxdepth 1 -type d | shuf -n1)

	# Aplicar feh a todas las imagenes de esa carpeta
    feh --randomize --bg-fill "$random_folder"/*

	# Cada 10 min
	sleep 900
done
