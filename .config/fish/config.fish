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

set cuda_path "/home/neko/Documents/seg/env"

set -Ux LD_LIBRARY_PATH $LD_LIBRARY_PATH:$cuda_path/TensorRT-7.1.3.4/lib64:$cuda_path/TensorRT-7.1.3.4/lib
set -Ux PATH $PATH:/home/neko/.local/bin:$cuda_path/cuda-toolkit/bin:/opt/miniconda/bin
set -Ux LIBRARY_PATH $LIBRARY_PATH:$cuda_path/cuda-toolkit/lib64

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
    set -Ux XDG_SESSION_TYPE wayland
    set -Ux XDG_SESSION_DESKTOP Hyprland
    set -Ux XDG_CURRENT_DESKTOP Hyprland

    command Hyprland
end
