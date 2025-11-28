-- ========================================================
-- AwesomeWM Keybindings Configuration
-- ========================================================
-- Configuración completa de atajos de teclado y mouse
-- Organizado por categorías: Awesome, Launcher, Client, Screen, Layout, Tags, etc.

-- ========================================================
-- Dependencies
-- ========================================================
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Widget externo para control de volumen
local volume_widget = require("ui.widget.volumen_pipewire")

-- ========================================================
-- Global Variables
-- ========================================================
local HOME_DIR = os.getenv("HOME")

-- Teclas modificadoras
local modkey = "Mod4"      -- Tecla Windows/Super
local shift = "Shift"
local ctrl = "Control"
local alt = "Mod1"

-- Aplicaciones por defecto
terminal = "kitty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- ========================================================
-- Mouse Bindings - Global
-- ========================================================
awful.mouse.append_global_mousebindings({
    -- Click derecho para abrir menú principal
    awful.button({}, 3, function() mymainmenu:toggle() end)
})

-- ========================================================
-- Mouse Bindings - Client (Ventanas)
-- ========================================================
client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        -- Click izquierdo: activar ventana
        awful.button({}, 1, function(c)
            c:activate { context = "mouse_click" }
        end),
        
        -- Mod4 + Click izquierdo: mover ventana
        awful.button({ modkey }, 1, function(c)
            c:activate { context = "mouse_click", action = "mouse_move" }
        end),
        
        -- Mod4 + Click derecho: redimensionar ventana
        awful.button({ modkey }, 3, function(c)
            c:activate { context = "mouse_click", action = "mouse_resize" }
        end),
    })
end)

-- ========================================================
-- AWESOME - Control del Window Manager
-- ========================================================
awful.keyboard.append_global_keybindings({
    -- Mostrar ayuda de atajos de teclado
    awful.key({ modkey }, "s", hotkeys_popup.show_help,
        {description = "show help", group = "awesome"}),
    
    -- Mostrar menú principal
    awful.key({ modkey }, "w", function() mymainmenu:show() end,
        {description = "show main menu", group = "awesome"}),
    
    -- Reiniciar AwesomeWM (recarga configuración)
    awful.key({ modkey, ctrl }, "r", awesome.restart,
        {description = "reload awesome", group = "awesome"}),
    
    -- Salir de AwesomeWM (cerrar sesión)
    awful.key({ modkey, shift }, "q", awesome.quit,
        {description = "quit awesome", group = "awesome"}),
})

-- ========================================================
-- LAUNCHER - Lanzadores de Aplicaciones
-- ========================================================
awful.keyboard.append_global_keybindings({
    -- Abrir terminal (kitty)
    awful.key({ modkey }, "Return", function() awful.spawn(terminal) end,
        {description = "open a terminal", group = "launcher"}),
    
    -- Rofi launcher (menú de aplicaciones)
    awful.key({ modkey }, "r", 
        function() 
            awful.spawn(HOME_DIR .. "/.config/rofi/launchers/type-6/launcher.sh") 
        end,
        {description = "rofi launcher", group = "launcher"}),
})

-- ========================================================
-- CLIENT - Navegación entre Ventanas
-- ========================================================
awful.keyboard.append_global_keybindings({
    -- Enfocar siguiente ventana (hacia abajo en stack)
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.byidx(1)
        end,
        {description = "focus next by index", group = "client"}),
    
    -- Enfocar ventana anterior (hacia arriba en stack)
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}),
    
    -- Intercambiar con siguiente ventana en el stack
    awful.key({ modkey, shift }, "j", 
        function() awful.client.swap.byidx(1) end,
        {description = "swap with next client by index", group = "client"}),
    
    -- Intercambiar con ventana anterior en el stack
    awful.key({ modkey, shift }, "k", 
        function() awful.client.swap.byidx(-1) end,
        {description = "swap with previous client by index", group = "client"}),
    
    -- Saltar a ventana urgente (notificación)
    awful.key({ modkey }, "u", awful.client.urgent.jumpto,
        {description = "jump to urgent client", group = "client"}),
    
    -- Restaurar ventana minimizada
    awful.key({ modkey, ctrl }, "n",
        function()
            local c = awful.client.restore()
            if c then
                c:activate { raise = true, context = "key.unminimize" }
            end
        end,
        {description = "restore minimized", group = "client"}),
})

