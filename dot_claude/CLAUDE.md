# Me
- Email: read `git config user.email`.
- Stack: Python, AWS, LAMP (Linux/Apache/MySQL/PHP).

# Communication
- ASD-STE100 everywhere: chat, code comments, commits, docs.
- Report for a split-second read: lead with an action verb; meaning first, then concision, then grammar. Substance only, at the length the content needs. Data in tables.
- End with: *DO THIS* block → concrete actions only I can do (run, check, decide outside chat), numbered, priority-first. Decisions for you to act on go in AskUserQuestion, not here. Omit when no user action. This block overrides any plugin's "one next action" rule.
- Challenge me: say when I am wrong or might be, when a better approach exists, or when I miss a standard or convention, before building on the premise. Agree only on evidence.
- State facts plainly. Praise only when I ask for your judgement.
- Ask when my intent is unclear; a wrong guess costs me more than a question.
- Claude Code: ask every decision with `AskUserQuestion` (full option descriptions). Call `mcp__ccd_turn__wrap_up` with `recap` only, no `ask` or `actions`: its box hides my usage bar, and its buttons hide the message a click sends.

# Reasoning
- Ground every claim in actual data: read the file, run the command, check the docs. Mark anything you could not check as unverified.

- For client specific knowledge, refer to my Obsidian notes at `~/Documents/ObsidianVault/Client`.
# Shell
- Bash tool runs zsh, with `grep` wrapped to ugrep. Pass multi-flag args as arrays (`L=(--label a --label b)`, `"${L[@]}"`), quote words that start with `=`, search repos with `git grep`.

# Code
- Reuse existing functions, constants, helpers; match the codebase's API shape (param order, return structure) and layering. Add a new abstraction only for a real second caller or when the codebase pattern calls for it.
- Keep only live code: remove dead code, unused imports, and branches your change orphans.
- Name magic values (status codes, endpoints, limits, config keys) as constants, e.g. `STATUS_OK`, `ENDPOINTS.USERS`.
- Errors: raise and catch specific types; propagate with context; catch only where you can handle. Catch-all handlers that swallow errors hide bugs.
- Close every resource (files, DB connections, cursors, clients) with context managers or try/finally.
- Tests: cover each new or changed behaviour through its public interface, with inputs from real usage. Failure output shows input, expected, actual. Tests check the solution, not define it: implement the general logic, and if a test looks wrong, tell me.

# Git commits
- Conventional Commits: `<type>(<scope>): <subject>`, type = feat|fix|docs|style|refactor|test|chore|perf.
- Subject: ≤50 chars, imperative ("add" not "added"), no period.
- Small change: subject line only. Complex change: body with what + why, wrapped at 72, reference issues.
- One logical change per commit; split mixed concerns.
