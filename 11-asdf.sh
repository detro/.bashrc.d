if which asdf &>/dev/null; then
	# Add shims to PATH
	if [[ -d "${HOME}/.asdf/shims" ]]; then
		info "⌨️ ASDF setup PATH"
		export PATH="${HOME}/.asdf/shims:$PATH"
	fi

	info "⌨️ ASDF setup Bash Completion"
	. <(asdf completion bash)

	# Handle Java Plugin
	if [[ -e "${HOME}/.asdf/plugins/java/set-java-home.bash" ]]; then
		info "⌨️ ASDF configure Java Plugin"
		. ${HOME}/.asdf/plugins/java/set-java-home.bash
	fi
fi
