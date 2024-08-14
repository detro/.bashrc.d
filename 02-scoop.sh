# This is for Windows only, where you should install scoop!
# See: https://scoop.sh/

if [[ "WINDOWS" == ${OSNAME} ]] && which powershell &>/dev/null; then
	function scoop() { powershell -ex unrestricted scoop.ps1 "$@" ;} && export -f scoop
fi
