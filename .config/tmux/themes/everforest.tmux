#!/usr/bin/env bash

set -g mode-style "fg=#2b3339,bg=#7fbbb3"

set -g message-style "fg=#2b3339,bg=#7fbbb3"
set -g message-command-style "fg=#2b3339,bg=#7fbbb3"

set -g pane-border-style "fg=#7a8478"
set -g pane-active-border-style "fg=#7a8478"

set -g status "on"
set -g status-bg "#2b3339"
set -g status-justify "left"

set -g status-style "fg=#d3c6aa,bg=#2b3339"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#2b3339,bg=#7fbbb3,nobold] #S #[fg=#7fbbb3,bg=#2b3339,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=#2b3339,bg=#2b3339,nobold,nounderscore,noitalics]#[fg=#d699b6,bg=#2b3339] #{prefix_highlight} #[fg=#d699b6,bg=#2b3339,nobold,nounderscore,noitalics]#[fg=#2b3339,bg=#d699b6] %Y-%m-%d  %I:%M %p #[fg=#2b3339,bg=#d699b6,nobold,nounderscore,noitalics]#[fg=#7fbbb3,bg=#2b3339,bold] #(who | cut -d \" \" -f1)@#h "

setw -g window-status-activity-style "underscore,fg=#d699b6,bg=#2b3339"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#dbbc7f,bg=#2b3339"
setw -g window-status-format "#[fg=#2b3339,bg=#2b3339,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#2b3339,bg=#2b3339,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#2b3339,bg=#dbbc7f,nobold,nounderscore,noitalics]#[fg=#2b3339,bg=#dbbc7f] #I  #W #F #[fg=#dbbc7f,bg=#2b3339,nobold,nounderscore,noitalics]"
