---
allow-tools: |
  Bash(git branch --show-current), Bash(git diff), Bash(git status), Bash(git log:*), Bash(git add .), Bash(git commit -m "*"), Bash(git checkout -b:*)
  Read(*.ts), Read(*.js), Read(*.py), Read(*.rs), Read(*.go), Read(*.json)
  Bash(rg:*), Bash(gomi:*), Glob(*), Grep(*), TodoWrite
description: ブランチを切ってから変更をcommitします。commitはconventional commitに準拠します。
---

# commit

以下の手順でコミットを行ってください。

## 手順

1. `git diff` と `git status` で変更内容を確認する
2. 現在のブランチが `main` / `master` の場合は、新たにブランチを作成する（例: `git checkout -b feature/your-feature-name`）
3. 変更内容を分析し、Conventional Commits形式のコミットメッセージを提案する
4. 確認を取ってから `git add .` → `git commit -m "<message>"` を実行する

## コミットメッセージのルール

- 形式: `<type>: <description>`
- descriptionは命令形・現在形で書く（例: `add` / `fix` / `update`）

### タイプ

| タイプ     | 用途                   |
| ---------- | ---------------------- |
| `feat`     | 新機能追加             |
| `fix`      | バグ修正               |
| `refactor` | リファクタリング       |
| `chore`    | ビルド・設定・依存関係 |
| `docs`     | ドキュメントのみ       |
| `test`     | テストの追加・修正     |
| `style`    | フォーマット変更       |
| `perf`     | パフォーマンス改善     |

## 注意

- 複数の独立した変更がある場合は、分割してコミットすることを提案する
