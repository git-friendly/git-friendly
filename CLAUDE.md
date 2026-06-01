# CLAUDE.md

Five bash scripts that wrap common git workflows: `branch`, `merge`, `pull`, `push`, `stash`. No build, no deps. Installed via Homebrew, so regressions ship to users fast.

## Test

The suite lives in `.github/workflows/ci.yml` as plain `run:` blocks — there's no separate harness. To verify locally, replay the steps against a throwaway fixture in `$TMPDIR`: bare remote, working clone, plus a second clone for remote-side changes. Prepend the repo root to `PATH` and call the script names directly.

Two gotchas when writing a local test wrapper:

- `set +H` first, or `!` gets history-expanded and exits 127.
- `cmd | tail` returns tail's exit code, not cmd's. Use `${PIPESTATUS[0]}` or skip the pipe when you're checking exit codes.

## Script conventions

- Prefer git **plumbing** over parsing porcelain: `git show-ref --verify --quiet`, `git rev-parse --abbrev-ref "$b@{upstream}"`, `git remote get-url --push`, `git branch --show-current`. If you find yourself piping `git branch` to `grep`/`awk`, stop and use plumbing.
- `git switch` / `git switch -c`, not `git checkout` / `git checkout -b`.
- `grep -E` not `egrep`. `command -v` not `which`. Quote variables always — `[ -z "$x" ]`, never `[ -z $x ]`.
- Detect detached HEAD up-front and exit with a clear message; don't let the user fall through to raw git errors.
- Don't match localized English in git output (e.g. "No local changes to save"). Use exit codes, refs, or before/after comparisons instead.
- Propagate exit codes — `exit 0` after a command that might have failed is a footgun. Use `|| exit $?`.

## Style

Commit / PR / branch conventions follow the global rules in `~/.claude/CLAUDE.md` — short laconic titles, no `feat:`/`fix:`/`chore:` prefixes, no `#`/`##` headers in PR bodies, plain-bullet `to test:` blocks. Recent commits and PRs in this repo are the canonical voice; skim a few before opening one.

## Don't

- Push or merge unless explicitly asked — finish locally, surface the command.
- Add helpers, shims, or abstractions for hypothetical futures.
- Write comments that restate the code. Why-not-what, and only when non-obvious.
