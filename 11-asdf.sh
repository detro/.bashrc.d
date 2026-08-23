if which asdf &>/dev/null; then
	# Add shims to PATH
	if [[ -d "${HOME}/.asdf/shims" ]]; then
		info "⌨️ Setup PATH: ASDF"
		export PATH="${HOME}/.asdf/shims:$PATH"
	fi

	info "⌨️ ASDF setup Bash Completion"
	source <(asdf completion bash)

	# Handle Java Plugin
	if [[ -e "${HOME}/.asdf/plugins/java/set-java-home.bash" ]]; then
		info "⌨️ Setup Java Plugin: ASDF"
		source ${HOME}/.asdf/plugins/java/set-java-home.bash
	fi
fi
