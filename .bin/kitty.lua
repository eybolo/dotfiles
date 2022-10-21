---------------------------------------------------------------------------
--- kitty hotkeys for awful.hotkeys_widget
--
-- @author nahsi nashi@airmail.cc
-- @copyright 2017 nahsi
-- @submodule  awful.hotkeys_popup
---------------------------------------------------------------------------

local hotkeys_popup = require("awful.hotkeys_popup.widget")

local kitty = {}

--- Add rules to match kitty session.
--
-- For example:
--
--     kitty.add_rules_for_terminal({ rule = { name = { "kitty" }}})
--
-- will show kitty hotkeys for any window that has 'kitty' in its title.
-- If no rules are provided then kitty hotkeys will be shown always!
-- @function add_rules_for_terminal
-- @see ruled.client.rules
-- @tparam table rule Rules to match a window containing a kitty session.
function kitty.add_rules_for_terminal(rule)
    for group_name, group_data in pairs({
        ["kitty: tabs"] = rule,
        ["kitty: windows"]  = rule,
        ["kitty: scrolling"]  = rule,
    }) do
        hotkeys_popup.add_group_rules(group_name, group_data)
    end
end

local kitty_keys = {
    ["kitty: tabs"] = {{
        modifiers = {"Ctrl+Shift"},
        keys = {
            t     = "new tab",
            q     = "close tab",
            ['Right'] = "Next tab",
            ['Left'] = "Previous tab",
            l     = "Next layout",
            ['.'] = "move tab forward",
            [','] = "move tab backward",
            ['alt+t'] = "set tab title",

        }
    }},

    ["kitty: windows"] = {{
        modifiers = {"Ctrl+Shift"},
        keys = {
            ['Return'] = "new window",
            n     = "new os window",
            w     = "close window",
            [']'] = "next window",
            ['['] = "previous window",
            f     = "move windows forward",
            b     = "move windows backward",
        }
    }},
    ["kitty: scrolling"] = {{
        modifiers = {"Ctrl+Shift"},
        keys = {
            ['Up'] = "line up",
            ['Down'] = "line down",
            ['Page_Up'] = "page up",
            ['Page_Down'] = "page down",
            ['Home'] = "top",
            ['End'] = "bottom",
            z     = "previous shell prompt",
        }
    }},
}

hotkeys_popup.add_hotkeys(kitty_keys)

return kitty

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
