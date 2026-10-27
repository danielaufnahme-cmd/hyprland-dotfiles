-- ============================================================
-- Hyprland config, everything in one file (generated 2026-10-27)
-- Caelestia-based Hyprland Lua config + personal overrides.
-- This is a reference/archive copy: each section below is a separate
-- file in the real setup (path shown in each header).
-- Order = load order. Later sections (user overrides) win.
-- ============================================================

-- ############################################################
-- FILE: ~/.config/hypr/hyprland.lua
-- ############################################################

local home   = os.getenv("HOME")
local hypr   = home .. "/.config/hypr"
package.path = package.path .. ";" .. home .. "/.config/caelestia/?.lua"

-- Create a file if it doesn't exist, optionally with initial content
local function maybe_create(file, content)
    local f = io.open(file)

    if f then
        f:close()
        return
    end

    f = io.open(file, "w")
    if f then
        if content then f:write(content) end
        f:close()
    end
end

-- Copy src to dst, but only if dst doesn't already exist
local function maybe_copy(src, dst)
    local out = io.open(dst)
    if out then
        out:close()
        return
    end

    local input = io.open(src, "r")
    if not input then return end

    out = io.open(dst, "w")
    if out then
        out:write(input:read("*a"))
        out:close()
    end
    input:close()
end

-- Maybe set current colours to defaults
maybe_copy(hypr .. "/scheme/default.lua", hypr .. "/scheme/current.lua")

-- User variables
maybe_create(home .. "/.config/caelestia/hypr-vars.lua", "return {}\n")
local overrides = require("hypr-vars")
if type(overrides) == "table" then
    local vars = require("variables")
    for k, v in pairs(overrides) do
        vars[k] = v
    end
end

-- Default monitor conf
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

-- Pin the real screen so test headless outputs can't move or resize it
hl.monitor({
    output   = "DP-1",
    mode     = "2560x1440@240",
    position = "0x0",
    scale    = 1,
})

-- Configs
require("hyprland.env")
require("hyprland.general")
require("hyprland.input")
require("hyprland.misc")
require("hyprland.animations")
require("hyprland.decoration")
require("hyprland.group")
require("hyprland.execs")
require("hyprland.rules")
require("hyprland.gestures")
require("hyprland.keybinds")

-- User configs
maybe_create(home .. "/.config/caelestia/hypr-user.lua")
require("hypr-user")

-- ############################################################
-- FILE: ~/.config/hypr/variables.lua
-- ############################################################

local scheme = require("scheme.current")

return {
    ------------------
    ---- HYPRLAND ----
    ------------------

    -- Apps
    terminal                   = "foot",
    browser                    = "firefox",
    editor                     = "codium",
    fileExplorer               = "thunar",
    audioSettings              = "pwvucontrol",

    -- Touchpad
    touchpadDisableTyping      = true,
    touchpadScrollFactor       = 0.3,
    gestureFingers             = 3,
    workspaceSwipeFingers      = 4,
    gestureFingersMore         = 4,

    -- Blur
    blurEnabled                = true,
    blurSpecialWs              = false,
    blurPopups                 = true,
    blurInputMethods           = true,
    blurSize                   = 8,
    blurPasses                 = 2,
    blurXray                   = false,

    -- Shadow
    shadowEnabled              = true,
    shadowRange                = 15,
    shadowRenderPower          = 4,
    shadowColour               = "rgba(" .. scheme.inversePrimary .. "10)",

    -- Gaps
    workspaceGaps              = 20,
    windowGapsIn               = 5,
    windowGapsOut              = 10,
    singleWindowGapsOut        = 20,

    -- Window styling
    windowOpacity              = 0.95,
    windowRounding             = 15,
    windowRoundingPower        = 2,
    windowBorderSize           = 1,
    activeWindowBorderColour   = "rgba(" .. scheme.primary .. "e6)",
    inactiveWindowBorderColour = "rgba(" .. scheme.onSurfaceVariant .. "11)",

    -- Misc
    volumeStep                 = 5,
    volumeMax                  = 100,
    cursorTheme                = "Adwaita",
    cursorSize                 = 24,
    sleepGestureCmd            = "systemctl suspend-then-hibernate",

    ------------------
    ---- KEYBINDS ----
    ------------------

    -- Modifier only, the actual binds will be mod + 0-9. These should be strings and not arrays.
    kbGoToWs                   = "SUPER",
    kbGoToWsGroup              = "CTRL + SUPER",
    kbMoveWinToWs              = "SUPER + ALT",
    kbMoveWinToWsGroup         = "CTRL + SUPER + ALT",

    -- All the following binds can be either an array of binds to bind multiple keys, or a single string.

    -- Workspaces
    kbMoveWinToWsSpecial       = { "SUPER + ALT + S", "CTRL + SUPER + SHIFT + Up" },
    kbMoveWinFromWsSpecial     = "CTRL + SUPER + SHIFT + Down",
    kbMoveWinToWsNext          = { "SUPER + ALT + mouse_down", "SUPER + ALT + Page_Down", "CTRL + SUPER + SHIFT + Right" },
    kbMoveWinToWsPrev          = { "SUPER + ALT + mouse_up", "SUPER + ALT + Page_Up", "CTRL + SUPER + SHIFT + Left" },
    kbNextWs                   = { "SUPER + mouse_down", "CTRL + SUPER + Right", "SUPER + Page_Down" },
    kbPrevWs                   = { "SUPER + mouse_up", "CTRL + SUPER + Left", "SUPER + Page_Up" },
    kbNextWsGroup              = "CTRL + SUPER + mouse_down",
    kbPrevWsGroup              = "CTRL + SUPER + mouse_up",

    -- Window Group
    kbWindowCycleNext          = "ALT + TAB",
    kbWindowCyclePrev          = "SHIFT + ALT + TAB",
    kbWindowGroupCycleNext     = "CTRL + ALT + TAB",
    kbWindowGroupCyclePrev     = "CTRL + SHIFT + ALT + TAB",
    kbUngroup                  = "SUPER + U",
    kbToggleGroup              = "SUPER + Comma",
    kbGroupLockActive          = "SUPER + SHIFT + Comma",

    -- Window Actions
    kbWindowDecreaseWidth      = { "SUPER + Minus", "SUPER + ALT + Left" },
    kbWindowIncreaseWidth      = { "SUPER + Equal", "SUPER + ALT + Right" },
    kbWindowDecreaseHeight     = { "SUPER + SHIFT + Minus", "SUPER + ALT + Up" },
    kbWindowIncreaseHeight     = { "SUPER + SHIFT + Equal", "SUPER + ALT + Down" },

    kbMoveWindow               = "SUPER + Z",
    kbResizeWindow             = "SUPER + X",
    kbCenterWindow             = "CTRL + SUPER + Backslash",
    kbNormalizeWindow          = "CTRL + SUPER + ALT + Backslash",
    kbWindowPip                = "SUPER + ALT + Backslash",
    kbPinWindow                = "SUPER + P",
    kbWindowFullscreen         = "SUPER + F",
    kbWindowBorderedFullscreen = "SUPER + ALT + F",
    kbToggleWindowFloating     = "SUPER + ALT + Space",
    kbCloseWindow              = "SUPER + Q",

    -- Special workspaces toggles
    kbSpecialWs                = "SUPER + S",
    kbSystemMonitorWs          = "CTRL + SHIFT + Escape",
    kbMusicWs                  = "SUPER + M",
    kbCommunicationWs          = "SUPER + D",
    kbTodoWs                   = "SUPER + R",

    -- Apps
    kbTerminal                 = "SUPER + T",
    kbBrowser                  = "SUPER + W",
    kbEditor                   = "SUPER + C",
    kbFileExplorer             = "SUPER + E",
    kbAudioSettings            = "CTRL + ALT + V",

    -- Utilities
    kbScreenshot               = "Print",
    kbScreenshotFreeze         = "SUPER + SHIFT + S",
    kbScreenshotFull           = "SUPER + SHIFT + P",
    kbScreenshotRegion         = "SUPER + SHIFT + ALT + S",
    kbRecord                   = "CTRL + ALT + R",
    kbRecordSound              = "SUPER + ALT + R",
    kbRecordRegion             = "SUPER + SHIFT + ALT + R",
    kbColorPicker              = "SUPER + SHIFT + C",
    kbDictate                  = "SUPER + B",
    kbDictateCancel            = "SUPER + SHIFT + D",

    -- Media
    kbMediaToggle              = "CTRL + SUPER + Space",
    kbMediaNext                = "CTRL + SUPER + Equal",
    kbMediaPrev                = "CTRL + SUPER + Minus",
    kbMediaStop                = "CTRL + SUPER + Backspace",
    kbVolumeMute               = "SUPER + SHIFT + M",

    -- Misc
    kbLauncher                 = "SUPER + Space",
    kbSession                  = "CTRL + ALT + Delete",
    kbShowSidebar              = "SUPER + N",
    kbClearNotifs              = "CTRL + ALT + C",
    kbShowPanels               = "SUPER + K",
    kbLock                     = "SUPER + L",
    kbRestoreLock              = "SUPER + ALT + L",
    kbSleep                    = "SUPER + SHIFT + L",

    -- Clipboard and emoji picker
    kbClipboard                = "SUPER + V",
    kbClipboardDel             = "SUPER + ALT + V",
    kbClipboardPasteLatest     = "CTRL + SHIFT + ALT + V",
    kbEmoji                    = "SUPER + Period",
}

