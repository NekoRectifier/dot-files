if status is-interactive
    # Commands to run in interactive sessions can go here
end

#set -x "LIBVA_DRIVER_NAME" iHD
set -x "__NV_PRIME_RENDER_OFFLOAD" 1
set -x "__GLX_VENDOR_LIBRARY_NAME" nvidia
set -x "__VK_LAYER_NV_optimus" NVIDIA_only
set -x "__NV_PRIME_RENDER_OFFLOAD_PROVIDER" NVIDIA-G0

set -x "GTK_IM_MODULE" fcitx
set -x "QT_IM_MODULE" fcitx
set -x "XMODIFERS" @im=fcitx

abbr -a update sudo dnf update
abbr -a distro_s sudo dnf distro-sync


# start tmux (in the situation of alacritty)
tmux
