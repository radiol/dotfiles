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
