-- ========================================================
-- AwesomeWM Theme Configuration
-- ========================================================
-- Tema principal para AwesomeWM con esquema de colores neón/cyberpunk
-- Los colores se cargan desde themes/colors.lua (variable global)

-- ========================================================
-- Dependencias
-- ========================================================
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local beautiful = require("beautiful")

-- ========================================================
-- Paths y Configuración Base
-- ========================================================
local layout_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/icons/layouts/"

-- ========================================================
-- Inicialización del Theme
-- ========================================================
theme = {}

-- ========================================================
-- Fuentes
-- ========================================================
beautiful.font = "Hack Nerd Font 9"           -- Fuente general del sistema
beautiful.taglist_font = "Hack Nerd Font 14"  -- Fuente para los tags
theme.font = "Hack Nerd Font Bold 10"         -- Fuente para widgets y textos
theme.iconfont = "Hack Nerd Font Mono 14"     -- Fuente para iconos

-- ========================================================
-- Hotkeys Popup Theme
-- ========================================================
theme.hotkeys_bg = colors.black
theme.hotkeys_fg = colors.white
theme.hotkeys_border_width = 2
theme.hotkeys_border_color = colors.magenta
theme.hotkeys_modifiers_fg = colors.cyan
theme.hotkeys_label_bg = colors.yellow
theme.hotkeys_label_fg = colors.black
theme.hotkeys_font = "Hack Nerd Font 10"
theme.hotkeys_description_font = "Hack Nerd Font 9"
theme.hotkeys_group_margin = 15

-- ========================================================
-- Colores de Fondo (Backgrounds)
-- ========================================================
theme.bg_normal = colors.black                -- Fondo normal de ventanas
theme.bg_focus = colors.brightblack           -- Fondo de ventana enfocada
theme.bg_urgent = colors.black                -- Fondo de ventana urgente
theme.bg_minimize = colors.red                -- Fondo de ventana minimizada
theme.bg_systray = colors.black               -- Fondo del system tray

-- ========================================================
-- Colores de Texto (Foregrounds)
-- ========================================================
theme.fg_normal = colors.white                -- Texto normal
theme.fg_focus = colors.blue                  -- Texto de ventana enfocada
theme.fg_urgent = colors.brightred            -- Texto de ventana urgente
theme.fg_minimize = colors.brightblack        -- Texto de ventana minimizada

-- ========================================================
-- Bordes y Espaciado
-- ========================================================
theme.useless_gap = dpi(3)                    -- Espacio entre ventanas
theme.border_width = dpi(2)                   -- Ancho del borde de ventanas
theme.border_normal = "#000000"               -- Color de borde normal (negro)

-- ========================================================
-- System Tray
-- ========================================================
theme.systray_icon_spacing = dpi(4)           -- Espaciado entre iconos del systray

-- ========================================================
-- Taglist (Workspaces)
-- ========================================================
theme.taglist_spacing = dpi(6)                -- Espaciado entre tags
theme.taglist_fg_focus = colors.magenta       -- Color del tag activo
theme.taglist_fg_empty = colors.gris          -- Color de tags vacíos
theme.taglist_fg_urgent = colors.green        -- Color de tag con ventana urgente

-- ========================================================
-- Layout Icons
-- ========================================================
theme.layout_floating = layout_icon_path .. "floating.png"
theme.layout_fullscreen = layout_icon_path .. "fullscreen.png"
theme.layout_tilebottom = layout_icon_path .. "tilebottom.png"
theme.layout_tileleft = layout_icon_path .. "tileleft.png"
theme.layout_tile = layout_icon_path .. "tile.png"
theme.layout_tiletop = layout_icon_path .. "tiletop.png"

-- ========================================================
-- Return Theme
-- ========================================================
return theme