-- ========================================================
-- CLIENT - Control de Ventana Enfocada
-- ========================================================
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        -- Alternar pantalla completa
        awful.key({ modkey }, "f",
            function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = "toggle fullscreen", group = "client"}),
        
        -- Cerrar ventana
        awful.key({ modkey, shift }, "c", function(c) c:kill() end,
            {description = "close", group = "client"}),
        
        -- Alternar modo flotante
        awful.key({ modkey, ctrl }, "space", awful.client.floating.toggle,
            {description = "toggle floating", group = "client"}),
        
        -- Mover ventana a posición master
        awful.key({ modkey, ctrl }, "Return", 
            function(c) c:swap(awful.client.getmaster()) end,
            {description = "move to master", group = "client"}),
        
        -- Mover ventana a otra pantalla
        awful.key({ modkey }, "o", function(c) c:move_to_screen() end,
            {description = "move to screen", group = "client"}),
        
        -- Alternar mantener encima (always on top)
        awful.key({ modkey }, "t", function(c) c.ontop = not c.ontop end,
            {description = "toggle keep on top", group = "client"}),
        
        -- Minimizar ventana
        awful.key({ modkey }, "n",
            function(c)
                c.minimized = true
            end,
            {description = "minimize", group = "client"}),
        
        -- Maximizar/restaurar ventana
        awful.key({ modkey }, "m",
            function(c)
                c.maximized = not c.maximized
                c:raise()
            end,
            {description = "(un)maximize", group = "client"}),
        
        -- Maximizar verticalmente
        awful.key({ modkey, ctrl }, "m",
            function(c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end,
            {description = "(un)maximize vertically", group = "client"}),
        
        -- Maximizar horizontalmente
        awful.key({ modkey, shift }, "m",
            function(c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end,
            {description = "(un)maximize horizontally", group = "client"}),
    })
end)

-- ========================================================
-- SCREEN - Navegación entre Pantallas
-- ========================================================
awful.keyboard.append_global_keybindings({
    -- Enfocar siguiente pantalla
    awful.key({ modkey, ctrl }, "j", 
        function() awful.screen.focus_relative(1) end,
        {description = "focus the next screen", group = "screen"}),
    
    -- Enfocar pantalla anterior
    awful.key({ modkey, ctrl }, "k", 
        function() awful.screen.focus_relative(-1) end,
        {description = "focus the previous screen", group = "screen"}),
})

-- ========================================================
-- LAYOUT - Control de Distribución de Ventanas
-- ========================================================
awful.keyboard.append_global_keybindings({
    -- Aumentar ancho del área master
    awful.key({ modkey }, "l", 
        function() awful.tag.incmwfact(0.05) end,
        {description = "increase master width factor", group = "layout"}),
    
    -- Disminuir ancho del área master
    awful.key({ modkey }, "h", 
        function() awful.tag.incmwfact(-0.05) end,
        {description = "decrease master width factor", group = "layout"}),
    
    -- Aumentar número de clientes master
    awful.key({ modkey, shift }, "h", 
        function() awful.tag.incnmaster(1, nil, true) end,
        {description = "increase the number of master clients", group = "layout"}),
    
    -- Disminuir número de clientes master
    awful.key({ modkey, shift }, "l", 
        function() awful.tag.incnmaster(-1, nil, true) end,
        {description = "decrease the number of master clients", group = "layout"}),
    
    -- Aumentar número de columnas
    awful.key({ modkey, ctrl }, "h", 
        function() awful.tag.incncol(1, nil, true) end,
        {description = "increase the number of columns", group = "layout"}),
    
    -- Disminuir número de columnas
    awful.key({ modkey, ctrl }, "l", 
        function() awful.tag.incncol(-1, nil, true) end,
        {description = "decrease the number of columns", group = "layout"}),
    
    -- Siguiente layout
    awful.key({ modkey }, "space", 
        function() awful.layout.inc(1) end,
        {description = "select next", group = "layout"}),
    
    -- Layout anterior
    awful.key({ modkey, shift }, "space", 
        function() awful.layout.inc(-1) end,
        {description = "select previous", group = "layout"}),
})

