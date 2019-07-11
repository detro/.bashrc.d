if [[ "MACOSX" == ${OSNAME} ]] && [[ -x "$(which brew)" ]]; then
	export PATH="/usr/local/bin:${PATH}"

	# Including "bash-completion@2" if installed
	export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
	[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
fi