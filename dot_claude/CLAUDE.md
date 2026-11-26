# Locale

- Use Japanese for all responses.

# Code style

- Do not use full-width punctuation/symbol characters in code comments or docstrings.
  - Examples of disallowed full-width symbols: （ ）［ ］｛ ｝＜ ＞「 」『 』【 】、。！？：；・…ー
  - Use ASCII equivalents instead: () [] {} <> "" '' , . ! ? : ; - ...
- Japanese words/kanji/kana are allowed; only full-width symbols should be avoided.

# Git

- Before committing, always check the current branch with `git branch --show-current`.
- If on `main`, do not commit directly. Create a new branch first, then commit.
  - Example: `git checkout -b feature/your-feature-name`

# SuperPowers

- When using the Superpowers plugin for code implementation, subagent-driven-development is the default execution mode.

## Codex Delegation Rules

When delegating implementation to codex:codex-rescue, always insert the following sentence verbatim at the beginning of the prompt:

> The plan is already approved. Do not use brainstorming or writing-plans. Implement following test-driven-development and verification-before-completion.
>
## Code Review via Codex

In Superpowers workflows, use Codex for code review instead of Claude reviewer subagents.

- Task review (subagent-driven-development): after each task, do NOT dispatch the
  task reviewer subagent. Instead dispatch codex:codex-rescue with a prompt starting with
  `--wait --fresh` followed by:
  - "Read-only review. Do not modify any files."
  - the task text from the plan and the plan file path
  - the commit range (BASE_SHA..HEAD_SHA)
  - "Review for spec compliance and code quality.
    Report issues as Critical / Important / Minor with file:line."
- Final review (requesting-code-review): same procedure, with range `main...HEAD`
  and "Review the whole branch."
- Handle Codex findings with receiving-code-review: verify each finding against the
  code before acting, fix Critical/Important before moving on, push back on wrong ones.
- If codex:codex-rescue returns empty output, treat it as a failure: fall back to the
  normal Superpowers reviewer subagent and tell the user.
