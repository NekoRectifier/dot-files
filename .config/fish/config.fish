if status is-interactive
    # Commands to run in interactive sessions can go here
end

# envs
set -Ux QT_QPA_PLATFORM "wayland;xcb"
set -Ux QT_QPA_PLATFORMTHEME "qt6ct"
set -Ux QT_WAYLAND_DISABLE_WINDOWDECORATION "1"
set -Ux SDL_VIDEODRIVER "wayland"
set -Ux GDK_BACKEND "wayland,x11"

# env for NVIDIA
set -x LIBVA_DRIVER_NAME "nvidia"
set -x XDG_SESSION_TYPE "wayland"
set -x GBM_BACKEND "nvidia-drm"
set -x __GLX_VENDOR_LIBRARY_NAME "nvidia"
set -x WLR_NO_HARDWARE_CURSORS "1"

# cuda
set -Ux LD_LIBRARY_PATH /opt/TensorRT-7.1.3.4/lib/:/opt/TensorRT-7.1.3.4/:/opt/cuda/lib64

set -Ux PATH $PATH:/home/neko/.local/bin:/opt/cuda/bin:/opt/miniconda/bin
set -Ux LIBRARY_PATH /opt/cuda/lib64

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
