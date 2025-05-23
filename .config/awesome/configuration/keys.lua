-- ## Keybindings ##
-- ~~~~~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local awful         = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local HOME_DIR = os.getenv("HOME")
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
--require "awful.hotkeys_popup.keys.vim"
require "awful.hotkeys_popup.keys.kitty"
-- vars/misc
-- ~~~~~~~~~

-- modkey
local modkey    = "Mod4"

-- modifer keys
local shift     = "Shift"
local ctrl      = "Control"
local alt       = "Mod1"

terminal = "kitty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Configurations
-- ~~~~~~~~~~~~~~

-- Mouse bindings :
awful.mouse.append_global_mousebindings({
    awful.button({ }, 3, function () mymainmenu:toggle() end)
})

-- ===================
-- General AWESOME
-- =================== 

awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
		{description="show help", group="awesome"}),
              
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
		{description = "show main menu", group = "awesome"}),
              
    awful.key({ modkey, ctrl }, "r", awesome.restart,
		{description = "reload awesome", group = "awesome"}),
              
    awful.key({ modkey, shift   }, "q", awesome.quit,
		{description = "quit awesome", group = "awesome"}),
              
    -- awful.key({ modkey }, "p", function() menubar.show() end,
	--	{description = "show the menubar", group = "launcher"}),
})

--===================
-- LAUNCHER
--=================== 

awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
		{description = "open a terminal", group = "awesome - launcher"}),              

	-- Rofi Launchers
    awful.key({ modkey }, "r", function () awful.spawn(string.format(HOME_DIR .. "/.config/rofi/launchers/type-6/launcher.sh")) end,
		{description = "rofi launcher", group = "awesome - launcher"}),
})


--===================
--CLIENT 
--=================== 

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "awesome - client"}
    ),
    
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "awesome - client"}
    ),
   --[[ 
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "awesome - client"}),
     --]]   
              
    awful.key({ modkey, ctrl }, "n",
		function ()
			local c = awful.client.restore()
			-- Focus restored client
			if c then
			c:activate { raise = true, context = "key.unminimize" }
			end
		end,
		{description = "restore minimized", group = "awesome - client"}),

-- Layout related keybindings
--awful.keyboard.append_global_keybindings({
    awful.key({ modkey, shift   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "awesome - client"}),
              
    awful.key({ modkey, shift   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "awesome - client"}),
              
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "awesome - client"}),
})

--===================
-- SCREEN 
--=================== 

awful.keyboard.append_global_keybindings({
    awful.key({ modkey, ctrl }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "awesome - screen"}),
              
    awful.key({ modkey, ctrl }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "awesome - screen"}),
})

--===================
-- LAYOUT
--=================== 

awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "awesome - layout"}),
              
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "awesome - layout"}),
              
    awful.key({ modkey, shift   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "awesome - layout"}),
              
    awful.key({ modkey, shift   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "awesome - layout"}),
              
    awful.key({ modkey, ctrl }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "awesome - layout"}),
              
    awful.key({ modkey, ctrl }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "awesome - layout"}),
              
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "awesome - layout"}),
              
    awful.key({ modkey, shift   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "awesome - layout"}),
})


--===================
--TAGS
--===================

-- Tags related keybindings
awful.keyboard.append_global_keybindings({

    awful.key({ modkey, shift          }, "Tab",   awful.tag.viewprev,
		{description = "view previous", group = "awesome - tag"}),
              
    awful.key({ modkey,           }, "Tab",  awful.tag.viewnext,
		{description = "view next", group = "awesome - tag"}),
              
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
		{description = "go back", group = "awesome - tag"}),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "awesome - tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, ctrl },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "awesome - tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { modkey, shift },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "awesome - tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, ctrl, shift },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "awesome - tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "awesome - layout",
        on_press    = function (index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    }
})
    
      
--===================
-- VOLUME 
--=================== 
awful.keyboard.append_global_keybindings({
	awful.key({ modkey,  }, "]", function() volume_widget:inc(5) end),
	awful.key({ modkey, }, "[", function() volume_widget:dec(5) end),
	awful.key({ modkey, }, "\\", function() volume_widget:toggle() end),
})


-- ===================
-- BRIGHTNESS
-- =================== 
awful.keyboard.append_global_keybindings({
    awful.key({modkey, shift }, "]", function() awful.util.spawn("brightnessctl set 5%+", false) end),
    awful.key({modkey, shift }, "[", function() awful.util.spawn("brightnessctl set 5%-", false) end),
})
    
