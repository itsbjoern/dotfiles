function set_term_var {
    if [[ -z "$argv[1]" ]]; then
        return
    fi

    val="$argv[2]"
    if [[ -n "$val" ]]; then
        val=$(echo -n "$val" | base64)
    fi

    if [[ -z "$TMUX" ]]; then
        printf "\033]1337;SetUserVar=%s=%s\007" "$argv[1]" "$val"
    else
        # <https://github.com/tmux/tmux/wiki/FAQ#what-is-the-passthrough-escape-sequence-and-how-do-i-use-it>
        # Note that you ALSO need to add "set -g allow-passthrough on" to your tmux.conf
        printf "\033Ptmux;\033\033]1337;SetUserVar=%s=%s\007\033\\" "$argv[1]" "$val"
    fi
}