-- ############################################################
-- FILE: ~/.config/hypr/scheme/default.lua
-- ############################################################

return {
    primary_paletteKeyColor         = "7171ac",
    secondary_paletteKeyColor       = "76758e",
    tertiary_paletteKeyColor        = "9e648e",
    neutral_paletteKeyColor         = "78767b",
    neutral_variant_paletteKeyColor = "777680",
    background                      = "131317",
    onBackground                    = "e5e1e7",
    surface                         = "131317",
    surfaceDim                      = "131317",
    surfaceBright                   = "39393d",
    surfaceContainerLowest          = "0e0e12",
    surfaceContainerLow             = "1c1b1f",
    surfaceContainer                = "201f23",
    surfaceContainerHigh            = "2a292e",
    surfaceContainerHighest         = "353438",
    onSurface                       = "e5e1e7",
    surfaceVariant                  = "47464f",
    onSurfaceVariant                = "c8c5d1",
    inverseSurface                  = "e5e1e7",
    inverseOnSurface                = "313034",
    outline                         = "918f9a",
    outlineVariant                  = "47464f",
    shadow                          = "000000",
    scrim                           = "000000",
    surfaceTint                     = "c2c1ff",
    primary                         = "c2c1ff",
    onPrimary                       = "2a2a60",
    primaryContainer                = "7171ac",
    onPrimaryContainer              = "ffffff",
    inversePrimary                  = "595992",
    secondary                       = "c6c4e0",
    onSecondary                     = "2e2e44",
    secondaryContainer              = "45455c",
    onSecondaryContainer            = "b4b2ce",
    tertiary                        = "f5b2e0",
    onTertiary                      = "4e1e44",
    tertiaryContainer               = "bb7da9",
    onTertiaryContainer             = "000000",
    error                           = "ffb4ab",
    onError                         = "690005",
    errorContainer                  = "93000a",
    onErrorContainer                = "ffdad6",
    primaryFixed                    = "e2dfff",
    primaryFixedDim                 = "c2c1ff",
    onPrimaryFixed                  = "14134a",
    onPrimaryFixedVariant           = "414178",
    secondaryFixed                  = "e2e0fd",
    secondaryFixedDim               = "c6c4e0",
    onSecondaryFixed                = "19192e",
    onSecondaryFixedVariant         = "45455c",
    tertiaryFixed                   = "ffd7f0",
    tertiaryFixedDim                = "f5b2e0",
    onTertiaryFixed                 = "35082e",
    onTertiaryFixedVariant          = "68355c",
    term0                           = "353434",
    term1                           = "ac73ff",
    term2                           = "44def5",
    term3                           = "ffdcf2",
    term4                           = "99aad8",
    term5                           = "b49fea",
    term6                           = "9dceff",
    term7                           = "e8d3de",
    term8                           = "ac9fa9",
    term9                           = "c093ff",
    term10                          = "89ecff",
    term11                          = "fff0f6",
    term12                          = "b5c1dd",
    term13                          = "c9b5f4",
    term14                          = "bae0ff",
    term15                          = "ffffff",
    rosewater                       = "f7eff9",
    flamingo                        = "e9def3",
    pink                            = "e2d7ff",
    mauve                           = "bfb8ff",
    red                             = "c1a5fd",
    maroon                          = "c9b5ed",
    peach                           = "e0c2f9",
    yellow                          = "ffecf3",
    green                           = "c8e3ff",
    teal                            = "d3dfff",
    sky                             = "d0daff",
    sapphire                        = "b7c5ff",
    blue                            = "b0b8ff",
    lavender                        = "c7c8ff",
    text                            = "e5e1e7",
    subtext1                        = "c8c5d1",
    subtext0                        = "918f9a",
    overlay2                        = "7e7c86",
    overlay1                        = "6b6972",
    overlay0                        = "595860",
    surface2                        = "48474e",
    surface1                        = "37373d",
    surface0                        = "25252a",
    base                            = "131317",
    mantle                          = "131317",
    crust                           = "121216",
    success                         = "B5CCBA",
    onSuccess                       = "213528",
    successContainer                = "374B3E",
    onSuccessContainer              = "D1E9D6",
}

-- ############################################################
-- FILE: ~/.config/hypr/hyprland/env.lua
-- ############################################################

local vars = require("variables")

-- Themes
hl.env("QT_QPA_PLATFORMTHEME", "qtengine")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("XCURSOR_THEME", vars.cursorTheme)
hl.env("XCURSOR_SIZE", vars.cursorSize)

-- Toolkit backends
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland,x11,windows")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- XDG specifications
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Others
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")

-- ############################################################
-- FILE: ~/.config/hypr/hyprland/general.lua
-- ############################################################

local vars = require("variables")

