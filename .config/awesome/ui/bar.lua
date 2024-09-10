-- ## Bar ##
-- ~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local clickable_container = require('widget.clickable-container')
local net_widgets=require("net_widgets")
net_wireless = net_widgets.wireless({interface="wlp1s0"})
net_wired = net_widgets.indicator({
        interfaces = {"enp0s3"},
        timeout = 5
    })

-- Tags 
--awful.util.tagnames =  { "🖥️","🌐","💬","📝","" }
-- Configuración de la fuente para la taglist
beautiful.taglist_font = "Hack Nerd Font 14"  -- Cambia 14 al tamaño deseado
--beautiful.taglist_spacing = 5  -- Ajusta este valor según el espaciado que necesites
awful.util.tagnames =  { " ","󰖟 "," ","󱎴 ","󰙏 "}
-- awful.util.tagnames =  { "dev",  "www", "sys", "doc", "vbox", "chat", "mus", "vid", "gfx" }
-- awful.util.tagnames =  { "", "", " ", "","", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "I", "II", "III", "IV", "V", "VI" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", "" }
--awful.util.tagnames =  { "", "", "", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "一", "二", "三", "四", "五", "六", "七", "八", "九" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", ""}
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", ""}

-- Pacman Taglist :
-- awful.util.tagnames = {"●", "●", "●", "●", "●", "●", "●", "●", "●", "●"}
-- awful.util.tagnames = {"", "", "", "", "", "", "", "", "", ""}
-- awful.util.tagnames = {"•", "•", "•", "•", "•", "•", "•", "•", "•", "•"}
-- awful.util.tagnames = { "","", "", "", "", "", "", "", "", "" }
-- awful.util.tagnames = { "󰮯", "󰮯", "󰮯", "󰮯", "󰮯", "󰮯", "󰮯", "󰮯", "󰮯", "󰮯" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", "",  "" }


-- Barcontainer :
local function barcontainer(widget)
    local container = wibox.widget
      {
        widget,
        top = dpi(4),
        bottom = dpi(4),
        left = dpi(4),
        right = dpi(4),
        widget = wibox.container.margin
    }
    local box = wibox.widget{
        {
            container,
            top = dpi(2),
            bottom = dpi(2),
            left = dpi(4),
            right = dpi(4),
            widget = wibox.container.margin
        },
        bg = colors.container,
        shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,8) end,
        widget = wibox.container.background
    }
return wibox.widget{
        box,
        top = dpi(0),
        bottom = dpi(0),
        right = dpi(2),
        left = dpi(2),
        widget = wibox.container.margin
    }
end

-- Widgets :
local clock_widget = require('widget.clock')
local brightness_widget = require("widget.brightness")
local keyboardlayout_widget = require('widget.keyboardlayout')
local mem_widget = require('widget.memory')
local temprature_widget = require('widget.temprature')
local updates_widget = require('widget.updates')
local cpu_widget = require("widget.cpu.cpu")
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")

--[[
--\\
local function set_wallpaper(s)
    -- Wallpaper
    if theme.wallpaper then
        local wallpaper = theme.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

--]]

awful.screen.connect_for_each_screen(function(s)
   
    -- Each screen has its own tag table.
    awful.tag(awful.util.tagnames, s,awful.layout.layouts[1])

     -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
	
	-- Create a launcher for each screen
	mylauncher = wibox.container.margin(mylauncher, dpi(0), dpi(0), dpi(4), dpi(4))
	
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
        visible = true,
        buttons = {
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc(-1) end),
            awful.button({ }, 5, function () awful.layout.inc( 1) end),
        }
    }
    s.mylayoutbox = wibox.container.margin(s.mylayoutbox, dpi(0), dpi(5), dpi(5), dpi(5))
    
   --  local tag_colors = {"#ff0000", "#00ff00", "#0000ff", "#ff0000", "#00ff00", "#0000ff","#ff0000", "#00ff00", "#0000ff"}

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
				if client.focus then
					client.focus:move_to_tag(t)
				end
			end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
				if client.focus then
					client.focus:toggle_tag(t)
				end
			end),
        },
    }
    
    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({ }, 1, function (c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
            awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
            awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
        },
		style    = {
			border_width = 1,
            --shape_border_width = 10,
			border_color = colors.black,
			-- Text Enabeld :
			shape        = function(cr,w,h) gears.shape.rounded_rect(cr, w, h, 8) end,
			-- Text disabeld :
			--shape        = gears.shape.circle,
			bg_minimize = colors.black,
			bg_normal 	= colors.brightblack,
			bg_focus	= colors.red,
		},		
		layout   = {
			spacing = 8,
			spacing_widget = {
				{
					forced_width = 0,
					shape        = gears.shape.circle,
					widget       = wibox.widget.separator
				},
				valign = "center",
				halign = "center",
				widget = wibox.container.place,
			},
			layout  = wibox.layout.flex.horizontal
		},
		widget_template = {
			{
				{
					{
						-- Icon :
						{
							id     = "clienticon",
							widget = awful.widget.clienticon,
						},
						margins = 6,
						widget  = wibox.container.margin,
					},
					-- Text :
					--{
					--	id     = "text_role",
					--	widget = wibox.widget.textbox,
					--},
					layout = wibox.layout.fixed.horizontal,
				},
				left  = 5,
				right = 5,
				widget = wibox.container.margin
			},
            id     = "background_role",
			widget = wibox.container.background,
		},
    }
                                  
                                     
    --[[
	-- Systemtry :
	s.systray = wibox.widget {
		visible = false,
		base_size = dpi(24),
		horizontal = true,
		screen = 'primary',
		widget = wibox.widget.systray
	}
	s.tray_toggler  		= require('widget.tray-toggle')
--]]	
	-- Create the wibar
	----------------------
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

	awful.placement.top(s.mywibar, { margins = beautiful.useless_gap * 2 })
	s.mywibar:struts({
		top = dpi(35),
		--bottom = dpi(10),
	})
	
	-- Add widgets to the wibox
	s.mywibar:setup({
		{
			{
				layout = wibox.layout.align.horizontal,
                expand = "none",
				{ -- Left widgets :
                    barcontainer(s.mytaglist),
                    barcontainer(cpu_widget()),
					barcontainer(temprature_widget),
                    barcontainer(mem_widget),
                    barcontainer(brightness_widget),
					spacing = dpi(0),
					layout = wibox.layout.fixed.horizontal,
				},

				{ -- Middle widget :
                  layout = wibox.layout.fixed.horizontal,
				  s.mytasklist,
				},

				{ -- Right widgets :
                    barcontainer(net_wired),
                    barcontainer(net_wireless),
					barcontainer(updates_widget),
                    barcontainer(volume_widget{widget_type = 'arc'}), 
                    barcontainer(batteryarc_widget()),		
                    barcontainer(keyboardlayout_widget),
					barcontainer(clock_widget),					
					--{
                      -- 	s.systray,
					--	margins = dpi(4),
					--	widget = wibox.container.margin,
					--},
					--s.tray_toggler,
					s.mylayoutbox,
					layout = wibox.layout.fixed.horizontal,
				},
			},
			left = dpi(0),
			right = dpi(0),
			widget = wibox.container.margin,
		},
		bg = colors.transparent,
		shape  = function(cr,w,h) gears.shape.rounded_rect(cr, w, h, 8) end,
		widget = wibox.container.background,
	})
end)

    
--[[    
    -- {{{ Wallpaper
screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        widget = {
            {
                image     = beautiful.wallpaper,
                upscale   = true,
                downscale = true,
                widget    = wibox.widget.imagebox,
            },
            valign = "center",
            halign = "center",
            tiled  = true,
            widget = wibox.container.tile,
        }
    }
end)
-- }}}
--]]

