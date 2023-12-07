# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import subprocess
from libqtile import bar, layout, widget, hook, extension, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod1"
terminal = guess_terminal()

widget_defaults = dict(
    font="RobotoMono Nerd Font",
    fontsize=20,
    padding=3,
    foreground="#E8EAF6"
)
extension_defaults = widget_defaults.copy()

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "Tab", lazy.group.focus_back(), desc="Alternate between two most recent windows"),

    # Move windows betweencleft/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "m", lazy.window.toggle_maximize(), desc="Toggle maximize"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn('kitty'), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "space", lazy.screen.next_group(), desc="Toggle between layouts"),
    Key([mod, "control"], "space", lazy.screen.prev_group(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawn("rofi -show drun"), desc="Rofi launch menu"),

    # Volume and Backlight keys
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer set Master 5%- unmute")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer set Master 5%+ unmute")),
    Key([], "XF86AudioMute", lazy.spawn("amixer set Master togglemute")),
    Key([], "XF86AudioMicMute", lazy.spawn("amixer set Capture togglemute")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -5")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight +5")),

    # Screen lock
    Key(["mod4"], "z", lazy.spawn("xsecurelock")),

    # Screenshot
    Key(["mod4"], "s", lazy.spawn("gnome-screenshot -i")),

    # Application shortcuts
    Key([mod], "f", lazy.spawn("firefox")),
    Key([mod, "shift"], "f", lazy.spawn("firefox --private-window")),
    Key([mod], "s", lazy.spawn("spotify --force-device-scale-factor=1.25")),

    # Floating windows
    Key([mod], "o", lazy.layout.normalize()),
]

groups = [Group(i) for i in "1234"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Max(),
    layout.Columns(border_focus_stack=["#ff0f0f", "#8f3d3d"], border_width=4),
]

background_color = "#292C3c"
foreground_color = widget_defaults["foreground"]
backlight_name = subprocess.getoutput("ls /sys/class/backlight")
screens = [
    Screen(
        wallpaper="/home/ayorgo/wallpapers/archtv.png",
        wallpaper_mode="stretch",
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(
                    background=background_color,
                ),
                widget.Spacer(length=5),
                widget.GroupBox(
                    rounded=False,
                    disable_drag=True,
                    borderwidth=2,
                    this_screen_border=foreground_color,
                    this_current_screen_border=foreground_color,
                    padding=3,
                    background=background_color,
                    font=widget_defaults["font"],
                    fontsize=22,
                ),
                widget.Spacer(length=5),
                widget.Systray(
                    icon_size=32,
                    padding=10,
                ),
                widget.Spacer(length=5),
                widget.TaskList(
                    title_width_method="uniform",
                    rounded=False,
                    borderwidth=2,
                    txt_minimized="* ",
                    border=foreground_color,
                    background=background_color,
                    padding=3,
                    margin=1,
                    font=widget_defaults["font"],
                    fontsize=22,
                    icon_size=28,
                    theme_mode="fallback",
                    theme_path="/usr/share/icons/Papirus-Dark",
                ),
                widget.Spacer(length=5),
                widget.Mpris2(
                    fmt="<span size='large'>{}</span>",
                    stop_pause_text="  ",
                    playing_text="  ",
                    objname="org.mpris.MediaPlayer2.spotify",
                    foreground=foreground_color,
                    background=background_color,
                    padding=10,
                ),
                widget.Spacer(length=5),
                widget.Backlight(
                    backlight_name=backlight_name,
                    brightness_file="actual_brightness",
                    fmt="<span size='large'>󰛩 {:>4}</span>",
                    step=5,
                    foreground=foreground_color,
                    background=background_color,
                    padding=10,
                    font=widget_defaults["font"],
                    fontsize=19,
                ),
                widget.Spacer(length=5),
                widget.Volume(
                    fmt="<span size='large'> {:>4}</span>",
                    foreground=foreground_color,
                    background=background_color,
                    padding=10,
                    font=widget_defaults["font"],
                    fontsize=19,
                ),
                widget.Spacer(length=5),
                widget.CPU(
                    format="<span size='large'>{load_percent: >4.0f}%</span>",
                    foreground=foreground_color,
                    background=background_color,
                    padding=10,
                    font=widget_defaults["font"],
                    fontsize=19,
                ),
                widget.Spacer(length=5),
                widget.Memory(
                    measure_mem="G",
                    format="<span size='large'>{MemUsed: >3.0f}{mm}</span>",
                    foreground=foreground_color,
                    background=background_color,
                    padding=10,
                    font=widget_defaults["font"],
                    fontsize=19,
                ),
                widget.Spacer(length=5),
                widget.Battery(
                    show_short_text=False,
                    full_char = "󰂅",
                    charge_char="󰢝",
                    discharge_char="󰁾",
                    update_interval=5,
                    format="<span size='large'>{char}{percent: >5.0%}</span>",
                    foreground=foreground_color,
                    background=background_color,
                    padding=10,
                    font=widget_defaults["font"],
                    fontsize=19,
                ),
                widget.Spacer(length=5),
                widget.Clock(
                    format="<span size='large'>󰃰 %a %-d %b %-H:%M</span>",
                    foreground=foreground_color,
                    background=background_color,
                    padding=10,
                    font=widget_defaults["font"],
                    fontsize=19,
                ),
                widget.Spacer(length=5),
                widget.KeyboardLayout(
                    configured_keyboards=["us", "us dvorak", "ru"],
                    display_map={
                        "us": "<span size='large'> US</span>",
                        "us dvorak": "<span size='large'> DV</span>",
                        "ru": "<span size='large'> RU</span>"},
                    background=background_color,
                    padding=10,
                    font=widget_defaults["font"],
                    fontsize=19,
                ),
            ],
            38,
            background="#00000000", # added 2 zeros at the end for full transparency
            margin=[0, 0, 5, 0],
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_width=0,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class='confirm'),
        Match(wm_class='dialog'),
        Match(wm_class='download'),
        Match(wm_class='error'),
        Match(wm_class='file_progress'),
        Match(wm_class='notification'),
        Match(wm_class='splash'),
        Match(wm_class='toolbar'),
        Match(wm_class='makebranch'),
        Match(wm_class='maketag'),
        Match(wm_class='zoom '),
        # Match(title='fzf-launcher'),
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "Qtile"
