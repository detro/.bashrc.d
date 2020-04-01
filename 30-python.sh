if [[ "MACOSX" == ${OSNAME} ]]; then
	# Python 3.7 on macOS
	[ -d "${HOME}/Library/Python/3.7/bin" ] && PATH="${HOME}/Library/Python/3.7/bin:$PATH"
fi