-- ========================================================
-- TAGS - Navegación entre Workspaces
-- ========================================================
awful.keyboard.append_global_keybindings({
    -- Ver tag anterior
    awful.key({ modkey, shift }, "Tab", awful.tag.viewprev,
        {description = "view previous", group = "tag"}),
    
    -- Ver siguiente tag
    awful.key({ modkey }, "Tab", awful.tag.viewnext,
        {description = "view next", group = "tag"}),
    
    -- Volver al tag anterior
    awful.key({ modkey }, "Escape", awful.tag.history.restore,
        {description = "go back", group = "tag"}),
})

-- ========================================================
-- TAGS - Selección por Número (1-9)
-- ========================================================
awful.keyboard.append_global_keybindings({
    -- Mod4 + [1-9]: Ver solo ese tag
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    
    -- Mod4 + Ctrl + [1-9]: Alternar visibilidad de tag
    awful.key {
        modifiers   = { modkey, ctrl },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    
    -- Mod4 + Shift + [1-9]: Mover ventana enfocada a tag
    awful.key {
        modifiers = { modkey, shift },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    
    -- Mod4 + Ctrl + Shift + [1-9]: Alternar ventana en tag
    awful.key {
        modifiers   = { modkey, ctrl, shift },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
    
    -- Mod4 + Numpad [1-9]: Seleccionar layout directamente
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function(index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    }
})

-- ========================================================
-- VOLUME - Control de Volumen
-- ========================================================
awful.keyboard.append_global_keybindings({
    -- Aumentar volumen 5%
    awful.key({ modkey }, "]", 
        function() volume_widget:inc(5) end,
        {description = "increase volume 5%", group = "media"}),
    
    -- Disminuir volumen 5%
    awful.key({ modkey }, "[", 
        function() volume_widget:dec(5) end,
        {description = "decrease volume 5%", group = "media"}),
    
    -- Mutear/desmutear volumen
    awful.key({ modkey }, "\\", 
        function() volume_widget:toggle() end,
        {description = "toggle mute", group = "media"}),
})

-- ========================================================
-- BRIGHTNESS - Control de Brillo
-- ========================================================
awful.keyboard.append_global_keybindings({
    -- Aumentar brillo 5%
    awful.key({ modkey, shift }, "]", 
        function() awful.util.spawn("brightnessctl set 5%+", false) end,
        {description = "increase brightness 5%", group = "media"}),
    
    -- Disminuir brillo 5%
    awful.key({ modkey, shift }, "[", 
        function() awful.util.spawn("brightnessctl set 5%-", false) end,
        {description = "decrease brightness 5%", group = "media"}),
})

-- ========================================================
-- SCREENSHOT - Captura de Pantalla
-- ========================================================
awful.keyboard.append_global_keybindings({
    -- Captura de pantalla con Flameshot
    awful.key({ modkey }, "p", 
        function() awful.util.spawn("flameshot gui") end,
        {description = "screenshot with flameshot", group = "screenshot"}),
})

-- ========================================================
-- SYSTEM - Utilidades del Sistema
-- ========================================================
awful.keyboard.append_global_keybindings({
    -- Menú de apagado/reinicio (Rofi PowerMenu)
    awful.key({ modkey }, "q", 
        function() 
            awful.util.spawn_with_shell(HOME_DIR .. "/.config/rofi/powermenu/powermenu.sh") 
        end,
        {description = "power menu", group = "system"}),
    
    -- Bloquear pantalla (betterlockscreen)
    awful.key({ modkey }, "b", 
        function() 
            awful.util.spawn_with_shell(
                "betterlockscreen --lock blur && betterlockscreen -u \"$(find $HOME/media/wallpaper -mindepth 1 -maxdepth 1 -type d | shuf -n1)\""
            ) 
        end,
        {description = "lock screen", group = "system"}),
    
    -- Historial de portapapeles (Rofi + Greenclip)
    awful.key({ modkey }, "i", 
        function() 
            awful.util.spawn_with_shell("rofi -modi 'clipboard:greenclip print' -show clipboard -theme fancy") 
        end,
        {description = "clipboard history", group = "system"}),
    
    -- Gestor de archivos gráfico (Thunar)
    awful.key({ modkey }, "e", 
        function() awful.util.spawn_with_shell("thunar") end,
        {description = "file manager (thunar)", group = "system"}),
    
    -- Gestor de archivos terminal (lf)
    awful.key({ modkey }, "a", 
        function() 
            awful.util.spawn_with_shell(terminal .. " -T 'FileManager' -e lf") 
        end,
        {description = "file manager (lf)", group = "system"}),
})
