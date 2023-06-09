if status is-interactive
    # Commands to run in interactive sessions can go here
end

# envs
#set -x QT_QPA_PLATFORM "wayland;xcb"
set -x QT_QPA_PLATFORM "wayland"
set -x QT_QPA_PLATFORMTHEME "qt6ct"
set -x QT_WAYLAND_DISABLE_WINDOWDECORATION "1"
set -x SDL_VIDEODRIVER "wayland"
set -x GDK_BACKEND "wayland,x11"

set -x PATH $PATH:/home/neko/.local/bin

# aliases

function ll
    command exa -al
end

function ls
    command exa -g
end

function grep
    command grep --color=auto
end

# functions

function xhyprland
    set -x XDG_SESSION_TYPE wayland
    set -x XDG_SESSION_DESKTOP Hyprland
    set -x XDG_CURRENT_DESKTOP Hyprland

    command Hyprland
end
