function set_wezterm_var
    if test -z "$argv[1]"
        return
    end

    set val $argv[2]
    if test -n "$val"
        set val $(echo -n $val | base64)
    end

    if test -z "$TMUX"
        printf "\033]1337;SetUserVar=%s=%s\007" "$argv[1]" $val
    else
        echo $arg_name $based_arg
        # <https://github.com/tmux/tmux/wiki/FAQ#what-is-the-passthrough-escape-sequence-and-how-do-i-use-it>
        # Note that you ALSO need to add "set -g allow-passthrough on" to your tmux.conf
        printf "\033Ptmux;\033\033]1337;SetUserVar=%s=%s\007\033\\" "$argv[1]" $val
    end
end
