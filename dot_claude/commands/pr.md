---
allow-tools: |
  Bash(git branch --show-current), Bash(git diff), Bash(git status), Bash(git log:*), Bash(git add .), Bash(git commit -m "*"), Bash(git checkout -b:*)
  Read(*.ts), Read(*.js), Read(*.py), Read(*.rs), Read(*.go), Read(*.json)
  Bash(rg:*), Glob(*), Grep(*), TodoWrite
description: PRを作成する
---


# pr

以下の手順でPull Requestを作成してください。

## 手順

1. 現在のブランチとベースブランチを確認する

   ```bash
   git branch --show-current
   git log main..HEAD --oneline
   ```

2. `git diff main...HEAD` でmainとの差分を確認する

3. コミット履歴と変更内容からPRの内容を分析し、以下を提案する
   - **タイトル**: Conventional Commits形式（例: `feat: add hospital-centric TOML config`）
   - **本文**: 下記テンプレートに沿って記載

4. 確認を取ってから `gh pr create` でPRを作成する

## PRテンプレート

```markdown
## 概要

<!-- 何をなぜ変更したか -->

## 変更内容

<!-- 主な変更点を箇条書きで -->

## 動作確認

<!-- 確認した内容 -->
```

## 実行コマンド

```bash
gh pr create \
  --title "<title>" \
  --body "<body>" \
  --base main
```

## 注意

- まだリモートにプッシュされていない場合は `git push -u origin <branch>` を先に実行する
- ベースブランチは通常 `main` だが、リポジトリの設定に合わせて変更する
- Draft PRにしたい場合は `--draft` フラグを追加する