hl.config({
    general = {
        layout          = "dwindle",

        allow_tearing   = false, -- Allows `immediate` window rule to work

        gaps_workspaces = vars.workspaceGaps,
        gaps_in         = vars.windowGapsIn,
        gaps_out        = vars.windowGapsOut,
        border_size     = vars.windowBorderSize,

        col             = {
            active_border   = vars.activeWindowBorderColour,
            inactive_border = vars.inactiveWindowBorderColour,
        },
    },

    dwindle = {
        preserve_split = true,
        smart_split    = false,
        smart_resizing = true,
    },

    scrolling = {
        fullscreen_on_one_column = true,
        focus_fit_method         = 1,
        column_width             = 0.5,
        follow_focus             = true,
        follow_min_visible       = 0.0,
        explicit_column_widths   = "0.35, 0.5, 0.65, 1.0",
    },
})

-- ############################################################
-- FILE: ~/.config/hypr/hyprland/input.lua
-- ############################################################

local vars = require("variables")

hl.config({
    input = {
        kb_layout          = "us",
        numlock_by_default = false,
        repeat_delay       = 250,
        repeat_rate        = 35,
        focus_on_close     = 1,

        touchpad           = {
            natural_scroll       = true,
            disable_while_typing = vars.touchpadDisableTyping,
            scroll_factor        = vars.touchpadScrollFactor,
        },
    },

    binds = {
        scroll_event_delay = 0,
    },

    cursor = {
        hotspot_padding = 1,
        -- NVIDIA hardware cursor randomly vanishes; draw it in software instead
        no_hardware_cursors = true,
    },
})

-- ############################################################
-- FILE: ~/.config/hypr/hyprland/misc.lua
-- ############################################################

local scheme = require("scheme.current")

hl.config({
    misc = {
        animate_manual_resizes       = false,
        animate_mouse_windowdragging = false,

        disable_hyprland_logo        = true,
        force_default_wallpaper      = 0,

        on_focus_under_fullscreen    = 2,
        allow_session_lock_restore   = true,
        middle_click_paste           = false,
        focus_on_activate            = true,
        session_lock_xray            = true,

        mouse_move_enables_dpms      = true,
        key_press_enables_dpms       = true,

        -- games like BeamNG block their main thread for long stretches while
        -- loading levels; give them much longer before the "Not Responding" popup
        anr_missed_pings             = 30,

        background_color             = "rgb(" .. scheme.surfaceContainer .. ")",
    },

    debug = {
        error_position = 1
    }
})

-- ############################################################
-- FILE: ~/.config/hypr/hyprland/animations.lua
-- ############################################################

hl.config({
    animations = {
        enabled = true,
    },
})

