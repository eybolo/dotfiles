-- ## CPU Temperature (Intel/AMD auto-detect) ##
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
local wibox = require('wibox')
local watch = require('awful.widget.watch')
local beautiful = require('beautiful')
local dpi = require('beautiful').xresources.apply_dpi

-- Widget de temperatura CPU
local temprature = wibox.widget.textbox()
temprature.font = theme.font

-- Comando que detecta Intel (Core 0) o AMD (Tccd1) automáticamente
local cpu_temp_cmd = [[
bash -c "sensors | awk '/Tccd1|Core 0/ {gsub(/\\+|°C/, \"\", \$2); print \$2; exit}'"
]]

-- Icono de temperatura CPU
local temprature_icon = wibox.widget {
    font = "Hack Nerd Font Mono 20",
    text = "",
    widget = wibox.widget.textbox,
}

-- Contenedores para aplicar colores dinámicos
local icon_container = wibox.widget{
    temprature_icon,
    fg = colors.green,
    widget = wibox.container.background
}

local text_container = wibox.widget{
    temprature, 
    fg = colors.green,
    widget = wibox.container.background
}

-- Actualización con colores dinámicos según temperatura
watch(cpu_temp_cmd, 10, function(_, stdout)
    local temp_str = stdout:gsub("\n", "")
    local temp = tonumber(temp_str)
    
    if temp then
        temprature.text = temp_str .. "°C"
        
        -- Cambiar color según temperatura
        local color
        if temp < 50 then
            color = colors.green      -- Normal: verde
        elseif temp < 70 then
            color = colors.yellow     -- Elevada: amarillo
        elseif temp < 85 then
            color = colors.orange     -- Alta: naranja
        else
            color = colors.red        -- Crítica: rojo
        end
        
        -- Aplicar color a icono y texto
        icon_container.fg = color
        text_container.fg = color
    else
        -- Si no puede leer temperatura
        temprature.text = "N/A"
        icon_container.fg = colors.red
        text_container.fg = colors.red
    end
end)

-- Retornar widget completo
return wibox.widget {
    icon_container,
    text_container,
    spacing = dpi(2),
    layout = wibox.layout.fixed.horizontal
}
