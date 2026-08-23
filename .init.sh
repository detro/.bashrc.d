THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &>/dev/null && pwd )"

# ----------------------------------------------- Log Coloring
# Colorful logging helper: INFO (green) level
function info() {
	echo -e "\e[32m* ${*}\e[39m"
}

# Colorful logging helper: WARN (orange) level
function warn() {
	echo -e "\e[33m* ${*}\e[39m"
}

# Colorful logging helper: ERROR (red) level
function error() {
	echo -e "\e[31m* ${*}\e[39m"
}

# Colorful logging helper: just a new line
function nln() {
	echo ""
}

}

# Export OSNAME
case "${OSTYPE}" in
  solaris*) OSNAME="SOLARIS" ;;
  darwin*)  OSNAME="MACOSX" ;;
  linux*)   OSNAME="LINUX" ;;
  bsd*)     OSNAME="BSD" ;;
  msys*)    OSNAME="WINDOWS" ;;
  *)        OSNAME="${OSTYPE}" ;;
esac
info "🚀 Exporting OSNAME=$OSNAME for OSTYPE=$OSTYPE"

# ----------------------------------------------- Source all the 'bashrc.d' files
info "🚀 Initializing 'github.com/detro/.bashrc.d' (from ${THIS_DIR})"

# NOTE: Prepending `\` to `ls` to prevent alias expansion and just use plain `ls`
for BASHRC_D_FILE in $(\ls ${THIS_DIR}/*.sh); do
  source "${BASHRC_D_FILE}"
done

info "🟢 'github.com/detro/.bashrc.d' ready!"