-- Animation curves
hl.curve("specialWorkSwitch", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("emphasizedAccel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } })
hl.curve("emphasizedDecel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("standard", { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } })

-- Animation configs
hl.animation({ leaf = "layersIn", enabled = true, speed = 5, bezier = "emphasizedDecel", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 4, bezier = "emphasizedAccel", style = "slide" })
hl.animation({ leaf = "fadeLayers", enabled = true, speed = 5, bezier = "standard" })

hl.animation({ leaf = "windowsIn", enabled = true, speed = 3.5, bezier = "emphasizedDecel" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "emphasizedAccel" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "standard" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "standard" })

hl.animation({
    leaf    = "specialWorkspace",
    enabled = true,
    speed   = 3,
    bezier  = "specialWorkSwitch",
    style   = "slidefadevert 15%"
})
hl.animation({ leaf = "fade", enabled = true, speed = 6, bezier = "standard" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 6, bezier = "standard" })
hl.animation({ leaf = "border", enabled = true, speed = 6, bezier = "standard" })

-- ############################################################
-- FILE: ~/.config/hypr/hyprland/decoration.lua
-- ############################################################

local vars = require("variables")

hl.config({
    decoration = {
        rounding = vars.windowRounding,
        rounding_power = vars.windowRoundingPower,

        blur = {
            enabled           = vars.blurEnabled,
            xray              = vars.blurXray,
            special           = vars.blurSpecialWs,
            ignore_opacity    = true, -- Allows opacity blurring
            new_optimizations = true,
            popups            = vars.blurPopups,
            input_methods     = vars.blurInputMethods,
            size              = vars.blurSize,
            passes            = vars.blurPasses,
        },

        shadow = {
            enabled      = vars.shadowEnabled,
            range        = vars.shadowRange,
            render_power = vars.shadowRenderPower,
            color        = vars.shadowColour,
        },
    },
})

-- ############################################################
-- FILE: ~/.config/hypr/hyprland/group.lua
-- ############################################################

local scheme = require("scheme.current")
local vars   = require("variables")

hl.config({
    group = {
        col = {
            border_active          = vars.activeWindowBorderColour,
            border_inactive        = vars.inactiveWindowBorderColour,
            border_locked_active   = vars.activeWindowBorderColour,
            border_locked_inactive = vars.inactiveWindowBorderColour,
        },
        groupbar = {
            font_family               = "JetBrains Mono NF",
            font_size                 = 15,
            gradients                 = true,
            gradient_round_only_edges = false,
            gradient_rounding         = 5,
            height                    = 25,
            indicator_height          = 0,
            gaps_in                   = 3,
            gaps_out                  = 3,
            text_color                = "rgb(" .. scheme.onPrimary .. ")",
            col                       = {
                active          = "rgba(" .. scheme.primary .. "d4)",
                inactive        = "rgba(" .. scheme.outline .. "d4)",
                locked_active   = "rgba(" .. scheme.primary .. "d4)",
                locked_inactive = "rgba(" .. scheme.secondary .. "d4)",
            },
        },
    },
})

-- ############################################################
-- FILE: ~/.config/hypr/hyprland/gestures.lua
-- ############################################################

local vars = require("variables")
local fn   = require("utils.functions")

hl.config({
    gestures = {
        workspace_swipe_distance                 = 700,
        workspace_swipe_cancel_ratio             = 0.15,
        workspace_swipe_min_speed_to_force       = 5,
        workspace_swipe_direction_lock           = true,
        workspace_swipe_direction_lock_threshold = 10,
        workspace_swipe_create_new               = true,
    },
})

hl.gesture({ fingers = vars.workspaceSwipeFingers, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = vars.gestureFingers, direction = "up", action = "special", workspace_name = "special" })
hl.gesture({
    fingers   = vars.gestureFingers,
    direction = "down",
    action    = fn.toggle("specialws"),
})
hl.gesture({
    fingers   = vars.gestureFingersMore,
    direction = "down",
    action    = function()
        hl.exec_cmd(vars.sleepGestureCmd)
    end,
})

-- ############################################################
-- FILE: ~/.config/hypr/hyprland/execs.lua
-- ############################################################

local vars = require("variables")
local fn   = require("utils.functions")

hl.on("hyprland.start", function()
    -- Keyring and auth
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    -- Clipboard history
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- Auto delete trash 30 days old
    hl.exec_cmd("trash-empty 30")

    -- Cursors
    hl.exec_cmd("hyprctl setcursor " .. vars.cursorTheme .. " " .. vars.cursorSize)
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme " .. vars.cursorTheme)
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size " .. vars.cursorSize)

    -- Location provider and night light
    hl.exec_cmd("/usr/lib/geoclue-2.0/demos/agent")
    hl.exec_cmd("sleep 1 && gammastep")

    -- Forward bluetooth media commands to MPRIS
    hl.exec_cmd("mpris-proxy")

    -- Start shell
    hl.exec_cmd("env MALLOC_ARENA_MAX=2 caelestia shell -d")
end)

-- Resizer listeners
local function apply_resizer_rules(win)
    local match_str = function(pattern, field, exact)
        return function(w)
            return w[field] and string.find(w[field], pattern, 1, exact)
        end
    end
    local match_title = function(pattern, exact) return match_str(pattern, "title", exact) end
    local match_class = function(pattern, exact) return match_str(pattern, "class", exact) end

    local match_tag = function(tag)
        return function(w)
            for _, t in ipairs(w.tags) do
                if t == tag or t == tag .. "*" then
                    return true
                end
            end
            return false
        end
    end

    local float_center = {
        hl.dsp.window.float({ action = "on", window = win }),
        hl.dsp.window.center({ window = win }),
    }
    local pip_actions = fn.move_actions(win) or {}

    -- Bitwarden
    fn.resizer(win, match_class("Bitwarden", true), 20, 54, float_center)                                                -- Native app
    fn.resizer(win, match_title("^Extension: %(Bitwarden Password Manager%) %- Bitwarden", false), 20, 54, float_center) -- Firefox
    fn.resizer(win, match_class("nngceckbapebfimnlniiiahkandclblb", true), 20, 54, float_center)                         -- Chromium

    -- Picture in picture
    fn.resizer(win, match_title("Picture[- ]in[- ][Pp]icture", false), 0, 0, pip_actions)

    -- Tags, because window rules are unreliable
    fn.resizer(win, match_tag("float_60_70"), 60, 70, float_center)
    fn.resizer(win, match_tag("float_70_80"), 70, 80, float_center)
    fn.resizer(win, match_tag("float_50_60"), 50, 60, float_center)
end

hl.on("window.class", apply_resizer_rules)
hl.on("window.title", apply_resizer_rules)
hl.on("window.open", apply_resizer_rules)


-- Tag shenanigans, there is no way to only detect when a window's tags change
local lastTags = {}

local function tag_key(tags)
    local copy = {}
    for _, tag in ipairs(tags) do
        copy[#copy + 1] = tag:gsub("%*$", "")
    end
    table.sort(copy)
    return table.concat(copy, "\0")
end

hl.on("window.update_rules", function(win)
    local id = win.stable_id
    local key = tag_key(win.tags)
    if lastTags[id] == key then
        return
    end
    lastTags[id] = key
    apply_resizer_rules(win)
end)

hl.on("window.close", function(win)
    lastTags[win.stable_id] = nil
end)

-- ############################################################
-- FILE: ~/.config/hypr/hyprland/rules.lua
-- ############################################################

local vars = require("variables")

-- Tags an array of window matches. If `field` is given, matches should be an
-- array of strings. Otherwise, it should be an array of tables.
local function tagged_rule(tag, matches, field)
    for _, match in ipairs(matches) do
        if field then
            local table = {}
            table[field] = match
            match = table
        end
        hl.window_rule({ match = match, tag = "+" .. tag })
    end
end

local function create_tag(tag, rules)
    local rule = { match = { tag = tag } }
    for k, v in pairs(rules) do
        rule[k] = v
    end
    hl.window_rule(rule)
end

-- All tags
local opaque_tag = "opaque"
local float_tag = "float"
local float_60_70_tag = "float_60_70"
local float_70_80_tag = "float_70_80"
local float_50_60_tag = "float_50_60"
local game_tag = "game"
local xwl_popup_tag = "xwl_popup"
local system_monitor_tag = "system_monitor"
local music_player_tag = "music_player"
local communication_app_tag = "communication_app"
local todo_app_tag = "todo_app"


----------------------
---- Window rules ----
----------------------

-- Apply default opacity to all windows except fullscreen
hl.window_rule({ match = { fullscreen = false }, opacity = vars.windowOpacity .. " override" })

-- Center all floating windows except xwayland windows (xwayland popups count as windows)
hl.window_rule({ match = { float = true, xwayland = false }, center = true })

-- Picture in picture (move and resize done via resizer in execs.lua)
hl.window_rule({
    match             = { title = "Picture(-| )in(-| )[Pp]icture" },
    move              = "(monitor_w*0.98-window_w) (monitor_h*0.97-window_h)", -- Initial move so window doesn't jump so much
    pin               = true,
    float             = true,
    keep_aspect_ratio = true,
})


----------------------
---- Tagged rules ----
----------------------

-- Opaque apps
tagged_rule(opaque_tag, {
    "foot",                          -- Terminal
    "equibop",                       -- Discord client
    "org.quickshell",                -- Quickshell
    "feh|imv|swappy",                -- Image viewers
    "krita|gimp|inkscape|darktable", -- Image editors
    "resolve|kdenlive|shotcut",      -- Video editors
    "blender|godot",                 -- 3D editors
}, "class")


-- Floating apps
tagged_rule(float_tag, {
    "guifetch",                           -- System info
    "yad|zenity",                         -- Dialogs
    "wev",                                -- Input detector
    "org.gnome.FileRoller|file-roller",   -- Archive manager
    "blueman-manager",                    -- Bluetooth GUI
    "com.github.GradienceTeam.Gradience", -- GTK themer (deprecated)
    "feh|imv|swappy",                     -- Image viewers
    "org.quickshell",                     -- Quickshell
}, "class")
tagged_rule(float_tag, {
    "File (Operation|Upload)( Progress)?", -- File manager operation progress (upload, move, copy, etc)
    ".* Properties",                       -- File properties
    'Rename ".*"',                         -- File renaming
}, "title")


-- Sized floaters
-- 60% x 70%
tagged_rule(float_60_70_tag, {
    "(Select|Open)( a)? (File|Folder)(s)?", -- File dialogs
    "Save As",                              -- Save dialogs
    "Library",                              -- * I don't remember what this matches...
}, "title")
tagged_rule(float_60_70_tag, {
    { title = "(Save|Export) Image", class = "gimp" }, -- GIMP export/save
})
tagged_rule(float_60_70_tag, {
    { title = "Blender File View", class = "blender" }, -- Blender file dialogs
})
tagged_rule(float_60_70_tag, {
    "org.pulseaudio.pavucontrol|com.saivert.pwvucontrol", -- Audio control
    "yad-icon-browser",                                   -- GTK icon browser
}, "class")

-- 70% x 80%
tagged_rule(float_70_80_tag, {
    "org.gnome.Settings", -- System settings
}, "class")

-- 50% x 60%
tagged_rule(float_50_60_tag, {
    "nwg-look",              -- GTK theme manager
    "system-config-printer", -- Printer config
}, "class")


-- Games
tagged_rule(game_tag, {
    "steam_app_[0-9]+",  -- Steam games
    "steam_app_default", -- Lutris games
    "gamescope",         -- Gamescope
}, "class")


-- Xwayland popups
tagged_rule(xwl_popup_tag, {
    { xwayland = true, title = "win[0-9]+" },
    { xwayland = true, title = "",         class = "", initial_title = "", initial_class = "" }
})


-- Special workspaces
tagged_rule(system_monitor_tag, { "btop" }, "class")
tagged_rule(music_player_tag, {
    "feishin|Supersonic|Plexamp",                                  -- Self hosted
    "Spotify",                                                     -- Spotify
    "Cider",                                                       -- Apple music
    "com.github.th-ch.youtube-music|com-maxrave-simpmusic-MainKt", -- YouTube music
}, "class")
tagged_rule(music_player_tag, {
    "Spotify|Spotify Free" -- Spotify wayland, it has no class for some reason
}, "initial_title")
tagged_rule(communication_app_tag, {
    "discord|equibop|vesktop", -- Discord clients
    "whatsapp"                 -- Whatsapp
}, "class")
tagged_rule(todo_app_tag, {
    "todoist" -- Todoist
}, "class")


-----------------------
---- Per app rules ----
-----------------------

-- Steam
tagged_rule(float_tag, { { class = "steam", title = "Friends List" } })
tagged_rule(xwl_popup_tag, { { class = "steam", title = "" } })

-- Ueberzugpp
hl.window_rule({ match = { class = "ueberzugpp_.*" }, float = true, no_initial_focus = true })

-- Autodesk Fusion 360
hl.window_rule({ match = { class = "fusion360.exe", title = "Fusion360|(Marking Menu)" }, no_blur = true })

-- Minecraft launcher consoles
tagged_rule(float_tag, {
    { class = "com-atlauncher-App", title = "ATLauncher Console" },
    { class = "PandoraLauncher",    title = "Minecraft Game Output" },
})


-------------------------
---- Tag definitions ----
-------------------------
-- These have to come after all uses of window tagging. Thank you Hyprland...

create_tag(opaque_tag, { opaque = true })
create_tag(float_tag, { float = true })
create_tag(float_50_60_tag, { float = true, size = "(monitor_w*0.5) (monitor_h*0.6)", center = true })
create_tag(float_60_70_tag, { float = true, size = "(monitor_w*0.6) (monitor_h*0.7)", center = true })
create_tag(float_70_80_tag, { float = true, size = "(monitor_w*0.7) (monitor_h*0.8)", center = true })
create_tag(game_tag, { opaque = true, immediate = true, idle_inhibit = "always" })
create_tag(xwl_popup_tag, {
    no_dim = true,
    no_shadow = true,
    no_blur = true,
    opaque = true,
    rounding = math.min(10, vars.windowRounding), -- Popups are usually small, so we want to limit the rounding
})
create_tag(system_monitor_tag, { workspace = "special:sysmon" })
create_tag(music_player_tag, { workspace = "special:music" })
create_tag(communication_app_tag, { workspace = "special:communication" })
create_tag(todo_app_tag, { workspace = "special:todo" })


-------------------------
---- Workspace rules ----
-------------------------

hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = vars.singleWindowGapsOut })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = vars.singleWindowGapsOut })


