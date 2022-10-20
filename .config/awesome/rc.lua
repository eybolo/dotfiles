-- ========================================================
-- Requirements 
-- ========================================================

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
--local dpi = require("beautiful").xresources.apply_dpi

require("awful.autofocus")
local beautiful = require("beautiful")

-- Notifications :
require("configuration.notifications")

home_folder = os.getenv("HOME")
theme_folder = home_folder .. "/.config/awesome/themes"

beautiful.init( theme_folder .. "/theme.lua")

-- Keys :
require("configuration.keys")


-- Signals :
--require("configuration.signals")

-- Layouts 
require("configuration.layouts")


-- Rules :
require("configuration.rules")

-- Menu :
require("ui.menu")

-- Bar :
require("ui.bar")














