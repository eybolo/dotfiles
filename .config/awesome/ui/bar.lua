-- ========================================================
-- AwesomeWM Top Bar (Wibar) Configuration
-- ========================================================
-- Configura la barra superior con widgets, taglist, tasklist
-- y controles del sistema. Incluye detección automática de
-- hardware (batería, GPU AMD).

-- ========================================================
-- Dependencies
-- ========================================================
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- ========================================================
-- Bar Container Helper Function
-- ========================================================
-- Crea un contenedor con bordes redondeados y padding
-- para widgets individuales en la barra
local function barcontainer(widget)
    local container = wibox.widget {
        widget,
        top = dpi(4),
        bottom = dpi(4),
        left = dpi(4),
        right = dpi(4),
        widget = wibox.container.margin
    }
    
    local box = wibox.widget {
        {
            container,
            top = dpi(2),
            bottom = dpi(2),
            left = dpi(4),
            right = dpi(4),
            widget = wibox.container.margin
        },
        bg = colors.black,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 8)
        end,
        widget = wibox.container.background
    }
    
    return wibox.widget {
        box,
        top = dpi(0),
        bottom = dpi(0),
        right = dpi(2),
        left = dpi(2),
        widget = wibox.container.margin
    }
end

-- ========================================================
-- System Detection Functions
-- ========================================================

-- Detecta si el sistema tiene batería
local function has_battery()
    local handle = io.popen("upower -e | grep BAT")
    local result = handle:read("*a")
    handle:close()
    return result ~= ""
end

-- Detecta si hay GPU AMD dedicada
local function has_amd_gpu()
    local handle = io.popen("sensors amdgpu-pci-0300 2>/dev/null | grep -q 'edge:' && echo 'yes' || echo 'no'")
    local result = handle:read("*a"):gsub("\n", "")
    handle:close()
    return result == "yes"
end

-- ========================================================
-- Widget Imports
-- ========================================================

-- Custom Widgets
local clock_widget = require('ui.widget.clock')
local brightness_widget = require("ui.widget.brightness")
local keyboardlayout_widget = require('ui.widget.keyboardlayout')
local mem_widget = require('ui.widget.memory')
local temprature_widget = require('ui.widget.temprature')
local updates_widget = require('ui.widget.updates')
local cpu_widget = require("ui.widget.cpu.cpu")

-- External Widgets (awesome-wm-widgets)
local volume_widget = require('ui.widget.awesome-wm-widgets.volume-widget.volume')
local batteryarc_widget = require("ui.widget.awesome-wm-widgets.batteryarc-widget.batteryarc")
local todo_widget = require("ui.widget.awesome-wm-widgets.todo-widget.todo")
local calendar_widget = require("ui.widget.awesome-wm-widgets.calendar-widget.calendar")

-- Network Widgets
local net_widgets = require("ui.widget.net_widgets")
local net_wireless = net_widgets.wireless({interface = "wlp10s0"})
local net_wired = net_widgets.indicator({
    interfaces = {"enp0s3"},
    timeout = 5
})

-- GPU Widget (conditional)
local gpu_amd_widget = has_amd_gpu() and require("ui.widget.gpu_amd") or nil

-- ========================================================
-- Calendar Widget Configuration
-- ========================================================
local cw = calendar_widget({
    theme = 'outrun',
    placement = 'top_right',
    start_sunday = false,
    radius = 8,
    previous_month_button = 4,  -- Mouse wheel up
    next_month_button = 5,      -- Mouse wheel down
    auto_hide = true,
    timeout = 2
})

-- Conectar click del reloj para mostrar calendario
clock_widget:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then
        cw.toggle()
    end
end)

-- ========================================================
-- Pacman Taglist Theme
-- ========================================================
local pacman = "󰮯"  -- Pacman icon
local ghost = "󰊠"   -- Ghost icon

