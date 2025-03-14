---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local beautiful = require("beautiful")
-- Layout Dir :
local layout_icon_path  = os.getenv("HOME") .. "/.config/awesome/themes/icons/layouts/"
local lip       = layout_icon_path

-- COLORS :
colors = {}
colors.black    = "#14181D"
colors.red      = "#DD4B6A"
colors.green    = "#87c7a1"
colors.yellow   = "#de8f78"
colors.blue     = "#6791c9"
colors.magenta 	= "#bc83e3"
colors.cyan     = "#70b9cc"
colors.white    = "#c4c4c4"
colors.gris     = "#505050"

-- transparent
colors.transparent  = "#00000000"
colors.container    = "#1C2325"

-- Bright colors
colors.brightblack      = "#313E42"
colors.brightred        = "#ee6a70"
--colors.brightgreen      = "#99CC00"
colors.brightgreen = "#AAF91E"
colors.brightyellow     = "#ffb29b"
colors.brightblue       = "#7ba5dd"
colors.brightmagenta    = "#cb92f2"
colors.brightcyan        = "#7fc8db"
colors.brightwhite       = "#cccccc"


theme = {}

--theme.font          = "Cascadia Code Bold 10"
--theme.iconfont          = "Font Awesome 6 free Solid 10"
theme.font          = "Hack Nerd Font Bold 10"
theme.iconfont      = "Hack Nerd Font Bold 12"

-- Establecer la fuente
beautiful.font = "Hack Nerd Font 10"  -- Ajusta el tamaño según sea necesario
theme.bg_normal 		= "#222222" 
theme.bg_focus  		= colors.brightblack
theme.bg_urgent     		= colors.black
theme.bg_minimize   		= colors.red
theme.bg_systray    		= colors.black
theme.systray_icon_spacing      = dpi(4)

-- Taglist :
theme.taglist_spacing 	    = dpi(1)
--theme.taglist_bg_focus                          = colors.magenta
theme.taglist_fg_focus      = colors.red
theme.taglist_fg_empty      = colors.gris
--theme.taglist_bg_empty                          = colors.black
theme.taglist_fg_urgent	    = colors.green

theme.fg_normal 	= colors.white
theme.fg_focus    	= colors.blue
theme.fg_urgent     	= colors.brightred
theme.fg_minimize   	= colors.brightblack

theme.useless_gap       = dpi(3)
theme.border_width      = dpi(2)
--theme.border_normal = "#000000"
theme.border_normal     = "#000000"
-- theme.border_focus  = "#535d6c"
--theme.border_focus      = "#00FFFF"
--theme.border_marked     = "#91231c"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"
--
--[[
-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

--theme.wallpaper = themes_path.."default/background.png"
--theme.wallpaper = "/home/manu/image/wallpaper/keyboard.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"
--]]
-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)


-- Layoutbox icons :

theme.layout_floating       = lip.. "floating.png"
theme.layout_fullscreen     = lip.. "fullscreen.png"
theme.layout_tilebottom     = lip.. "tilebottom.png"
theme.layout_tileleft       = lip.. "tileleft.png"
theme.layout_tile           = lip.. "tile.png"
theme.layout_tiletop        = lip.. "tiletop.png"


-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
--theme.icon_theme = nil
--[[
 function make_fa_icon( code )
	return wibox.widget {
	font = theme.icon_font .. theme.icon_size,
	markup = ' <span color="' .. theme.icon_color ..'">' .. code .. '</span> ',
	align = 'center',
	valign = 'center',
	widget = wibox.widget.textbox
	}
end

facpuicon = make_fa_icon('\u{f2db}')

--]]
return theme
--  vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
