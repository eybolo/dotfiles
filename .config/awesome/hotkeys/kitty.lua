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
-- Ejemplo:
--   kitty.add_rules_for_terminal({ rule = { name = { "kitty" }}})
--
function kitty.add_rules_for_terminal(rule)
    for group_name, group_data in pairs({
        ["Kitty (Tabs)"]      = rule,
        ["Kitty (Windows)"]   = rule,
        ["Kitty (Scrolling)"] = rule,
    }) do
        hotkeys_popup.add_group_rules(group_name, group_data)
    end
end

---------------------------------------------------------------------------
-- Definición de atajos de teclado
---------------------------------------------------------------------------
local kitty_keys = {
    -- Grupo: Gestión de pestañas
    ["Kitty (Tabs)"] = {{
        modifiers = {"Ctrl", "Shift"},
        keys = {
            t          = "new tab",
            q          = "close tab",
            Right      = "next tab",
            Left       = "previous tab",
            l          = "next layout",
            ["." ]     = "move tab forward",
            ["," ]     = "move tab backward",
            ["alt+t"]  = "set tab title",
        }
    }},

    -- Grupo: Gestión de ventanas (splits)
    ["Kitty (Windows)"] = {{
        modifiers = {"Ctrl", "Shift"},
        keys = {
            Return = "new window",
            n      = "new os window",
            w      = "close window",
            ["]"]   = "next window",
            ["["]   = "previous window",
            f      = "move windows forward",
            b      = "move windows backward",
        }
    }},

    -- Grupo: Navegación y scroll
    ["Kitty (Scrolling)"] = {{
        modifiers = {"Ctrl", "Shift"},
        keys = {
            Up         = "line up",
            Down       = "line down",
            Page_Up    = "page up",
            Page_Down  = "page down",
            Home       = "top",
            End        = "bottom",
            z          = "previous shell prompt",
        }
    }},
}

-- Registrar los hotkeys en el sistema de AwesomeWM
hotkeys_popup.add_hotkeys(kitty_keys)

return kitty
