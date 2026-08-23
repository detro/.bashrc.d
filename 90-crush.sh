# Setup bash completion for Crush
# See: https://github.com/charmbracelet/crush
if which crush &>/dev/null; then
	info "💖 Setup Bash Completion: Crush"
	# shellcheck disable=SC1090
	source <(crush completion bash)

	# Utility to edit config
	function crush_edit() {
		${EDITOR} ~/.config/crush/crush.json
	}
fi
