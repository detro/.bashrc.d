# My personal `~/.bashrc.d`

Modular Bash configuration based on the Unix `.d` directory pattern (similar to `/etc/profile.d/` or `conf.d/`). Scripts are sourced dynamically in lexicographical order at shell startup.

## Prerequisites

- **Bash 4.0+**
- **jq** (required by `.init.sh`)

## Installation

1. Add initialization snippet to `~/.bashrc` (or `~/.bash_profile` for macOS login shells):
   ```bash
   # Initialize ~/.bashrc.d
   [[ -s "${HOME}/.bashrc.d/.init.sh" ]] && source "${HOME}/.bashrc.d/.init.sh"
   ```

2. Clone repository:
   ```bash
   git clone https://github.com/detro/.bashrc.d.git ~/.bashrc.d
   ```

3. Launch a new shell session.

## Personalization & Non-Git Configuration (`*.private.*`)

To maintain machine-specific configurations, sensitive tokens, or personal preferences without committing them to version control, use the `*.private.*` pattern ignored by `.gitignore`:

- **Private scripts (`*.private.sh`)**: Drop any script ending in `.private.sh` into `~/.bashrc.d/` (e.g., `10-work-paths.private.sh`). `.init.sh` automatically discovers and sources it in alphabetical order alongside public scripts.
- **Private data/config (`*.private.json`)**: Store secrets, structured configs, or metadata consumed by companion scripts without exposure.

## Startup Logging & Agent Awareness

- **Interactive shells**: Each script emits informative, colored log lines (`info`, `warn`, `error`) reporting which tools, paths, completions, and aliases are loaded.
- **Coding agent shells**: When `$AGENT` is set, `.init.sh` detects that the shell was spawned by an AI coding agent, logs a single header line, and silences all startup log messages to keep command output clean and prevent LLM context window pollution.

## Feature Spotlight: OPMC (1Password macOS Cache)

Located in `26-1password_macos_cache.sh`.

### Problem
Exporting environment variables from 1Password via CLI (`export TOKEN=$(op read ...)`) triggers Touch ID or master password prompts on every single new terminal tab or shell instance.

### Solution
OPMC uses the macOS Keychain (via the native `security` CLI) as a secure local cache. The Keychain unlocks automatically on login.

- First run: Retrieves secret from 1Password (`op read`), caches it into macOS Keychain, then exports it.
- Subsequent shells: Reads directly from macOS Keychain instantly, bypassing 1Password prompts.

### Configuration

Create `26-1password_macos_cache.private.json` in the root directory:

```json
{
  "secrets": [
    {
      "envVar": "NPM_TOKEN",
      "opSecRef": "op://Private/npm/credential",
      "opVault": "Private",
      "opAccURL": "my-account.1password.com"
    }
  ]
}
```

### Management Commands

- `opmc_export_all`: Refresh environment variables from cache (runs on startup).
- `opmc_clear <ENV_VAR>`: Invalidate a specific cached secret.
- `opmc_clear_all`: Wipe all configured secrets from Keychain cache to force 1Password reload.

## License

[The Unlicense](http://unlicense.org/) (Public Domain).
