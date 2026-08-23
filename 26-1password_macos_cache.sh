# OPMC - 1Password MacOS Cache.
#
# It is a way to leverage the MacOS built-in `security` command as a cache for secrets we want
# to have populate environment variables, but are stored into 1Password vaults.
# 1Password is secure, but exporting environment variables by directly doing:
#
#   export MY_VAR=$(op read ...)
#
# causes 1Password to constantly prompt for those `op read` every time a shell is opened.
#
# This is where MacOS `security` comes it: it is essentially a CLI to access the MacOS Keyring baked into
# MacOS. And it is "opened" every time we login.
# OPMC uses it as a _cache_: it looks at the configuration file (see below), and if those secrets are already
# stored in `security`, it uses the value from there to populate the environment variable.
# Otherwise, it loads it from 1Password.
#
# This ensures we don't constantly reach for 1Password at every new shell. And refreshing those values
# just requites to execute `opmc_clear_all` and load a new shell.
#
# Format expected when configuring OPMC: `${this_filename}.private.json`:
#
# ```
# {
#   "secrets": [
#     {
#       "envVar": "ENV_VAR_NAME",
#       "opSecRef": "1PASSWORD_SECRET_REFERENCE",
#       "opVault": "1PASSWORD_VAULT",
#       "opAccURL": "1PASSWORD_ACCOUNT_URL"
#     },
#     // ...
#   ]
# }
# ```

# ----------------------------------------------- Prerequisites Check
if ! which op &>/dev/null || ! which security &>/dev/null; then
  return 0 2>/dev/null || exit 0
fi

# ----------------------------------------------- Configuration handling
__opmc_config() {
  local -r this_filename="$(basename "${BASH_SOURCE[0]}" .sh)"
  local -r configFile="${THIS_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)}/${this_filename}.private.json"

  if [[ -f "${configFile}" ]]; then
    cat "${configFile}"
  else
    error "1Password MacOS Cache configuration file not found at: ${configFile}"
  fi
}

# ----------------------------------------------- MacOS `security` basic CRUD
__opmc_store() {
  local -r envVar=$1
  local -r secret=$2
  local -r macosAccount=$(whoami)

  security add-generic-password -a "${macosAccount}" -s "${envVar}" -w "${secret}" -U
}

__opmc_retrieve() {
  local -r envVar=$1
  local -r macosAccount=$(whoami)

  security find-generic-password -a "${macosAccount}" -s "${envVar}" -g -w
}

__opmc_exists() {
  local -r envVar=$1

  __opmc_retrieve "${envVar}" &>/dev/null
}

opmc_clear() {
  local -r envVar=$1
  local -r macosAccount=$(whoami)

  info "Clearing Secret from OPMC: ${envVar}"
  security delete-generic-password -a "${macosAccount}" -s "${envVar}" &> /dev/null
}

opmc_clear_all() {
  local envVar
  for envVar in $(__opmc_config 2>/dev/null | jq -r '.secrets[]?.envVar // empty'); do
    if __opmc_exists "${envVar}"; then
      opmc_clear "${envVar}"
    else
      warn "Secret present in config but not found in OPMC: ${envVar}"
    fi
  done
}

# ----------------------------------------------- 1Password `op` operations
__opmc_op_retrieve() {
  local -r opAccURL=$1
  local -r opSecRef=$2

  op read --account "${opAccURL}" "${opSecRef}"
}

__opmc_export_entry() {
  local -r scrt=$1
  local -r envVar="$(echo "${scrt}" | jq -r '.envVar // empty')"
  [[ -z "${envVar}" ]] && return

  local -r opSecRef="$(echo "${scrt}" | jq -r '.opSecRef // empty')"
  local -r opVault="$(echo "${scrt}" | jq -r '.opVault // empty')"
  local -r opAccURL="$(echo "${scrt}" | jq -r '.opAccURL // empty')"

  if ! __opmc_exists "${envVar}"; then
    info "🏦 Secret not found in OPMC. Retrieving from 1Password: ${opAccURL} / ${opVault} => ${envVar}"
    __opmc_store "${envVar}" "$(__opmc_op_retrieve "${opAccURL}" "${opSecRef}")"
  fi

  info "🔐 Exporting ${envVar} via OPMC"
  export "${envVar}=$(__opmc_retrieve "${envVar}")"
}

opmc_export_all() {
  local scrt
  while IFS= read -r scrt; do
    [[ -z "${scrt}" ]] && continue
    __opmc_export_entry "${scrt}"
  done < <(__opmc_config 2>/dev/null | jq -c '.secrets[]? // empty')
}

opmc_export_all
