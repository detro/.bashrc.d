# Set `EDITOR` for every other tool to use
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

# Set self-functions
function bashrcd_reload() {
  info "🔄 Reloading 'github.com/detro/.bashrc.d' (from ${THIS_DIR}) ..."
  source "${THIS_DIR}/.init.sh"
  info "🔄 Reload complete!"
}

function bashrcd_edit() {
  info "✒️ Opening editor on '~/.bashrc.d' ..."
  ${EDITOR} "${THIS_DIR}"
}