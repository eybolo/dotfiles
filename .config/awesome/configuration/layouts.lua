-- ========================================================
-- AwesomeWM Layouts Configuration
-- ========================================================
-- Configuración centralizada de los layouts (distribuciones de ventanas)
-- disponibles en el window manager. Define cómo se organizan
-- las ventanas en cada tag/workspace.

-- ========================================================
-- Dependencies
-- ========================================================
local awful = require("awful")

-- ========================================================
-- Available Layouts
-- ========================================================
-- Registra los layouts disponibles para todos los tags.
-- Los usuarios pueden ciclar entre estos layouts usando
-- Mod4 + Space (siguiente) o Mod4 + Shift + Space (anterior)

tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        
        -- ================================================
        -- Tiling Layouts - Ventanas en mosaico
        -- ================================================
        awful.layout.suit.tile,           -- Master a la izquierda, stack a la derecha
        awful.layout.suit.tile.left,      -- Master a la derecha, stack a la izquierda
        awful.layout.suit.tile.bottom,    -- Master arriba, stack abajo
        awful.layout.suit.tile.top,       -- Master abajo, stack arriba
        
        -- ================================================
        -- Special Layouts - Layouts especiales
        -- ================================================
        awful.layout.suit.floating,       -- Ventanas flotantes libres
        awful.layout.suit.max.fullscreen, -- Fullscreen sin bordes ni gaps
        
        -- ================================================
        -- Layouts adicionales disponibles (comentados)
        -- ================================================
        -- awful.layout.suit.fair,           -- Todas las ventanas mismo tamaño
        -- awful.layout.suit.fair.horizontal, -- Fair horizontal
        -- awful.layout.suit.spiral,          -- Espiral de Fibonacci
        -- awful.layout.suit.spiral.dwindle,  -- Espiral decreciente
        -- awful.layout.suit.max,             -- Maximizado (con bordes)
        -- awful.layout.suit.magnifier,       -- Ventana master ampliada
        -- awful.layout.suit.corner.nw,       -- Master esquina superior izquierda
        -- awful.layout.suit.corner.ne,       -- Master esquina superior derecha
        -- awful.layout.suit.corner.sw,       -- Master esquina inferior izquierda
        -- awful.layout.suit.corner.se,       -- Master esquina inferior derecha
        
    })
end)

-- ========================================================
-- Return Module
-- ========================================================
return true