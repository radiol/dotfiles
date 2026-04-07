---
allow-tools: |
  Bash(git-cliff:*)
  Bash(git branch --show-current), Bash(git add:*), Bash(git diff), Bash(git status), Bash(git log:*), Bash(git tag:*)
  Bash(cat:*), Bash(sed:*), Bash(date:*), Bash(grep:*)
  Read(*), Write(*)
  Bash(rg:*), Glob(*), Grep(*), TodoWrite
description: プロジェクトのバージョンを上げます。セマンティックバージョニングと日付ベースバージョニングの両方に対応します
---

# version up

以下の手順でversion upを行ってください。

## 手順

### 1. 現在の状態を確認

- `git diff` と `git status` で変更内容を確認する
- `git log --oneline -20` で直近のコミット履歴を確認する

### 2. バージョニング方式を検出

`git tag --sort=-v:refname` で既存のタグ一覧を取得し、バージョニング方式を判別する。

- **セマンティックバージョニング**: `v1.2.3`, `1.2.3` のようなパターン
- **CalVer (日付ベース)**: `v2024.01.15`, `2024.1`, `24.3.1` のようなパターン

タグが存在しない場合はユーザーにどちらの方式を使うか確認する。

### 3. バージョン管理ファイルを検出

プロジェクトルートから以下のファイルを探し、現在のバージョンを特定する。複数見つかった場合はすべて更新対象とする。

| ファイル | 言語/ツール | バージョン記述箇所 |
|---|---|---|
| `Cargo.toml` | Rust | `version = "x.y.z"` (package セクション内。workspace の場合は `[workspace.package]` も確認) |
| `package.json` | Node.js | `"version": "x.y.z"` |
| `pyproject.toml` | Python | `version = "x.y.z"` |
| `setup.py` | Python (legacy) | `version="x.y.z"` |
| `build.gradle` / `build.gradle.kts` | Java/Kotlin | `version = "x.y.z"` |
| `pom.xml` | Java (Maven) | `<version>x.y.z</version>` |
| `mix.exs` | Elixir | `version: "x.y.z"` |
| `pubspec.yaml` | Dart/Flutter | `version: x.y.z` |
| `*.gemspec` | Ruby | `spec.version = "x.y.z"` |
| `version.txt` / `VERSION` | 汎用 | バージョン文字列のみ |

見つからない場合はユーザーにバージョンファイルのパスを確認する。

### 4. 次のバージョンを決定

#### セマンティックバージョニングの場合

変更内容を分析し、以下の基準で判断する:

- **MAJOR** (x.0.0): 破壊的変更 (Breaking Changes) がある場合
- **MINOR** (x.y.0): 後方互換性のある新機能追加がある場合
- **PATCH** (x.y.z): バグ修正、ドキュメント更新、リファクタリングなどの場合

#### CalVer (日付ベース) の場合

既存タグのパターンに合わせて日付を生成する:

- `YYYY.MM.DD` / `YYYY.M.D` — 今日の日付
- `YYYY.MM.patch` — 同月リリースが既にあれば patch 部分をインクリメント
- その他のパターン — 既存のフォーマットに倣う

### 5. ユーザーに確認

変更先のバージョンについてユーザーの承認を得る。以下を提示すること:

- 現在のバージョン
- 提案する次のバージョン (と選定理由)
- 更新対象のファイル一覧

### 6. バージョンファイルを更新

手順3で検出したすべてのファイルのバージョンを更新する。

### 7. CHANGELOG を更新

以下の優先順でCHANGELOGを更新する:

1. **git-cliff が利用可能** (`cliff.toml` や `git-cliff` コマンドが存在): `git-cliff` を使って生成する
2. **既存の CHANGELOG ファイルがある場合** (`CHANGELOG.md`, `Changes.md`, `HISTORY.md` 等): 手動でエントリを追記する
3. **どちらもない場合**: ユーザーにCHANGELOGの作成要否を確認する

### 8. コミットとタグ付け

- 変更をコミットする。コミットメッセージは `chore: release vX.Y.Z` とする
- 既存タグの prefix に合わせてタグを作成する (`v` prefix の有無を揃える)
- `git push && git push --tags` でリモートに反映する
