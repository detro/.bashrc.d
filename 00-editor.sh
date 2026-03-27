# Editor for `kubectl edit`
if which subl &>/dev/null; then
    info "✒️ Exported EDITOR (Sublime Text)"
    export EDITOR="subl -w"
elif which nvim &>/dev/null; then
    info "✒️ Exported EDITOR (Neo Vim)"
    export EDITOR="nvim"
elif which vim &>/dev/null; then
    info "✒️ Exported EDITOR (Vim)"
    export EDITOR="vim"
fi