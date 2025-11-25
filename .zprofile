# ~/.bash_profile

# Auto-inicio del entorno gráfico:
# Solo lanza startx al loguearme en TTY1 y únicamente si no hay un servidor gráfico activo.
# Evita lanzar X en sesiones SSH/TTY adicionales. Esto actúa como reemplazo de un display manager.
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi
