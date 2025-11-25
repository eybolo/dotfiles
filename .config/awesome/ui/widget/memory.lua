-- ## Memory ##
-- ~~~~~~~~~
-- requirements
-- ~~~~~~~~~~~~
local wibox = require('wibox')
local beautiful = require('beautiful')
local watch = require('awful.widget.watch')
local dpi = require('beautiful').xresources.apply_dpi

local memory = wibox.widget.textbox()
memory.font = theme.font

local function round(exact, quantum)
    local quant, frac = math.modf(exact/quantum)
    return quantum * (quant + (frac > 0.5 and 1 or 0))
end

local memory_icon = wibox.widget {
    font = theme.iconfont,
    text = "",
    widget = wibox.widget.textbox,
}

-- Contenedores para aplicar colores dinámicos
local icon_container = wibox.widget{
    memory_icon,
    fg = colors.green,  -- Color inicial
    widget = wibox.container.background
}

local text_container = wibox.widget{
    memory, 
    fg = colors.green,  -- Color inicial
    widget = wibox.container.background
}

-- Actualización con colores dinámicos según porcentaje de uso
watch('bash -c "free | grep -z Mem.*Swap.*"', 2, function(_, stdout)
    local total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap =
        stdout:match('(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*Swap:%s*(%d+)%s*(%d+)%s*(%d+)')
    
    if total and used then
        -- Calcular porcentaje de uso
        local percentage = (tonumber(used) / tonumber(total)) * 100
        
        -- Mostrar GB usados
        memory.text = round((used / 1048576), 0.01) .. ' GB'
        
        -- Cambiar color según porcentaje de uso
        local color
        if percentage < 80 then
            color = colors.green      -- Normal: verde (<80%)
        elseif percentage < 90 then
            color = colors.orange     -- Alto: naranja (80-89%)
        else
            color = colors.red        -- Crítico: rojo (≥90%)
        end
        
        -- Aplicar color a icono y texto
        icon_container.fg = color
        text_container.fg = color
    end
    
    collectgarbage('collect')
end)

return wibox.widget {
    icon_container,
    text_container,
    spacing = dpi(2),
    layout = wibox.layout.fixed.horizontal
}