--[[
-- Media Control :
awful.keyboard.append_global_keybindings({
      -- Volume Keys :sdسي

 awful.key({ modkey }, "]", function() volume_widget:inc(5) end),
awful.key({ modkey }, "[", function() volume_widget:dec(5) end),
awful.key({ modkey }, "\\", function() volume_widget:toggle() end),

	
    -- Volume Keys :sdسي
	awful.key({}, "XF86AudioLowerVolume", function ()
		awful.util.spawn("amixer -q -D pulse sset Master 5%-", false) end),
	 
	awful.key({}, "XF86AudioRaiseVolume", function ()
		awful.util.spawn("amixer -q -D pulse sset Master 5%+", false) end),
	 
	awful.key({}, "XF86AudioMute", function ()
		awful.util.spawn("amixer -D pulse set Master 1+ toggle", false) end),
	 
	-- Media Keys :
	awful.key({}, "XF86AudioPlay", function()
		awful.util.spawn("playerctl play-pause", false) end),
	 
	awful.key({}, "XF86AudioNext", function()
		awful.util.spawn("playerctl next", false) end),
	 
	awful.key({}, "XF86AudioPrev", function()
		awful.util.spawn("playerctl previous", false) end),
	 
	-- Brightness Keys :
	awful.key({}, "XF86MonBrightnessUp", function()
		awful.util.spawn("brightnessctl set 2%+", false) end),
	 
	awful.key({}, "XF86MonBrightnessDown", function()
		awful.util.spawn("brightnessctl set 2%-", false) end),
 
})
  --]] 
    

--===================
-- SCREENSHOT 
--=================== 

-- Standard program :
awful.keyboard.append_global_keybindings({
    -- Screenshots Keys :
    --awful.key({}, "Print", function () awful.util.spawn("flameshot gui")end,
		--{description = "Maim", group = "screenshot"}),
					  
    awful.key({ modkey }, "p", function () awful.util.spawn("flameshot gui")end,
		{description = "Flameshot", group = "screenshot"}),
})


--===================
-- SySTEM 
--===================

-- PowerMenu ROFI
awful.keyboard.append_global_keybindings({
	awful.key({ modkey  }, "q", function () awful.util.spawn_with_shell(HOME_DIR .. "/.config/rofi/powermenu/powermenu.sh") end,
	{description = "Power Menu", group = "System"}),
	
-- Betterlockscreeen
--	awful.key({ modkey  }, "b", function () awful.util.spawn_with_shell("betterlockscreen --lock --blur") end,
	awful.key({ modkey  }, "b", function () awful.util.spawn_with_shell("betterlockscreen --lock blur && betterlockscreen -u $HOME/image/wallpaper/") end,
	{description = "block system", group = "System"}),
	
-- Clipmenu
	awful.key({ modkey  }, "i", function () awful.util.spawn_with_shell("clipmenu") end,
           {description = "clipboard history by rofi/clipmenud", group = "System"}),

	awful.key({ modkey  }, "a", function () awful.util.spawn_with_shell(terminal .. " -T 'FileManager' -e lf") end,
            {description = "lf file manager", group = "System"}),
})


client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({ modkey }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        awful.button({ modkey }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)

-- ========


client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ modkey,           }, "f",
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = "toggle fullscreen", group = "awesome - client"}),
        awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
                {description = "close", group = "awesome - client"}),
        awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
                {description = "toggle floating", group = "awesome - client"}),
        awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
                {description = "move to master", group = "awesome - client"}),
        awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
                {description = "move to screen", group = "awesome - client"}),
        awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
                {description = "toggle keep on top", group = "awesome - client"}),
        awful.key({ modkey,           }, "n",
            function (c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end ,
            {description = "minimize", group = "awesome - client"}),
        awful.key({ modkey,           }, "m",
            function (c)
                c.maximized = not c.maximized
                c:raise()
            end ,
            {description = "(un)maximize", group = "awesome - client"}),
        awful.key({ modkey, "Control" }, "m",
            function (c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end ,
            {description = "(un)maximize vertically", group = "awesome - client"}),
        awful.key({ modkey, "Shift"   }, "m",
            function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end ,
            {description = "(un)maximize horizontally", group = "awesome - client"}),
    })
end)
    
    
    
--[[
-- Sloppy focus :
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)

client.connect_signal("focus", function(c) c.border_color = theme.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = theme.border_normal end)
-- }}}
-- ]]
