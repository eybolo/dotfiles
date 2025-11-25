-- ========================================================
-- AwesomeWM Main Configuration File (rc.lua)
-- ========================================================
-- Archivo principal que carga todos los módulos y configura
-- el window manager. Este archivo orquesta la inicialización
-- completa de AwesomeWM.

-- ========================================================
-- LuaRocks Support
-- ========================================================
-- Permite usar paquetes instalados con LuaRocks
-- Si LuaRocks no está instalado, simplemente se ignora
pcall(require, "luarocks.loader")

-- ========================================================
-- Core Dependencies
-- ========================================================
require("awful.autofocus")              -- Autofocus automático de ventanas
local beautiful = require("beautiful")  -- Sistema de temas

-- ========================================================
-- Color Palette (Load First)
-- ========================================================
-- Los colores deben cargarse ANTES del tema para estar
-- disponibles globalmente en todos los módulos
require("themes.colors")

-- ========================================================
-- Theme Initialization
-- ========================================================
-- Carga el tema principal (fuentes, colores UI, iconos, etc.)
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/theme.lua")

-- ========================================================
-- Notification System
-- ========================================================
-- Deshabilita D-Bus para notificaciones (evita conflictos)
package.loaded["naughty.dbus"] = {}


-- ========================================================
-- Configuration Modules
-- ========================================================
require("configuration.keys")      -- Atajos de teclado y mouse
require("configuration.layouts")   -- Layouts disponibles (tile, floating, etc.)
require("configuration.rules")     -- Reglas para ventanas y aplicaciones

-- ========================================================
-- User Interface Modules
-- ========================================================
require("ui.bar")                  -- Barra superior/inferior (wibar)