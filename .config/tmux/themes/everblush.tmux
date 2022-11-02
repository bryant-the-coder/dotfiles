#!/usr/bin/env bash
# doom-one colors for Tmux

set -g mode-style "fg=#141b1e,bg=#67b0e8"

set -g message-style "fg=#141b1e,bg=#67b0e8"
set -g message-command-style "fg=#141b1e,bg=#67b0e8"

set -g pane-border-style "fg=#b3b9b8"
set -g pane-active-border-style "fg=#b3b9b8"

set -g status "on"
set -g status-bg "#141b1e"
set -g status-justify "left"

set -g status-style "fg=#dadada,bg=#141b1e"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#141b1e,bg=#67b0e8,nobold] #S #[fg=#67b0e8,bg=#141b1e,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=#141b1e,bg=#141b1e,nobold,nounderscore,noitalics]#[fg=#c47fd5,bg=#141b1e] #{prefix_highlight} #[fg=#c47fd5,bg=#141b1e,nobold,nounderscore,noitalics]#[fg=#141b1e,bg=#c47fd5] %Y-%m-%d  %I:%M %p #[fg=#141b1e,bg=#c47fd5,nobold,nounderscore,noitalics]#[fg=#67b0e8,bg=#141b1e,bold] #(who | cut -d \" \" -f1)@#h "

setw -g window-status-activity-style "underscore,fg=#c47fd5,bg=#141b1e"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#e5c76b,bg=#141b1e"
setw -g window-status-format "#[fg=#141b1e,bg=#141b1e,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#141b1e,bg=#141b1e,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#141b1e,bg=#e5c76b,nobold,nounderscore,noitalics]#[fg=#141b1e,bg=#e5c76b] #I  #W #F #[fg=#e5c76b,bg=#141b1e,nobold,nounderscore,noitalics]"
