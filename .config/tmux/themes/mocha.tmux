#!/usr/bin/env bash
# doom-one colors for Tmux

set -g mode-style "fg=#1e1e2e,bg=#74c7ec"

set -g message-style "fg=#1e1e2e,bg=#74c7ec"
set -g message-command-style "fg=#1e1e2e,bg=#74c7ec"

set -g pane-border-style "fg=#7f849c"
set -g pane-active-border-style "fg=#7f849c"

set -g status "on"
set -g status-bg "#1e1e2e"
set -g status-justify "left"

set -g status-style "fg=#dadada,bg=#1e1e2e"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#1e1e2e,bg=#74c7ec,nobold] #S #[fg=#74c7ec,bg=#1e1e2e,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=#1e1e2e,bg=#1e1e2e,nobold,nounderscore,noitalics]#[fg=#cba6f7,bg=#1e1e2e] #{prefix_highlight} #[fg=#cba6f7,bg=#1e1e2e,nobold,nounderscore,noitalics]#[fg=#1e1e2e,bg=#cba6f7] %Y-%m-%d  %I:%M %p #[fg=#1e1e2e,bg=#cba6f7,nobold,nounderscore,noitalics]#[fg=#74c7ec,bg=#1e1e2e,bold] #(who | cut -d \" \" -f1)@#h "

setw -g window-status-activity-style "underscore,fg=#cba6f7,bg=#1e1e2e"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#f9e2af,bg=#1e1e2e"
setw -g window-status-format "#[fg=#1e1e2e,bg=#1e1e2e,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#1e1e2e,bg=#1e1e2e,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#1e1e2e,bg=#f9e2af,nobold,nounderscore,noitalics]#[fg=#1e1e2e,bg=#f9e2af] #I  #W #F #[fg=#f9e2af,bg=#1e1e2e,nobold,nounderscore,noitalics]"