---------------------
---- Layer rules ----
---------------------

hl.layer_rule({ match = { namespace = "hyprpicker" }, animation = "fade" })                 -- Colour picker out animation
hl.layer_rule({ match = { namespace = "logout_dialog" }, animation = "fade" })              -- wlogout
hl.layer_rule({ match = { namespace = "selection" }, animation = "fade" })                  -- slurp
hl.layer_rule({ match = { namespace = "wayfreeze" }, animation = "fade" })                  -- wayfreeze
hl.layer_rule({ match = { namespace = "launcher" }, animation = "popin 80%", blur = true }) -- Fuzzel

-- Shell
hl.layer_rule({ match = { namespace = "caelestia-(border-exclusion|area-picker)" }, no_anim = true })
hl.layer_rule({ match = { namespace = "caelestia-(drawers|background)" }, animation = "fade" })

-- ############################################################
-- FILE: ~/.config/hypr/hyprland/keybinds.lua
-- ############################################################

local vars = require("variables")
local fn   = require("utils.functions")


-- Flags
local locked           = { locked = true }
local mouse            = { mouse = true }
local release          = { release = true }
local repeating        = { repeating = true }
local locked_repeating = { locked = true, repeating = true }

local function normalise_keybind(key)
    return key:gsub("%s+", ""):lower()
end

local function valid_keybind(key)
    return type(key) == "string" and key:match("%S") ~= nil
end

local function repeating_unless_mouse(key)
    return not normalise_keybind(key):find("mouse", 1, true) and repeating or nil
end

