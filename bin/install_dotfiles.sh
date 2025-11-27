#!/bin/bash
# ========================================================
# Script de instalación de dotfiles con bare repository
# ========================================================
# Descarga dotfiles desde GitHub y los coloca en $HOME
# usando bare repository. Maneja conflictos automáticamente.
# ========================================================

# Clonar repositorio bare (solo base de datos Git, sin archivos)
git clone --bare https://github.com/eybolo/dotfiles.git $HOME/.dotfiles

# Función para usar Git con el bare repo
# Uso: config status, config add, config commit, config push, etc.
function config {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME "$@"
}

# Crear carpeta para backup de archivos conflictivos
mkdir -p .config-backup

# Intentar extraer archivos del repo a $HOME
config checkout

# Si hay conflictos, hacer backup y reintentar
if [ $? -ne 0 ]; then
    echo "Backing up files that conflict with the checkout..."
    
    # Pipeline: captura archivos conflictivos y los mueve a backup
    # 1. Ejecuta checkout y captura errores
    # 2. Filtra líneas con archivos (las que empiezan con espacios)
    # 3. Lee cada archivo conflictivo
    config checkout 2>&1 \
    | awk '/^\s/ {print $1}' \
    | while read -r file; do
        
        # Crear estructura de directorios en backup
        mkdir -p "$(dirname ".config-backup/$file")"
        
        # Caso especial: conflicto archivo↔directorio
        # Si en tu PC es carpeta pero en repo es archivo (o viceversa)
        # mv falla, así que renombramos primero
        if [ -d "$file" ] && [ ! -d ".config-backup/$file" ]; then
            mv "$file" "$file.backup_dir_conflict"
            mv "$file.backup_dir_conflict" ".config-backup/$file"
        else
            # Movimiento normal de archivo/carpeta
            mv "$file" ".config-backup/$file"
        fi
    done
fi

# Ahora que los conflictos están respaldados, checkout funciona
config checkout

# Ocultar archivos no rastreados en "config status"
# (evita ver todos los archivos de $HOME)
config config status.showUntrackedFiles no

# Inicializar y descargar submódulos (plugins, temas, etc.)
config submodule init
config submodule update