-- ========================================================
-- Screen Setup
-- ========================================================
awful.screen.connect_for_each_screen(function(s)
    
    -- ====================================================
    -- Tags Creation
    -- ====================================================
    -- Crear 5 tags vacíos (los iconos se manejan en el taglist)
    awful.tag({"", "", "", "", ""}, s, awful.layout.layouts[1])
    
    -- ====================================================
    -- Promptbox
    -- ====================================================
    s.mypromptbox = awful.widget.prompt()
    
    -- ====================================================
    -- Layoutbox
    -- ====================================================
    s.mylayoutbox = awful.widget.layoutbox {
        screen = s,
        visible = true,
        buttons = {
            awful.button({}, 1, function() awful.layout.inc(1) end),
            awful.button({}, 3, function() awful.layout.inc(-1) end),
            awful.button({}, 4, function() awful.layout.inc(-1) end),
            awful.button({}, 5, function() awful.layout.inc(1) end),
        }
    }
    s.mylayoutbox = wibox.container.margin(s.mylayoutbox, dpi(0), dpi(5), dpi(5), dpi(5))
    
    -- ====================================================
    -- Taglist (Pacman Theme)
    -- ====================================================
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({}, 1, function(t) t:view_only() end),
            awful.button({modkey}, 1, function(t)
                if client.focus then
                    client.focus:move_to_tag(t)
                end
            end),
            awful.button({}, 3, awful.tag.viewtoggle),
            awful.button({modkey}, 3, function(t)
                if client.focus then
                    client.focus:toggle_tag(t)
                end
            end),
        },
        widget_template = {
            id = "icon_role",
            widget = wibox.widget.textbox,
            font = "Hack Nerd Font Mono 20",
            align = "center",
            valign = "center",
            
            -- Callback inicial: todos los tags empiezan como fantasmas apagados
            create_callback = function(self, tag, _)
                self.text = ghost
                self.markup = "<span foreground='#666666'>" .. self.text .. "</span>"
            end,
            
            -- Callback de actualización: cambia según estado del tag
            update_callback = function(self, tag, _)
                if tag.selected then
                    -- Tag activo: Pacman amarillo
                    self.text = pacman
                    self.markup = "<span foreground='" .. colors.pacman .. "'>" .. self.text .. "</span>"
                elseif #tag:clients() > 0 then
                    -- Tag con ventanas: Fantasma azul
                    self.text = ghost
                    self.markup = "<span foreground='" .. colors.ghost .. "'>" .. self.text .. "</span>"
                else
                    -- Tag vacío: Fantasma gris
                    self.text = ghost
                    self.markup = "<span foreground='" .. colors.ghost_empty .. "'>" .. self.text .. "</span>"
                end
            end,
        },
    }
    
    -- ====================================================
    -- Tasklist (Lista de ventanas)
    -- ====================================================
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({}, 1, function(c)
                c:activate {context = "tasklist", action = "toggle_minimization"}
            end),
            awful.button({}, 3, function()
                awful.menu.client_list {theme = {width = 250}}
            end),
            awful.button({}, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({}, 5, function() awful.client.focus.byidx(1) end),
        },
        style = {
            border_width = 1,
            border_color = colors.black,
            shape = function(cr, w, h)
                gears.shape.rounded_rect(cr, w, h, 8)
            end,
            bg_minimize = colors.black,
            bg_normal = colors.black,
            bg_focus = colors.pacman,
        },
        layout = {
            spacing = 4,
            spacing_widget = {
                {
                    forced_width = 0,
                    shape = gears.shape.circle,
                    widget = wibox.widget.separator
                },
                valign = "center",
                halign = "center",
                widget = wibox.container.place,
            },
            layout = wibox.layout.flex.horizontal
        },
        widget_template = {
            {
                {
                    {
                        -- Solo mostrar icono (texto comentado)
                        {
                            id = "clienticon",
                            widget = awful.widget.clienticon,
                        },
                        margins = 4,
                        widget = wibox.container.margin,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left = 5,
                right = 5,
                widget = wibox.container.margin
            },
            id = "background_role",
            widget = wibox.container.background,
        },
    }
    
    -- ====================================================
    -- Wibar (Barra superior)
    -- ====================================================
    s.mywibar = awful.wibar({
        position = "top",
        type = "dock",
        ontop = false,
        stretch = false,
        visible = true,
        height = dpi(30),
        width = s.geometry.width - dpi(20),
        screen = s,
        bg = colors.transparent,
    })
    
    -- Posicionamiento con margen
    awful.placement.top(s.mywibar, {margins = beautiful.useless_gap * 2})
    s.mywibar:struts({
        top = dpi(35),
    })
    
    -- ====================================================
    -- Wibar Layout (Widgets Organization)
    -- ====================================================
    s.mywibar:setup({
        {
            {
                layout = wibox.layout.align.horizontal,
                expand = "none",
                
                -- ============================================
                -- Left Widgets (System Monitoring)
                -- ============================================
                {
                    barcontainer(s.mytaglist),
                    barcontainer(cpu_widget()),
                    barcontainer(temprature_widget),
                    (gpu_amd_widget and barcontainer(gpu_amd_widget) or nil),
                    barcontainer(mem_widget),
                    barcontainer(brightness_widget),
                    spacing = dpi(0),
                    layout = wibox.layout.fixed.horizontal,
                },
                
                -- ============================================
                -- Middle Widget (Tasklist)
                -- ============================================
                {
                    layout = wibox.layout.fixed.horizontal,
                    s.mytasklist,
                },
                
                -- ============================================
                -- Right Widgets (Utilities & Status)
                -- ============================================
                {
                    barcontainer(todo_widget()),
                    barcontainer(net_wired),
                    barcontainer(net_wireless),
                    barcontainer(updates_widget),
                    barcontainer(volume_widget{widget_type = 'icon_and_text'}),
                    (has_battery() and barcontainer(batteryarc_widget()) or nil),
                    barcontainer(keyboardlayout_widget),
                    barcontainer(clock_widget),
                    s.mylayoutbox,
                    layout = wibox.layout.fixed.horizontal,
                },
            },
            left = dpi(0),
            right = dpi(0),
            widget = wibox.container.margin,
        },
        bg = colors.transparent,
        widget = wibox.container.background,
    })
end)