local function flatten_keybinds(keybinds, keys)
    keys = keys or {}

    if type(keybinds) == "table" then
        for _, keybind in pairs(keybinds) do
            flatten_keybinds(keybind, keys)
        end
    elseif valid_keybind(keybinds) then
        keys[#keys + 1] = keybinds
    end

    return keys
end

local function create_bind(keybinds, action, flags)
    local get_flags = type(flags) == "function" and flags or function()
        return flags
    end

    for _, key in ipairs(flatten_keybinds(keybinds)) do
        hl.bind(key, action, get_flags(key))
    end
end

local function extend_keybind(base, suffix)
    return valid_keybind(base) and base .. " + " .. suffix or nil
end

-- Launcher
local launcher_default = normalise_keybind("SUPER + SUPER_L")
create_bind(
    vars.kbLauncher,
    hl.dsp.global("caelestia:launcher"),
    function(key)
        return normalise_keybind(key) == launcher_default and release or nil
    end
)

-- Misc
create_bind(vars.kbSession, hl.dsp.global("caelestia:session"))
create_bind(vars.kbShowSidebar, hl.dsp.global("caelestia:sidebar"))
create_bind(vars.kbClearNotifs, hl.dsp.global("caelestia:clearNotifs"), locked)
create_bind(vars.kbShowPanels, hl.dsp.global("caelestia:showall"))
create_bind(vars.kbLock, hl.dsp.global("caelestia:lock"))

-- Restore lock
create_bind(vars.kbRestoreLock, function()
    hl.dispatch(hl.dsp.exec_cmd("caelestia shell -d"))
    hl.dispatch(hl.dsp.global("caelestia:lock"))
end)

-- Kill/restart
create_bind("CTRL + SUPER + SHIFT + R", hl.dsp.exec_cmd("qs -c caelestia kill"), release)
create_bind(
    "CTRL + SUPER + ALT + R",
    hl.dsp.exec_cmd("qs -c caelestia kill; sleep .1; caelestia shell -d"),
    release
)

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    create_bind(extend_keybind(vars.kbGoToWs, key), fn.wsaction("focus", "", i))
    create_bind(extend_keybind(vars.kbMoveWinToWs, key), fn.wsaction("move", "", i))
    create_bind(extend_keybind(vars.kbGoToWsGroup, key), fn.wsaction("focus", "group", i))
    create_bind(extend_keybind(vars.kbMoveWinToWsGroup, key), fn.wsaction("move", "group", i))
end

-- Go to workspace -1/+1
create_bind(vars.kbPrevWs, hl.dsp.focus({ workspace = "-1" }), repeating_unless_mouse)
create_bind(vars.kbNextWs, hl.dsp.focus({ workspace = "+1" }), repeating_unless_mouse)

-- Go to workspace group -1/+1
create_bind(vars.kbPrevWsGroup, hl.dsp.focus({ workspace = "-10" }), repeating_unless_mouse)
create_bind(vars.kbNextWsGroup, hl.dsp.focus({ workspace = "+10" }), repeating_unless_mouse)

-- Move window to workspace -1/+1
create_bind(vars.kbMoveWinToWsNext, hl.dsp.window.move({ workspace = "+1" }), repeating_unless_mouse)
create_bind(vars.kbMoveWinToWsPrev, hl.dsp.window.move({ workspace = "-1" }), repeating_unless_mouse)

-- Move window to/from special workspace
create_bind(vars.kbMoveWinToWsSpecial, hl.dsp.window.move({ workspace = "special:special" }))
create_bind(vars.kbMoveWinFromWsSpecial, hl.dsp.window.move({ workspace = "e+0" }))

-- Window groups
create_bind(vars.kbWindowCycleNext, hl.dsp.window.cycle_next(), repeating)
create_bind(vars.kbWindowCyclePrev, hl.dsp.window.cycle_next({ next = false }), repeating)
create_bind(vars.kbWindowGroupCycleNext, hl.dsp.group.next(), repeating)
create_bind(vars.kbWindowGroupCyclePrev, hl.dsp.group.prev(), repeating)
create_bind(vars.kbToggleGroup, hl.dsp.group.toggle())
create_bind(vars.kbUngroup, hl.dsp.window.move({ out_of_group = true }))
create_bind(vars.kbGroupLockActive, hl.dsp.group.lock_active())

-- Window actions
for _, dir in ipairs({ "left", "right", "up", "down" }) do
    create_bind("SUPER + " .. dir, hl.dsp.focus({ direction = dir }))
    create_bind("SUPER + SHIFT + " .. dir, hl.dsp.window.move({ direction = dir }))
end

create_bind(vars.kbWindowDecreaseWidth, fn.resize_active_window(-10, 0), repeating)
create_bind(vars.kbWindowIncreaseWidth, fn.resize_active_window(10, 0), repeating)
create_bind(vars.kbWindowDecreaseHeight, fn.resize_active_window(0, -10), repeating)
create_bind(vars.kbWindowIncreaseHeight, fn.resize_active_window(0, 10), repeating)

create_bind({ vars.kbMoveWindow, "SUPER + mouse:272" }, hl.dsp.window.drag(), mouse)
create_bind({ vars.kbResizeWindow, "SUPER + mouse:273" }, hl.dsp.window.resize(), mouse)
create_bind(vars.kbCenterWindow, hl.dsp.window.center())
create_bind(vars.kbNormalizeWindow, function()
    hl.dispatch(hl.dsp.window.resize(fn.resize_by_screen(55, 70)))
    hl.dispatch(hl.dsp.window.center())
end)
create_bind(vars.kbWindowPip, function()
    local a = hl.get_active_window()
    if a then
        local pip = fn.move_actions(a) or {}
        if not a.floating then table.insert(pip, 1, hl.dsp.window.float()) end
        table.insert(pip, hl.dsp.window.pin({ action = "on", window = "address:" .. a.address }))

        for _, x in ipairs(pip) do
            hl.dispatch(x)
        end
    end
end)
create_bind(vars.kbPinWindow, hl.dsp.window.pin())
create_bind(vars.kbWindowFullscreen, hl.dsp.window.fullscreen({ mode = "fullscreen" }))
create_bind(vars.kbWindowBorderedFullscreen, hl.dsp.window.fullscreen({ mode = "maximized" }))
create_bind(vars.kbToggleWindowFloating, hl.dsp.window.float())
create_bind(vars.kbCloseWindow, hl.dsp.window.close())

-- Special workspace toggles
create_bind(vars.kbSpecialWs, fn.toggle("specialws"))
create_bind(vars.kbSystemMonitorWs, fn.toggle("sysmon"))
create_bind(vars.kbMusicWs, fn.toggle("music"))
create_bind(vars.kbCommunicationWs, fn.toggle("communication"))
create_bind(vars.kbTodoWs, fn.toggle("todo"))

-- Apps
create_bind(vars.kbTerminal, hl.dsp.exec_cmd(vars.terminal))
create_bind(vars.kbBrowser, hl.dsp.exec_cmd(vars.browser))
create_bind(vars.kbEditor, hl.dsp.exec_cmd(vars.editor))
create_bind(vars.kbFileExplorer, hl.dsp.exec_cmd(vars.fileExplorer))
create_bind(vars.kbAudioSettings, hl.dsp.exec_cmd(vars.audioSettings))

-- Utilities
create_bind(vars.kbScreenshot, hl.dsp.exec_cmd("caelestia screenshot"), locked)
create_bind(vars.kbScreenshotFreeze, hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/screenshot region"))
create_bind(vars.kbScreenshotFull, hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/screenshot full"))
create_bind(vars.kbScreenshotRegion, hl.dsp.global("caelestia:screenshot"))
create_bind(vars.kbRecord, hl.dsp.exec_cmd("caelestia record"))
create_bind(vars.kbRecordSound, hl.dsp.exec_cmd("caelestia record -s"))
create_bind(vars.kbRecordRegion, hl.dsp.exec_cmd("caelestia record -r"))
create_bind(vars.kbColorPicker, hl.dsp.exec_cmd("hyprpicker -a"))
-- Dictation: press once to start recording, again to transcribe and type at the cursor
create_bind(vars.kbDictate, hl.dsp.exec_cmd("hyprvoice toggle"))
create_bind(vars.kbDictateCancel, hl.dsp.exec_cmd("hyprvoice cancel"))

-- Brightness
create_bind("XF86MonBrightnessUp", hl.dsp.global("caelestia:brightnessUp"), locked)
create_bind("XF86MonBrightnessDown", hl.dsp.global("caelestia:brightnessDown"), locked)

-- Media
create_bind({ vars.kbMediaToggle, "XF86AudioPlay", "XF86AudioPause" }, hl.dsp.global("caelestia:mediaToggle"), locked)
create_bind({ vars.kbMediaNext, "XF86AudioNext" }, hl.dsp.global("caelestia:mediaNext"), locked)
create_bind({ vars.kbMediaPrev, "XF86AudioPrev" }, hl.dsp.global("caelestia:mediaPrev"), locked)
create_bind({ vars.kbMediaStop, "XF86AudioStop" }, hl.dsp.global("caelestia:mediaStop"), locked)

-- Volume
create_bind({ vars.kbVolumeMute, "XF86AudioMute" }, hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), locked)
create_bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), locked)
create_bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd(
        os.getenv("HOME") .. "/.local/bin/volume-step up " .. vars.volumeMax
    ),
    locked_repeating
)
create_bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd(
        os.getenv("HOME") .. "/.local/bin/volume-step down"
    ),
    locked_repeating
)

-- Sleep
create_bind(vars.kbSleep, hl.dsp.exec_cmd(vars.sleepGestureCmd), locked)

