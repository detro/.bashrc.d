# Usually, on Mac Intel
if [[ -x "/usr/local/bin/brew" ]]; then
	export BREW_HOME="/usr/local"
fi

# Usually, on Mac ARM
if [[ -x "/opt/homebrew/bin/brew" ]]; then
	export BREW_HOME="/opt/homebrew"
fi

export BREW_BIN="${BREW_HOME}/bin/brew"

# Setup shell for Homebrew
if [[ -x "${BREW_BIN}" ]]; then
	eval $(${BREW_BIN} shellenv)

	# Setup "bash-completion@2" if found
	if [[ -r "$(${BREW_BIN} --prefix)/etc/profile.d/bash_completion.sh" ]]; then
		source "$(${BREW_BIN} --prefix)/etc/profile.d/bash_completion.sh"
	fi
fi


