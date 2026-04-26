# Setup bash completion for Crush
# See: https://github.com/charmbracelet/crush
if which crush &>/dev/null; then
	info "💖 Setting up 'crush' Bash completion"
	source <(crush completion bash)

	# Utility to edit config
	function crush_edit() {
		${EDITOR} ~/.config/crush/crush.json
	}
fi