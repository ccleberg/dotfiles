# CLAUDE.md

## 0. TOP RULE (overrides everything)

**Never include attribution to Claude or mention Claude/LLMs/AI in any instance,
ever.** This includes git commit trailers (no `Co-Authored-By: Claude`), PR
bodies, code comments, and any other output.

Behavioral guidelines to reduce common LLM coding mistakes. Merge with
project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial
tasks, use judgment.

## Avoid verbose and buzzword-laden commentary

Write text (code comments, documentation, website copy, conversations with me,
etc.) in plain, direct English, as a competent engineer explaining it to a
colleague. Remove dramatic framing, suspense-building, hype, and buzzy metaphors
(e.g. 'load-bearing assumption', 'here's the kicker', 'the most instructive
part', 'this changes everything'). Plain sentences, no reveals. Keep every
technical fact, number, file path, command, and code block exactly intact — only
the style changes, not the substance, and do not shorten beyond what removing
fluff removes. Output only the rewritten text with no preamble or commentary.

Pull requests and commit messages should be succinct and deliver the facts of
the changes immediately without unnecessary commentary. Do not provide
before/after commentary within a repository's comments or files - that's what
the git history is for. Write every comment, doc, and PR with the assumption
that the reader is already knowledgeable and does not need their hand held -
only the facts and only the bare minimum required.

## Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes,
simplify.

## Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should tracedirectly to the user's request.

## Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it
work") require constant clarification.

## Git Workflow

**Never push to `main`. Branch first, then open a merge/pull request.**

This holds in every repository, with no exceptions for one-line changes or
for repositories with a single contributor.

1. Branch.
2. Open the MR (gitbay) or PR (elsewhere).
3. Full test suite green before merging.
4. Merge, then delete the branch both locally and remotely.
5. Commit messages reference issues: `Closes #N` / `Ref #N`.

## gitbay (repos whose origin is gitbay.org)

Most repos under `~/git/krz/` have their origin on **gitbay.org**, a
self-hosted git forge (its own source is `krz/gitbay`). It is not GitHub.
`gh` does nothing there, there are no pull requests, and there is no GitHub
API. Do not try to map the workflow onto one. Everything below applies only
when `git remote get-url origin` points at gitbay.org.

- The `gitbay` CLI is installed and authenticated over SSH as `cmc`
  (admin). `gitbay auth whoami` confirms it.
- Merge requests, not pull requests. The noun is `mr`.
- Writes go over SSH only. `git push` works over the `ssh://` origin;
  HTTPS and `git://` are read transports.
- Public repos are readable on the web without auth
  (https://gitbay.org/krz/solar), so fetching a page works — but the CLI is
  faster and gives you JSON.

### Finding a command without guessing

The server's command registry is the only source of truth for flags; the
CLI is a thin passthrough. Ask it directly rather than guessing:

```bash
gitbay mr create --help
```

That prints the command's real usage. A prefix narrows the registry to one
noun, over bare SSH or from a clone:

```bash
ssh git@gitbay.org help mr
```

Bare `help` lists every command, sorted, one line each with no flags — an
index, not a reference. `--json` gives `{path, summary, usage}` per row.

Two things this does not cover. `gitbay issue --help` (a group, not a
command) still prints cobra's subcommand list without flags, so go one
level deeper to `gitbay issue create --help`. And any command run with
missing arguments prints its exact usage and exits 2, which is cheaper
than a second guess. An unmatched `help` prefix exits 3.

### The repo argument is inferred

Inside a clone whose `origin` matches a configured instance
(`gitbay remote list`), `<owner/name>` is filled in from the remote. These
are equivalent inside `krz/gitbay`:

```bash
gitbay issue list
gitbay issue list krz/gitbay
```

Outside a clone, or to target another repo, pass `<owner/name>` as the
first argument. Inference never fires on a clone from some other host, so a
GitHub checkout cannot hijack a command.

### --json is the contract

Every command takes `--json`. That output is stable; the human-readable
output is not. Parse JSON, never the text.

```bash
gitbay issue list --state open --json
gitbay dashboard --json
```

Exit codes: `0` ok, `1` failure, `2` usage, `3` not found, `4` denied,
`5` protocol or ssh failure.

### Long text

Bodies come from `--body`/`--message`, from `--file -` on stdin, or from
`$EDITOR` when neither is given. A non-interactive session must use stdin
or it will hang waiting on an editor:

```bash
gitbay issue create --title "..." --file - <<'EOF'
body text
EOF
```

### Common tasks

```bash
gitbay dashboard                              # review queue, assigned work, builds
gitbay issue list --state open
gitbay issue show <n>
gitbay issue comment <n> --file -
gitbay mr create --source <branch> --target main --title "..."
gitbay mr diff <n>
gitbay mr merge <n> --strategy squash
gitbay build list                             # CI
gitbay build log <n>
gitbay repo list --json
gitbay init <name> [--private]                # git init + repo create + set origin
```

`krz/gitbay` has its own CLAUDE.md covering how the forge is built. The
above is about using it as a client.

---

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer
rewrites due to overcomplication, and clarifying questions come before
implementation rather than after mistakes.
