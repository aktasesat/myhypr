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

alias wconf="nvim /home/$USER/.config/waybar/"
alias hconf="nvim /home/$USER/.config/hypr"
alias vconf="nvim /home/$USER/.config/nvim/"
alias fconf="nvim /home/$USER/.config/fish/config.fish"
alias moon="cd /home/$USER/Projects/MobileApp/moonflower/ && npm run dev "

fish_add_path $HOME/.pub-cache/bin
fish_add_path /home/$USER/development/flutter/bin
end

