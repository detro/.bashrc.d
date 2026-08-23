# AGENTS.md

## Scope

This repository is a personal, modular Bash startup configuration. It has no build, deploy, package, or automated test system. Changes affect the caller's shell because every module is sourced rather than executed.

## Validation

Run from repository root:

```bash
bash -n .init.sh *.sh
```

This is the only repository-wide, side-effect-free validation found. For runtime validation, launch a disposable interactive Bash rather than sourcing into an important working shell:

```bash
bash --noprofile --norc -i -c 'source .init.sh'
```

Directly running `source .init.sh` mutates current shell: aliases, functions, `PATH`, editor variables, completions, and possibly secret-backed environment variables. It can also invoke installed tools and macOS Keychain/1Password integration.

## Startup Architecture

1. A user's `~/.bashrc` or `~/.bash_profile` sources `.init.sh`.
2. `.init.sh` requires Bash 4+ and `jq`, defines logging helpers, computes `THIS_DIR`, and maps `OSTYPE` to `OSNAME` (`MACOSX`, `LINUX`, `WINDOWS`, `BSD`, or `SOLARIS`).
3. `.init.sh` sources every root-level `*.sh` in shell glob order. Numeric filename prefixes are therefore dependency ordering, not decoration.
4. `00-reset.sh` returns early in non-interactive shells. Because it is itself sourced by `.init.sh`, this skips only that module; later modules still load.
5. `99-zzz.sh` performs final editor selection and defines repository reload/edit helpers.

There is no component boundary beyond sourced modules. Variables, aliases, functions, shell options, and completion definitions share one global shell namespace.

## Ordering and Module Roles

| Range | Role | Important dependencies/effects |
|---|---|---|
| `00-` | Interactive shell baseline | History, shell options, system completion. |
| `02-` | Package manager integration | Scoop wrapper on Windows. |
| `10-` to `11-` | Core aliases, paths, Homebrew, asdf | Homebrew establishes `BREW_HOME`/`BREW_BIN`; later macOS modules rely on `brew`. |
| `21-` to `30-` | Prompt and CLI integrations | Starship, 1Password, OPMC, eza, chruby, Kubernetes, Rust. |
| `35-` to `50-` | Miscellaneous, cloud, database tooling | GCC colors, gcloud, PostgreSQL paths. |
| `90-` | Application-specific completion/helpers | Crush and GitHub CLI. |
| `99-` | Finalization | Selects `EDITOR`; defines `bashrcd_reload` and `bashrcd_edit`. |

When adding a module, choose prefix based on what must already exist. Renaming changes behavior if it changes lexical order.

## Conventions Observed

- Root scripts use `NN-name.sh`; no nested source tree exists.
- Tool integrations usually use `if which tool &>/dev/null; then ... fi` before completions, aliases, or exports.
- Platform branches use `OSNAME`, not repeated `OSTYPE` checks.
- Startup diagnostics use `info`, `warn`, or `error`, generally with an emoji identifying integration.
- Functions intended as implementation details use `__` prefixes, as in OPMC; user commands use ordinary names.
- Existing indentation is mixed between tabs and spaces. Preserve local file style rather than reformatting unrelated lines.
- Modules must use `return`, not `exit`, for early termination because they execute in caller's shell.

## Private Extensions and Secrets

`.gitignore` excludes every path containing `.private.`. A root-level `*.private.sh` is automatically sourced among public modules according to filename order. `*.private.json` files provide local data but are not sourced.

`26-1password_macos_cache.sh` derives its config filename from its own basename, so expected path is `26-1password_macos_cache.private.json`. It:

- activates only when both `op` and macOS `security` exist;
- reads config entries with `jq`;
- uses environment-variable name as macOS Keychain service name;
- retrieves missing values with `op read`, caches them, and exports them during startup;
- exposes `opmc_clear`, `opmc_clear_all`, and `opmc_export_all`.

Never commit private config or print secret values during validation.

## Non-Obvious Failure Modes

- `.init.sh` checks `jq` before defining `error`; in a shell where `error` is not already defined, missing-`jq` handling may itself report `error: command not found` before returning.
- `.init.sh` uses `return 1 2>/dev/null || exit 1`, allowing use both when sourced and when executed. Preserve this dual-context pattern in entry-point prerequisite checks.
- Setting `AGENT` suppresses helper logs, but `.init.sh` still prints one agent header to standard output.
- `30-kubernetes.sh` defines alias completion unconditionally after guarded `kubectl` completion. Without `kubectl`, `__start_kubectl` may be undefined and runtime loading can emit a completion error.
- `50-postgresql.sh` calls `brew --prefix` without checking `brew`. Ordering after `10-homebrew.sh` does not make Homebrew available on non-Homebrew systems.
- Several macOS modules assume Homebrew because they execute after `10-homebrew.sh`; verify command guards before broadening cross-platform support.
- OPMC's startup call can prompt for 1Password access or mutate Keychain. Syntax validation is safer than runtime loading for routine edits.
- Completion setup uses process substitution (`source <(tool completion ...)`), requiring Bash and an installed tool version whose completion command succeeds.
- `bashrcd_reload` re-sources all modules into existing shell. Repeated loads may prepend duplicate `PATH` entries or redefine completion/aliases.

## Change Guidance

- Keep each integration self-contained and defensively guarded before invoking optional binaries.
- Account for shared global state and lexical ordering when changing paths, aliases, completions, or helper names.
- Validate syntax after every edit. Runtime-test only affected integration in controlled interactive shell with relevant dependency present.
- No test framework or CI configuration was found; do not invent build, lint, test, or deploy commands.
