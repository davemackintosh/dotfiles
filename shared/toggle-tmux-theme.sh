#!/usr/bin/env sh
#
# Toggle the current window (all panes) between light and dark themes.
set -e

default_window_style='fg=#d0cfcc,bg=#171421'
alternate_window_style='fg=#171421,bg=#ffffff'
current_window_style=$(tmux show -Av window-style)

case $current_window_style in
    $default_window_style|'default')
        # Change to the alternate window style.
        tmux set window-style $alternate_window_style
        ;;
    *)
        # Change back to the default window style.
        tmux set window-style $default_window_style
        ;;
esac
