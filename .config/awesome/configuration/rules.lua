-- Rules
-- ~~~~~


-- requirements
-- ~~~~~~~~~~~~
local awful = require "awful"
local ruled = require "ruled"
local gears = require "gears"
local beautiful = require "beautiful"

-- connect to signal
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id         = "global",
        rule       = { },
        properties = {
                    --  border_width = beautiful.border_width,
                     --border_color = "#de8f78",
            focus     = awful.client.focus.filter,
            raise     = true,
            screen    = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen+awful.placement.centered
        }
    }

    -- Floating clients.
    ruled.client.append_rule {
        id       = "floating",
        rule_any = {
            instance = { "copyq", "pinentry" },
			class = {
				"Arandr",
				"Steam",
				--"XTerm",
				"Virt-manager",
				"Nm-connection-editor",
				"Xfce4-power-manager-settings",
				"Pavucontrol",
				"Qalculate-gtk",
				"Engrampa",
				"Lxappearance",
				"Gnome-disks",
				"Nitrogen",
				"Audacious",
				"qt5ct",
				"qt6ct",
				"Kvantum Manager",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin",  -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"alsamixer",
				"xtightvncviewer"
			},
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name    = {
                "Event Tester",  -- xev.
            },
            role    = {
                "AlarmWindow",    -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    }

    -- Center Placement
    ruled.client.append_rule {
        --id = "center_placement",
        id = "tile",
        rule_any = {
            type = {"dialog"},
            class = {"Steam", "discord", "markdown_input", "nemo", "thunar", "pcmanfm" },
            instance = {"markdown_input",},
            role = {"GtkFileChooserDialog"}
        },
        properties = {placement = awful.placement.center}
    }
    
    -- Add titlebars to normal clients and dialogs
    ruled.client.append_rule {
        id         = "titlebars",
        rule_any   = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = false      }
    }

    --[[
    ruled.client.append_rule {
        rule_any    = {
            class = {"firefox"}
    },
        properties = {
            tag = screen[1].tags[2],
    },
    }--]]

--
ruled.client.append_rule {
        rule_any    = {
            class = {"kitty"}
    },
    --[[    properties = {
            tag = screen[1].tags[1][2],
            switch_to_tags = true
    },--]]
}
--[[
    ruled.client.append_rule {
        rule_any    = {
            class = {"obsidian"}
    },
        properties = {
            tag = screen[1].tags[3],
    },
}--]]
end)

awful.spawn.single_instance("kitty")
--awful.spawn.single_instance("firefox")
--awful.spawn.single_instance("obsidian")


ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            screen           = awful.screen.preferred,
            implicit_timeout = 5,
            position         = "top_right",
        }
    }
end)

-- Round Corners :
client.connect_signal("manage", function (c)
    c.shape = function(cr,w,h)
        gears.shape.rounded_rect(cr,w,h,8)
    end
end)
