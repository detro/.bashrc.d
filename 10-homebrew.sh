# Usually, on Mac Intel
if [[ -x "/usr/local/bin/brew" ]]; then
	info "🍺 Detected Homebrew (Mac Intel)"
	export BREW_HOME="/usr/local"
fi

# Usually, on Mac AppleSilicon (ARM)
if [[ -x "/opt/homebrew/bin/brew" ]]; then
	info "🍺 Detected Homebrew (Mac AppleSilicon)"
	export BREW_HOME="/opt/homebrew"
fi

export BREW_BIN="${BREW_HOME}/bin/brew"

# Setup shell for Homebrew
if [[ -x "${BREW_BIN}" ]]; then
	info "🍺 Exporting BREW_BIN"
	eval $(${BREW_BIN} shellenv)

	# Setup "bash-completion@2" if found
	if [[ -r "$(${BREW_BIN} --prefix)/etc/profile.d/bash_completion.sh" ]]; then
		source "$(${BREW_BIN} --prefix)/etc/profile.d/bash_completion.sh"
	fi
fi


