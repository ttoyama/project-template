# project-template

研究プロジェクト用のテンプレートフォルダ。新規プロジェクト作成時にコピーして使う。

## 使い方

```bash
cp -r project-template /path/to/new-project
cd /path/to/new-project
rm -rf .git
git init
```

コピー後、以下を編集する:
- `CLAUDE.md` のプロジェクト概要欄を記入する
- `documents/progress/progress.qmd` のタイトル・サブタイトルを記入する
- ディレクトリ名のプレースホルダー（`JOURNALNAME_XYZ`, `CONFERENCENAME_XYZ`, `YYYY-MM-DD`）を実際の名前に置き換える

## ディレクトリ構成

| ディレクトリ | 内容 |
|:---|:---|
| `conference/` | 学会発表（抄録・スライド） |
| `data/` | 元データ（外部から受領したデータ等） |
| `documents/` | 自分たちが作成・管理する研究運営文書（プロトコル、IRB、SAP、DMP等） |
| `manuscript/` | 論文原稿（ジャーナル別・段階別に管理） |
| `output/` | 統計解析結果（データ・図・表・ログ・レポート） |
| `references/` | 外部の参考資料（論文PDF、ガイドライン等） |
| `script/` | 解析スクリプト |

## 分析環境

Stata-MP, R, Quarto, LaTeX をローカルで実行可能な前提で構成している。

## Claude Code 連携

- `run_claudecli.command` をダブルクリックすると Claude Code が起動する
- `.claude/commands/compile.md` で `/compile` コマンドから LaTeX コンパイルを実行できる
- `.claude/settings.local.json` で `rm -rf` や `git push --force` 等の危険な操作を禁止している
