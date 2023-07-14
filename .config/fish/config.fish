if status is-interactive
    # Commands to run in interactive sessions can go here
end

# envs
set -x EDITOR "nano"
set -Ux QT_QPA_PLATFORM "wayland;xcb"
set -Ux QT_QPA_PLATFORMTHEME "qt6ct"
set -Ux QT_WAYLAND_DISABLE_WINDOWDECORATION "1"
set -Ux SDL_VIDEODRIVER "wayland"
set -Ux GDK_BACKEND "wayland,x11"

## aliases

function ll
    command exa -al
end

# how to pass args to origin program ?
function grep
    command rg --color=auto
end

# functions

function xhyprland
    set -Ux XDG_SESSION_TYPE wayland
    set -Ux XDG_SESSION_DESKTOP Hyprland
    set -Ux XDG_CURRENT_DESKTOP Hyprland

    command Hyprland
end

# pnpm
set -gx PNPM_HOME "/home/neko/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
