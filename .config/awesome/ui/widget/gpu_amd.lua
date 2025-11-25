-- ## GPU Temperature (AMD amdgpu-pci-0300) with color ##
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
local wibox = require('wibox')
local watch = require('awful.widget.watch')
local beautiful = require('beautiful')
local dpi = require('beautiful').xresources.apply_dpi

-- Widget de texto
local gpu_temp = wibox.widget.textbox()
gpu_temp.font = theme.font

-- Icono GPU
local gpu_icon = wibox.widget {
    font = "Hack Nerd Font Mono 24",
    text = "󰢮",
    widget = wibox.widget.textbox,
}

-- Contenedores para aplicar colores dinámicos
local icon_container = wibox.widget{
    gpu_icon,
    fg = colors.green,
    widget = wibox.container.background
}

local text_container = wibox.widget{
    gpu_temp, 
    fg = colors.green,
    widget = wibox.container.background
}

-- Comando directo para leer GPU dedicada específica
local gpu_temp_cmd = [[
bash -c "sensors amdgpu-pci-0300 2>/dev/null | awk '/edge:/ {gsub(/\\+|°C/, \"\", \$2); print \$2}'"
]]

-- Actualización cada 10 segundos con colores dinámicos
watch(gpu_temp_cmd, 10, function(_, stdout)
    local temp_str = stdout:gsub("\n", "")
    local temp = tonumber(temp_str)
    
    if temp and temp > 0 then
        gpu_temp.text = temp_str .. "°C"
        
        -- Cambiar color según temperatura de GPU
        local color
        if temp < 60 then
            color = colors.green      -- Normal: verde
        elseif temp < 75 then
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
        gpu_temp.text = "N/A"
        icon_container.fg = colors.red
        text_container.fg = colors.red
    end
end)

-- Retorno del widget con icono y temperatura
return wibox.widget {
    icon_container,
    text_container,
    spacing = dpi(2),
    layout = wibox.layout.fixed.horizontal
}