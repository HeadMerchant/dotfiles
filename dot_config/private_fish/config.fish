if status is-interactive
    zoxide init fish | source
    alias cd=z
    alias make="make -j8"
    # alias man="nvim +Man!"
    # eval (zellij setup --generate-auto-start fish | string collect)
end

bind ctrl-l "printf '\033c'; commandline -f repaint"
set -g fish_greeting
set fish_cursor_default line
set -Ux SUDO_EDITOR hx
set -Ux MANPAGER "nvim +Man!"

function zellij_tab_cwd --on-event fish_postexec
    if set -q ZELLIJ
        set title (prompt_pwd)
        command nohup zellij action rename-tab $title >/dev/null 2>&1
    end
end

function __auto_zellij_update_tabname --on-variable PWD
    zellij_tab_cwd
end

function zellij_command --on-event fish_preexec
    if set -q ZELLIJ
        set title (string split ' ' $argv)[1]
        command nohup zellij action rename-tab $title >/dev/null 2>&1
    end
end
zellij_tab_cwd
