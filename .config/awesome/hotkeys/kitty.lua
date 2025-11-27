---------------------------------------------------------------------------
--- Hotkeys de Kitty para awful.hotkeys_widget
--
-- Define los atajos de teclado del terminal Kitty que se mostrarán
-- en el widget de ayuda de AwesomeWM (generalmente Mod+s)
--
---------------------------------------------------------------------------

local hotkeys_popup = require("awful.hotkeys_popup.widget")
local kitty = {}

---------------------------------------------------------------------------
-- Función para definir reglas de detección
---------------------------------------------------------------------------
--- Añade reglas para detectar cuándo mostrar los hotkeys de Kitty
--
-- Ejemplo de uso:
--   kitty.add_rules_for_terminal({ rule = { name = { "kitty" }}})
--
-- Esto mostrará los hotkeys solo cuando una ventana tenga 'kitty' en su título.
-- Si no se proporcionan reglas, los hotkeys se mostrarán siempre.
--
-- @function add_rules_for_terminal
-- @tparam table rule Reglas para detectar ventana con Kitty
function kitty.add_rules_for_terminal(rule)
    -- Asignar la misma regla a todos los grupos de hotkeys
    for group_name, group_data in pairs({
        ["kitty: tabs"] = rule,
        ["kitty: windows"] = rule,
        ["kitty: scrolling"] = rule,
    }) do
        hotkeys_popup.add_group_rules(group_name, group_data)
    end
end

---------------------------------------------------------------------------
-- Definición de atajos de teclado
---------------------------------------------------------------------------
local kitty_keys = {
    -- Grupo: Gestión de pestañas
    ["kitty: tabs"] = {{
        modifiers = {"Ctrl+Shift"},
        keys = {
            t          = "new tab",              -- Nueva pestaña
            q          = "close tab",            -- Cerrar pestaña
            ['Right']  = "Next tab",             -- Siguiente pestaña
            ['Left']   = "Previous tab",         -- Pestaña anterior
            l          = "Next layout",          -- Cambiar layout
            ['.']      = "move tab forward",     -- Mover pestaña adelante
            [',']      = "move tab backward",    -- Mover pestaña atrás
            ['alt+t']  = "set tab title",        -- Cambiar título
        }
    }},

    -- Grupo: Gestión de ventanas (splits)
    ["kitty: windows"] = {{
        modifiers = {"Ctrl+Shift"},
        keys = {
            ['Return'] = "new window",           -- Nueva ventana (split)
            n          = "new os window",        -- Nueva ventana del OS
            w          = "close window",         -- Cerrar ventana
            [']']      = "next window",          -- Siguiente ventana
            ['[']      = "previous window",      -- Ventana anterior
            f          = "move windows forward", -- Mover adelante
            b          = "move windows backward",-- Mover atrás
        }
    }},

    -- Grupo: Navegación y scroll
    ["kitty: scrolling"] = {{
        modifiers = {"Ctrl+Shift"},
        keys = {
            ['Up']       = "line up",            -- Scroll arriba (línea)
            ['Down']     = "line down",          -- Scroll abajo (línea)
            ['Page_Up']  = "page up",            -- Scroll arriba (página)
            ['Page_Down']= "page down",          -- Scroll abajo (página)
            ['Home']     = "top",                -- Ir al inicio
            ['End']      = "bottom",             -- Ir al final
            z            = "previous shell prompt", -- Prompt anterior
        }
    }},
}

-- Registrar los hotkeys en el sistema de AwesomeWM
hotkeys_popup.add_hotkeys(kitty_keys)

return kitty

