#!/bin/bash
material_bg="#263238"
material_fg="#ECEFF1"
material_blue="#82AAFF"
material_yellow="#FFCB6B"
material_red="#FF5370"
material_white="#ECEFF1"
material_green="#C3E88D"
material_visual_grey="#212121"
material_comment_grey="#5D818E"

get() {
   local option=$1
   local default_value=$2
   local option_value="$(tmux show-option -gqv "$option")"

   if [ -z "$option_value" ]; then
      echo "$default_value"
   else
      echo "$option_value"
   fi
}

set() {
   local option=$1
   local value=$2
   tmux set-option -gq "$option" "$value"
}

setw() {
   local option=$1
   local value=$2
   tmux set-window-option -gq "$option" "$value"
}

set "status" "on"
set "status-justify" "left"

set "status-left-length" "100"
set "status-right-length" "100"
set "status-right-attr" "none"

set "message-fg" "$material_white"
set "message-bg" "$material_black"

set "message-command-fg" "$material_white"
set "message-command-bg" "$material_black"

set "status-attr" "none"
set "status-left-attr" "none"

setw "window-status-fg" "$material_black"
setw "window-status-bg" "$material_black"
setw "window-status-attr" "none"

setw "window-status-activity-bg" "$material_black"
setw "window-status-activity-fg" "$material_black"
setw "window-status-activity-attr" "none"

setw "window-status-separator" ""

set "window-style" "fg=$material_comment_grey"
set "window-active-style" "fg=$material_white"

set "pane-border-fg" "$material_fg"
set "pane-border-bg" "$material_bg"
set "pane-active-border-fg" "$material_green"
set "pane-active-border-bg" "$material_black"

set "display-panes-active-colour" "$material_yellow"
set "display-panes-colour" "$material_blue"

set "status-bg" "$material_bg"
set "status-fg" "$material_fg"

set "@prefix_highlight_fg" "$material_bg"
set "@prefix_highlight_bg" "$material_green"
set "@prefix_highlight_copy_mode_attr" "fg=$material_fg,bg=$material_green"
set "@prefix_highlight_output_prefix" "  "

status_widgets=$(get "@material_widgets")
time_format=$(get "@material_time_format" "%R")
date_format=$(get "@material_date_format" "%d/%m/%Y")

set "status-right" "#[fg=$material_fg,bg=$material_bg,nounderscore,noitalics]${time_format}  ${date_format} #[fg=$material_visual_grey,bg=$material_bg]#[fg=$material_visual_grey,bg=$material_visual_grey]#[fg=$material_fg, bg=$material_visual_grey]${status_widgets} #[fg=$material_green,bg=$material_visual_grey,nobold,nounderscore,noitalics]#[fg=$material_bg,bg=$material_green,bold] #h #[fg=$material_yellow, bg=$material_green]"
set "status-left" "#[fg=$material_bg,bg=$material_green,bold]#[fg=$material_bg,bg=$material_green,bold] #S #{prefix_highlight}#[fg=$material_green,bg=$material_bg,nobold,nounderscore,noitalics]"

set "window-status-format" "#[fg=$material_bg,bg=$material_bg,nobold,nounderscore,noitalics]#[fg=$material_fg,bg=$material_bg] #I  #W #[fg=$material_bg,bg=$material_bg,nobold,nounderscore,noitalics]"
set "window-status-current-format" "#[fg=$material_bg,bg=$material_visual_grey,nobold,nounderscore,noitalics]#[fg=$material_fg,bg=$material_visual_grey,nobold] #I  #W #[fg=$material_visual_grey,bg=$material_bg,nobold,nounderscore,noitalics]"
