# AGENTS.md

## Repository Overview

Personal modular Bash configuration (`~/.bashrc.d`) sourced on shell startup via `~/.bashrc` or `~/.bash_profile`. Scripts are executed in alphabetical order by `.init.sh`.

## Architecture & Control Flow

1. **Entry Point (`.init.sh`)**:
   - **Prerequisites check**: Verifies Bash version is >= 4.0 and `jq` is installed. Returns/exits with status 1 if unmet.
   - **Agent detection**: When `$AGENT` is set, prints header `=== 🤖 Shell spawned by an Agent 🤖 ===` and suppresses startup log messages (`info`, `warn`, `error`, `nln`).
   - **Platform detection**: Normalizes `$OSTYPE` into global `$OSNAME` (`MACOSX`, `LINUX`, `WINDOWS`, `BSD`, `SOLARIS`).
   - **Sourcing sequence**: Iterates `${THIS_DIR}/*.sh` in lexicographical order.
2. **Private Extensions & Files**:
   - `*.private.sh`: Local-only scripts matching `*.sh` wildcard, ignored by Git (`.gitignore`), sourced automatically.
   - `*.private.json`: Secret configuration files (e.g. OPMC config), ignored by Git.

## Script Layering & Numbering Matrix

| Prefix | Category | Active Scripts | Purpose |
|---|---|---|---|
| `00-` | Core / Reset | `00-reset.sh` | Interactive shell check (`$-` contains `i`), history settings (`HISTSIZE=100000`, `ignoreboth`), shell options (`globstar`, `histappend`, `checkwinsize`), system bash completion. |
| `02-` | Package Managers | `02-scoop.sh` | Windows PowerShell wrapper for Scoop package manager. |
| `10-`–`11-` | Environment & Paths | `10-aliases.sh`, `10-homebrew.sh`, `10-path.sh`, `11-asdf.sh` | Core aliases (`ls`, `grep`, `ssu`), Homebrew setup & `bash-completion@2`, user bin paths (`~/bin`, `~/.local/bin`), ASDF shims, completions, Java plugin. |
| `21-` | Prompt | `21-starship_ps1.sh` | Initializes Starship prompt if installed via Homebrew. |
| `25-` | CLI Enhancements | `25-1password.sh`, `30-eza.sh` | 1Password CLI completions & plugin integrations, `eza` alias over `ls`. |
| `30-`–`35-` | Language & Platform Runtimes | `30-chruby-macos.sh`, `30-kubernetes.sh`, `30-rust.sh`, `35-misc.sh` | Chruby & auto Ruby version switcher, `kubectl` completions/alias (`k`), `KUBE_EDITOR`, secret decoding (`k_secret_json`, `k_secret_yaml`), Kubebuilder PATH, Rust Cargo env, GCC color output. |
| `50-` | Cloud & Database SDKs | `50-gcloud.sh`, `50-postgresql.sh` | Google Cloud SDK PATH & completion, PostgreSQL version discovery (`{13..18}`). |
| `90-` | App Configurations | `90-crush.sh` | Crush CLI completion & `crush_edit` helper. |
| `99-` | Caching & Finalization | `26-1password_macos_cache.sh`, `99-zzz.sh` | OPMC (1Password secret caching in macOS Keychain via `security`), `EDITOR` hierarchy (`subl -w` > `nvim` > `vim`), `bashrcd_reload`, `bashrcd_edit`. |

## Development & Conventions

### Adding New Scripts

- Use two-digit prefix matching the target layer (`NN-name.sh`).
- Guard tool integrations with defensive binary checks:
  ```bash
  if which tool_name &>/dev/null; then
      info "🔧 Configuring tool_name"
      # completions, aliases, environment exports
  fi
  ```
- Use logging helpers (`info`, `warn`, `error`) for diagnostic output. Keep format consistent: `info "<emoji> <message>"`.
- Use `$OSNAME` for OS branching (`MACOSX`, `LINUX`, `WINDOWS`, `BSD`, `SOLARIS`).

### Validation Commands

- Validate bash syntax across all scripts:
  ```bash
  bash -n .init.sh *.sh
  ```
- Test load scripts in current shell:
  ```bash
  source .init.sh
  ```
  or run the reload helper:
  ```bash
  bashrcd_reload
  ```

## Non-Obvious Gotchas

- **Sourcing Context**: Scripts run in the calling shell process. Never use `exit`; use `return` for early exits.
- **Interactive Check**: `00-reset.sh` exits early with `return` when running in non-interactive sessions (`$-` lacks `i`).
- **Prerequisites**: `.init.sh` fails immediately if Bash is `< 4.0` or `jq` is not found in `PATH`.
- **Homebrew Dependency**: Scripts calling `$(brew --prefix)` (e.g. `21-starship_ps1.sh`, `30-eza.sh`, `30-chruby-macos.sh`, `50-postgresql.sh`) require `10-homebrew.sh` to run first.
- **OPMC Secret Cache (`26-1password_macos_cache.sh`)**:
  - Caches 1Password secrets in macOS Keychain (`security add-generic-password`) to prevent repeated master password / Touch ID prompts on every new shell launch.
  - Requires configuration file named `26-1password_macos_cache.private.json`.
  - Cache management commands: `opmc_clear <ENV_VAR>`, `opmc_clear_all`, `opmc_export_all`.
- **Agent Logging Suppression**: When `$AGENT` is set, all `info`/`warn`/`error`/`nln` output is silenced to avoid polluting agent command stdout.
