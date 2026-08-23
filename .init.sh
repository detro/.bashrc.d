THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &>/dev/null && pwd )"

# ------------------------- Log a line if shell spawned by an Agent
[[ -n "$AGENT" ]] && echo "=== 🤖 Shell spawned by an Agent 🤖 ==="

# ----------------------------------------------- Log Coloring
# NOTE: Logging is suppressed if shell spawned by an Agent

# Colorful logging helper: INFO (green) level
function info() {
	[[ -z "$AGENT" ]] && echo -e "\e[32m* ${*}\e[39m" >&2 || true
}

# Colorful logging helper: WARN (orange) level
function warn() {
	[[ -z "$AGENT" ]] && echo -e "\e[33m* ${*}\e[39m" >&2 || true
}

# Colorful logging helper: ERROR (red) level
function error() {
	[[ -z "$AGENT" ]] && echo -e "\e[31m* ${*}\e[39m" >&2 || true
}

# Colorful logging helper: just a new line
function nln() {
	[[ -z "$AGENT" ]] && echo "" >&2 || true
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