-- Clipboard and emoji picker
create_bind(vars.kbClipboard, hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard"))
create_bind(vars.kbClipboardDel, hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard -d"))
create_bind(vars.kbEmoji, hl.dsp.exec_cmd("pkill fuzzel || caelestia emoji -p"))
create_bind(
    vars.kbClipboardPasteLatest,
    hl.dsp.exec_cmd('sleep 0.5s && ydotool type -d 1 "$(cliphist list | head -1 | cliphist decode)"'),
    locked
)

-- Testing
create_bind(
    "SUPER + ALT + F12",
    hl.dsp.exec_cmd(
        "notify-send -u low -i dialog-information-symbolic 'Test notification' " ..
        [["Here's a really long message to test truncation and wrapping\nYou can middle click or flick this notification to dismiss it!"]] ..
        " -a 'Shell' -A 'Test1=I got it!' -A 'Test2=Another action'"
    )
)

-- ############################################################
-- FILE: ~/.config/hypr/utils/functions.lua
-- ############################################################

local function wsaction(action, range, i)
    return function()
        local activews = hl.get_active_workspace()
        if activews then
            local id = activews.id
            local s  = (i - 1) * 10 + (id % 10)
            local t  = math.floor((id - 1) / 10) * 10 + i
            local z  = (range == "group") and s or t

            if action == "move" then
                return hl.dispatch(hl.dsp.window.move({ workspace = z }))
            else
                return hl.dispatch(hl.dsp.focus({ workspace = z }))
            end
        end
    end
end

local function resize_by_screen(x, y)
    local screen = hl.get_active_monitor()
    if screen and type(screen.width) == "number" and type(screen.height) == "number" then
        if not (x == 0 and y == 0) then
            local w = (x and x > 0) and math.floor(screen.width * x / 100) or screen.width
            local h = (y and y > 0) and math.floor(screen.height * y / 100) or screen.height
            return { x = w, y = h, relative = false }
        end
    end
end

local function resize_active_window(x, y)
    return function() -- returning the function so hl reloads everytime correctly
        local win = hl.get_active_window()
        if win and win.size then
            local w = (win.size.x * (x / 100)) or 800
            local h = (win.size.y * (y / 100)) or 600

            hl.dispatch(hl.dsp.window.resize({ x = w, y = h, relative = true }))
        else
            hl.dispatch(hl.dsp.no_op())
        end
    end
end

local function resizer(window, val_fn, x_percent, y_percent, actions)
    if window and val_fn(window) then
        local disp = (type(actions) == "table") and actions or { actions }
        for _, x in ipairs(disp) do
            hl.dispatch(x)
        end

        -- Target the matched window explicitly. Without window=, resize/set_prop
        -- act on the currently focused window instead, mangling whatever tiled
        -- window happened to be focused when this matched.
        local sz = resize_by_screen(x_percent, y_percent)
        if sz then
            sz.window = window
            hl.dispatch(hl.dsp.window.resize(sz))
        end
    end
end

local function move_actions(win)
    local screen = hl.get_active_monitor()

    if screen and screen.width and screen.height and win and win.size then
        local monitor_height = screen.height / screen.scale
        local monitor_width  = screen.width / screen.scale

        local scale_factor   = (monitor_height / 4) / win.size.y

        local target_width   = win.size.x * scale_factor
        local target_height  = win.size.y * scale_factor

        local x_resize       = math.floor(math.max(200, target_width))
        local y_resize       = math.floor(math.max(150, target_height))

        local offset         = math.min(monitor_width, monitor_height) * 0.03

        local move_x         = math.floor(screen.x + monitor_width - x_resize - offset)
        local move_y         = math.floor(screen.y + monitor_height - y_resize - offset)

        return {
            hl.dsp.window.resize({ x = x_resize, y = y_resize, window = win }),
            hl.dsp.window.move({ x = move_x, y = move_y, relative = false, window = win }),
            hl.dsp.window.set_prop({ prop = "keep_aspect_ratio", value = "true", window = win })
        }
    end
end

-- Toggle function
local home       = os.getenv("HOME")
local config_dir = os.getenv("XDG_CONFIG_HOME") or (home .. "/.config")
local json       = require("utils.json") -- rxi's peak library

-- Default config
local function default_config()
    return {
        communication = {
            discord  = { enable = true, match = { { class = "discord" } }, command = { "discord" }, move = true },
            whatsapp = { enable = true, match = { { class = "whatsapp" } }, move = true },
        },
        music = {
            spotify = {
                enable  = true,
                match   = { { class = "Spotify" }, { initial_title = "Spotify" }, { initial_title = "Spotify Free" } },
                command = { "spicetify", "watch", "-s" },
                move    = true,
            },
            feishin = { enable = true, match = { { class = "feishin" } }, move = true },
        },
        sysmon = {
            btop = {
                enable  = true,
                match   = { { class = "btop", title = "btop", workspace = { name = "special:sysmon" } } },
                command = { "foot", "-a", "btop", "-T", "btop", "fish", "-C", "exec btop" },
            },
        },
        todo = {
            todoist = { enable = true, match = { { class = "todoist" } }, command = { "todoist" }, move = true },
        },
    }
end

local function merge(default_conf, user_conf)
    for category, apps in pairs(user_conf) do
        default_conf[category] = default_conf[category] or {}

        for app_name, options in pairs(apps) do
            default_conf[category][app_name] = default_conf[category][app_name] or {}

            for key, value in pairs(options) do
                default_conf[category][app_name][key] = value
            end
        end
    end
end

-- Get a field from an object. Allows mapping camelCase to snake_case fields.
local function get_field(obj, key)
    local value = obj[key]
    if value == nil and type(key) == "string" then
        value = obj[(key:gsub("(%u)", "_%1")):lower()] -- Try convert camelCase to snake_case
    end
    return value
end

local function deep_match(actual, expected)
    if type(expected) == "table" then
        if type(actual) ~= "table" and type(actual) ~= "userdata" then
            return false
        end

        for key, sub_expected in pairs(expected) do
            if not deep_match(get_field(actual, key), sub_expected) then
                return false
            end
        end
        return true
    else
        return actual and string.find(tostring(actual), tostring(expected), 1, true)
    end
end

-- "if the client is running" etc function
local function get_clients(clients, app_config, target_special)
    local matched_clients = {}
    if app_config and app_config.match then
        for _, window in ipairs(clients) do
            for _, rule in ipairs(app_config.match) do
                local is_a_match = true
                for key, expected_value in pairs(rule) do
                    if not deep_match(get_field(window, key), expected_value) then
                        is_a_match = false
                        break
                    end
                end
                if is_a_match then
                    local client_workspace = window.workspace and window.workspace.name
                    table.insert(matched_clients, {
                        window = window,
                        is_in_place = (client_workspace == "special:" .. target_special),
                    })
                    break
                end
            end
        end
        return #matched_clients > 0, matched_clients
    end
    return false, matched_clients
end

local function shell_join(argv) -- uhh praise danny for this
    local quoted = {}
    for i, arg in ipairs(argv) do
        quoted[i] = "'" .. tostring(arg):gsub("'", [['"'"']]) .. "'"
    end
    return table.concat(quoted, " ")
end

-- Merge user config with defaults
local function load_toggle_config()
    local config = default_config()

    local user_file = io.open(config_dir .. "/caelestia/cli.json", "r") -- CLI config
    if not user_file then
        return config
    end

    local content = user_file:read("*a")
    user_file:close()

    local recognized, conf_or_error = pcall(json.decode, content)
    if recognized and type(conf_or_error) == "table" then
        merge(config, conf_or_error.toggles or {})
    else
        -- Invalid cli.json: notify and fall back to defaults.
        -- conf_or_error holds the parse error (string) or a non-table value on success.
        local reason = recognized and "Expected a JSON object" or tostring(conf_or_error):gsub("^.-:%d+: ", "")
        hl.exec_cmd("caelestia shell toaster error " ..
            shell_join({ "Failed to parse CLI config", reason }) .. " error")
    end

    return config
end

-- Ensure every configured app is present on the special workspace: spawn it if
-- it isn't running, otherwise move any stray clients onto the workspace.
local function place_apps(apps, special_workspace)
    local target = "special:" .. special_workspace
    local clients = hl.get_windows() or {}

    for _, app in pairs(apps) do
        if app.enable then
            local is_running, target_clients = get_clients(clients, app, special_workspace)

            if not is_running then
                if app.command then
                    hl.dispatch(hl.dsp.exec_cmd(shell_join(app.command), { workspace = target }))
                end
            elseif app.move then
                for _, target_client in ipairs(target_clients) do
                    if not target_client.is_in_place then
                        hl.dispatch(hl.dsp.window.move({ window = target_client.window, workspace = target, follow = false }))
                    end
                end
            end
        end
    end
end

local function toggle(special_workspace)
    return function()
        local active_workspace = hl.get_active_special_workspace()

        -- Generic special workspace toggle: close if any is open, or open "special"
        if special_workspace == "specialws" then
            local target = active_workspace and active_workspace.name:gsub("^special:", "") or "special"
            return hl.dispatch(hl.dsp.workspace.toggle_special(target))
        end

        local on_correct_ws = active_workspace and active_workspace.name == "special:" .. special_workspace

        -- Focus workspace before apps
        if not on_correct_ws then
            hl.dispatch(hl.dsp.focus({ workspace = "special:" .. special_workspace }))
        end

        local apps = load_toggle_config()[special_workspace]
        if apps then
            place_apps(apps, special_workspace)
        end

        -- Hide workspace if already active
        if on_correct_ws then
            hl.dispatch(hl.dsp.workspace.toggle_special(special_workspace))
        end
    end
end

return {
    resizer              = resizer,
    resize_by_screen     = resize_by_screen,
    resize_active_window = resize_active_window,
    wsaction             = wsaction,
    move_actions         = move_actions,
    toggle               = toggle,
}

-- ############################################################
-- FILE: ~/.config/caelestia/hypr-vars.lua
-- ############################################################

return {
    terminal         = "kitty",       -- SUPER+T (keybind unchanged)
    browser          = "zen-browser", -- SUPER+W (keybind unchanged)
    windowBorderSize = 2,             -- was 1
    kbMoveWinToWs    = "SUPER + SHIFT", -- SUPER+SHIFT+1-0 sends window to that workspace (was SUPER+ALT)
}

-- ############################################################
-- FILE: ~/.config/caelestia/hypr-user.lua
-- ############################################################

-- JARVIS (added 2026-10-15): the pill top-left (hidden until the pointer touches the top-left edge or JARVIS
-- listens/speaks), the daemon, and its keys. Repo: ~/jarvis -> ~/Projects/JARVIS-personal-assistent.
-- Undo: delete this block, `hyprctl reload`.
local home = os.getenv("HOME") or ""

hl.on("hyprland.start", function()
    hl.exec_cmd("qs -c jarvis -n -d")
    -- jarvisd is WantedBy=graphical-session.target, which this session never starts, so start it here.
    hl.exec_cmd("sh -c 'systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE DISPLAY; systemctl --user start jarvisd'")
end)

hl.bind("SUPER + J", hl.dsp.exec_cmd(home .. "/.local/bin/jarvisctl hud toggle"), { description = "JARVIS fullscreen HUD" })
-- Drag a box on the screen, then ask about it ("what's this error?"); Esc in the selection = nothing.
hl.bind("SUPER + SHIFT + X", hl.dsp.exec_cmd(home .. "/.local/bin/jarvisctl ask-region"), { description = "JARVIS: draw a box and ask" })

-----
-- Window keys (added 2026-10-16). Undo: delete this block, `hyprctl reload`.
--   SUPER+SHIFT+arrows       resize the active window by 30px (was: move window)
--   CTRL+SUPER+SHIFT+arrows  swap/move the window left/right/up/down (was: send to prev/next/special workspace)
-- Old resize keys (SUPER +/-, SUPER+SHIFT +/-, SUPER+ALT+arrows) are switched off.
for _, k in ipairs({ "SUPER + Minus", "SUPER + Equal", "SUPER + SHIFT + Minus", "SUPER + SHIFT + Equal",
    "SUPER + ALT + left", "SUPER + ALT + right", "SUPER + ALT + up", "SUPER + ALT + down" }) do
    hl.unbind(k)
end
local step = 30 -- pixels per press (hold to keep going); same as the old Noctalia setup
hl.config({ misc = { animate_manual_resizes = false } }) -- instant, like Noctalia
local resize = { left = { -step, 0 }, right = { step, 0 }, up = { 0, -step }, down = { 0, step } }
for dir, d in pairs(resize) do
    hl.unbind("SUPER + SHIFT + " .. dir)
    hl.unbind("CTRL + SUPER + SHIFT + " .. dir)
    hl.bind("SUPER + SHIFT + " .. dir, hl.dsp.window.resize({ x = d[1], y = d[2], relative = true }), { repeating = true })
    hl.bind("CTRL + SUPER + SHIFT + " .. dir, hl.dsp.window.move({ direction = dir }))
end
-- SUPER+1-0 / SUPER+SHIFT+1-0 always mean desktop 1-10, even after scrolling past 10
-- (Caelestia's default jumps within the current group of 10, e.g. desktop 21 instead of 1).
for i = 1, 10 do
    local key = tostring(i % 10)
    hl.unbind("SUPER + " .. key)
    hl.unbind("SUPER + SHIFT + " .. key)
    hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
-----

-----
-- Boot straight to the desktop, no lock (2026-10-16): SDDM logs in automatically via
-- /etc/sddm.conf.d/autologin.conf. Delete that file to get a login screen back.
-----

-----
-- VSCodium fully opaque (added 2026-10-16); every other window keeps the 0.95 from hyprland/rules.lua.
-- Undo: delete this block, `hyprctl reload`.
hl.window_rule({ match = { class = "codium" }, opacity = "1.0 override" })
-----

-- ############################################################
-- FILE: ~/.config/hypr/hyprland-mod.lua
-- ############################################################

-- Hyprland Mod managed settings. Generated file: manual edits may be overwritten.
-- Loaded from the end of hyprland.lua so these values take precedence.
-- hyprland-mod-state: {"lists": {}, "settings": {}, "version": 1}
