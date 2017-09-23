# =========================
# tmux settings
# =======================
is_screen_running() {
    [ ! -z "$WINDOW" ]
}
is_tmux_runnning() {
    [ ! -z "$TMUX" ]
}
is_screen_or_tmux_running() {
    is_screen_running || is_tmux_runnning
}
shell_has_started_interactively() {
    [ ! -z "$PS1" ]
}
resolve_alias() {
    cmd="$1"
    while \
        whence "$cmd" >/dev/null 2>/dev/null \
            && [ "$(whence "$cmd")" != "$cmd" ]
        do
        cmd=$(whence "$cmd")
    done
    echo "$cmd"
}
autoload -Uz compinit
compinit
