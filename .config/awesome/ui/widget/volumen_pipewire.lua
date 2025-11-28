local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local volume_widget = {}

-- ========================================================
-- CONFIG
-- ========================================================
local audio_device = "@DEFAULT_AUDIO_SINK@" -- PipeWire default output
local update_interval = 2 -- seconds

-- ========================================================
-- WIDGET UI
-- ========================================================
volume_widget.widget = wibox.widget {
    {
        id    = "icon",
        text  = " ",
        widget = wibox.widget.textbox,
    },
    {
        id = "value",
        text = "??%",
        widget = wibox.widget.textbox,
    },
    layout = wibox.layout.fixed.horizontal
}

-- ========================================================
-- UPDATE FUNCTION
-- ========================================================
local function update_volume()
    awful.spawn.easy_async_with_shell(
        "wpctl get-volume " .. audio_device,
        function(stdout)
            -- ej: "Volume: 0.52 [MUTED]"
            local vol = stdout:match("(%d%.%d+)")
            local muted = stdout:match("MUTED")

            if vol then
                local percent = math.floor(tonumber(vol) * 100 + 0.5)

                if muted then
                    volume_widget.widget.icon.text = " "
                    volume_widget.widget.value.text = percent .. "%"
                else
                    volume_widget.widget.icon.text = " "
                    volume_widget.widget.value.text = percent .. "%"
                end
            end
        end
    )
end

-- ========================================================
-- FUNCIONES DE CONTROL EXPORTADAS (PARA TECLAS)
-- ========================================================

-- Aumentar volumen
function volume_widget:inc(amount)
    awful.spawn("wpctl set-volume " .. audio_device .. " " .. amount .. "%+")
    update_volume() -- Forzar actualización
end

-- Disminuir volumen
function volume_widget:dec(amount)
    awful.spawn("wpctl set-volume " .. audio_device .. " " .. amount .. "%-")
    update_volume() -- Forzar actualización
end

-- Mutear/Desmutear
function volume_widget:toggle()
    awful.spawn("wpctl set-mute " .. audio_device .. " toggle")
    update_volume() -- Forzar actualización
end


-- ========================================================
-- TIMER AUTO-REFRESH
-- ========================================================
gears.timer {
    timeout = update_interval,
    autostart = true,
    call_now = true,
    callback = update_volume
}

-- ========================================================
-- OPCIONAL: CLIC DEL MOUSE EN EL WIDGET
-- ========================================================
volume_widget.widget:buttons(
    gears.table.join(
        -- Clic Izquierdo: Toggle mute
        awful.button({}, 1, function()
            volume_widget:toggle()
        end),
        -- Clic Derecho (Botón 3): Abrir Pavucontrol
        awful.button({}, 3, function()
            awful.spawn("pavucontrol")
        end),
        -- Scroll Arriba: Aumentar volumen 5%
        awful.button({}, 4, function()
            volume_widget:inc(5)
        end),
        -- Scroll Abajo: Disminuir volumen 5%
        awful.button({}, 5, function()
            volume_widget:dec(5)
        end)
    )
)

return volume_widget
