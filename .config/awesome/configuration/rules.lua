-- ========================================================
-- AwesomeWM Rules Configuration
-- ========================================================
-- Define reglas para el comportamiento de ventanas, notificaciones
-- y aplicaciones específicas (floating, placement, tags, etc.)

-- ========================================================
-- Dependencies
-- ========================================================
local awful = require("awful")
local ruled = require("ruled")
local gears = require("gears")
local beautiful = require("beautiful")

-- ========================================================
-- CLIENT RULES
-- ========================================================
ruled.client.connect_signal("request::rules", function()
    
    -- ====================================================
    -- Global Rule - Aplica a TODAS las ventanas
    -- ====================================================
    ruled.client.append_rule {
        id = "global",
        rule = {},
        properties = {
            focus = awful.client.focus.filter,
            raise = true,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap +
                    awful.placement.no_offscreen +
                    awful.placement.centered
        }
    }
    
    -- ====================================================
    -- Floating Clients - Ventanas flotantes por defecto
    -- ====================================================
    ruled.client.append_rule {
        id = "floating",
        rule_any = {
            instance = {
                "pinentry"         -- Diálogo de contraseñas GPG
            },
            class = {
                -- Configuración del sistema
                "Arandr",                          -- Configuración de monitores
                "Nm-connection-editor",            -- Editor de redes
                "Pavucontrol",                     -- Control de volumen
                "Blueman-manager",                 -- Bluetooth
                
                -- Apariencia y temas
                "lxappearance",                    -- Configuración de temas GTK
                
                -- Utilidades
                "Qalculate-gtk",                   -- Calculadora
                
                -- Virtualización y remoto
                "Virt-manager",                    -- Gestor de máquinas virtuales
                "xtightvncviewer",                 -- VNC viewer
                
                -- Aplicaciones específicas
                "Steam",                           -- Cliente de Steam
            },
            name = {
                "Event Tester",    -- xev (herramienta de testing)
            },
            role = {
                "pop-up",          -- Pop-ups (ej: DevTools de Chrome)
            }
        },
        properties = {
            floating = true
        }
    }
    
    -- ====================================================
    -- Center Placement - Ventanas centradas
    -- ====================================================
    ruled.client.append_rule {
        id = "center_placement",
        rule_any = {
            type = {
                "dialog"           -- Todos los diálogos
            },
            class = {
                "steam",           -- Cliente de Steam
                "discord",         -- Discord
                "thunar",          -- Gestor de archivos Thunar
            },
            instance = {
                "markdown_input"
            },
            role = {
                "GtkFileChooserDialog"  -- Diálogos de selección de archivos
            }
        },
        properties = {
            placement = awful.placement.center
        }
    }

end)

-- ========================================================
-- CLIENT VISUAL EFFECTS
-- ========================================================

-- Esquinas redondeadas para todas las ventanas
client.connect_signal("manage", function(c)
    c.shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 8)  -- Radio de 8px
    end
end)