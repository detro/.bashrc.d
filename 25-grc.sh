# GRC (see https://github.com/garabik/grc)
if [[ -x "$(which brew)" ]] && [[ -f "$(brew --prefix)/etc/grc.sh" ]]; then
	GRC_ALIASES="true"
	source "$(brew --prefix)/etc/grc.sh"
else
	GRC_ALIASES="true"
	[[ -s "/etc/grc.sh" ]] && source /etc/grc.sh
fi

# Additional GRC aliases
if [[ ${GRC_ALIASES} == "true" ]]; then
	alias env='colourify env'
fi
