if status is-interactive
set -g fish_greeting
    set -g fish_color_user D65D0E
    set -g fish_color_cwd D65D0E
    set -g fish_color_cwd_root D65D0E
    set -g fish_color_host FFFFFF
    set -g fish_color_host_remote FFFFFF
    set -g fish_color_command FFFFFF
    set -g fish_color_error FB4934
    set -g fish_color_param d7d7d7
    set -g fish_color_comment 928374
    set -g fish_color_selection --background=3c3836
    set -g fish_color_autosuggestion 7c6f64
alias hconf="nvim /home/$USER/.config/hypr"
alias vconf="nvim /home/$USER/.config/nvim/"
set -gx PATH /opt/flutter/bin $PATH


end
