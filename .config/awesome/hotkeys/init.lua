---------------------------------------------------------------------------
--- Módulo de hotkeys personalizados para awful.hotkeys_widget
--
-- Este archivo centraliza la carga de todos los atajos de teclado
-- personalizados que se mostrarán en el widget de ayuda de AwesomeWM
-- (usualmente accesible con Mod+s)
--

-- ========================================================
-- Tabla de módulos de hotkeys
-- ========================================================
-- Cada entrada carga un archivo de definición de atajos
-- para una aplicación específica. Estos se mostrarán en
-- el widget de ayuda cuando la aplicación esté activa.

local keys = {
  -- Hotkeys personalizados para Kitty terminal
  -- Carga desde el módulo local (misma carpeta)
  kitty = require("hotkeys.kitty"),
  
  -- Hotkeys para Vim/Neovim (desde AwesomeWM oficial)
  -- Muestra atajos cuando vim está enfocado
  vim = require("awful.hotkeys_popup.keys.vim"),
  
}

-- ========================================================
-- Return keys
-- ========================================================
-- Retorna la tabla de hotkeys para que pueda ser usada
-- por el sistema de ayuda de AwesomeWM
return keys
