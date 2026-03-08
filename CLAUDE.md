# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## プロジェクト概要

（プロジェクトごとに記入する）

## ディレクトリ構造

```
.
├── conference/                    # 学会発表関連
│   └── CONFERENCENAME_XYZ/
│       ├── abstracts/             # 抄録
│       │   └── YYYY-MM-DD/
│       └── slides/                # スライド
│           └── YYYY-MM-DD/
│               └── notes/
├── data/                          # 元データ（外部から受領したデータ等）
│   └── YYYY-MM-DD/
├── documents/                     # 自分たちが作成・管理する研究運営文書
│   ├── protocol/                  # 研究プロトコル本体
│   │   └── YYYY-MM-DD/
│   ├── IRB/                       # 倫理委員会提出用一式
│   │   ├── PRT/                   #   倫理委提出版プロトコル
│   │   │   └── YYYY-MM-DD/
│   │   ├── ICF/                   #   同意説明文書
│   │   │   └── YYYY-MM-DD/
│   │   └── SAP/                   #   統計解析計画書
│   │       └── YYYY-MM-DD/
│   ├── DMP/                       # データ管理計画
│   ├── CSR/                       # 臨床試験報告書
│   │   ├── fixed/
│   │   └── YYYY-MM-DD/
│   ├── grants/                    # 予算申請・助成金申請
│   │   └── YYYY-MM-DD/
│   ├── contracts/                 # 契約関連文書
│   ├── others/                    # その他文書
│   └── progress/                  # 進捗記録
│       └── progress.qmd           # 進捗レポート
├── manuscript/                    # 論文原稿
│   └── JOURNALNAME_XYZ/
│       ├── 00_preparation/        # 論文下書き
│       │   ├── instructions_for_authors/
│       │   └── YYYY-MM-DD/
│       │       └── figures/
│       ├── 10_submission/         # 投稿版
│       ├── 20_first_revision/     # 第1回リビジョン
│       └── 30_second_revision/    # 第2回リビジョン以降
├── output/                        # 統計解析結果
│   ├── data/                      # 解析で生成されたデータ
│   ├── figures/                   # 図
│   ├── log/                       # ログ
│   ├── reports/                   # 解析レポート
│   └── tables/                    # 表
├── references/                    # 外部の参考資料
└── script/                        # 解析スクリプト
```

### documents/ と references/ の使い分け

- **documents/**: 自分たちが作成・管理する研究運営文書（プロトコル、SAP、DMP、契約書、進捗記録など）
- **references/**: 外部の参考資料（他者が書いた論文PDF、ガイドライン、教科書の抜粋など）

### manuscript/

論文原稿の管理。ジャーナル別にサブディレクトリを作成する:
- `JOURNALNAME_XYZ/00_preparation/YYYY-MM-DD/`: 論文の下書きを日付ディレクトリに作成する
- `JOURNALNAME_XYZ/10_submission/`: 投稿版
- `JOURNALNAME_XYZ/20_first_revision/`: 第1回リビジョン
- `JOURNALNAME_XYZ/30_second_revision/`: 第2回リビジョン以降

### output/

統計解析結果の保存場所:
- `data/`: 解析で生成されたデータ
- `figures/`: 図表
- `log/`: 解析ログ
- `reports/`: 解析レポート
- `tables/`: 表

### documents/

研究関連文書:
- `protocol/`: 研究プロトコル本体
- `IRB/`: 倫理委員会提出用一式（PRT: 倫理委提出版プロトコル、ICF: 同意説明文書、SAP: 統計解析計画書）
- `DMP/`: データ管理計画（Data Management Plan）
- `CSR/`: 臨床試験報告書
- `grants/`: 予算申請・助成金申請
- `contracts/`: 契約関連文書
- `progress/`: 進捗記録。`progress.qmd` に一元管理し、更新後は `quarto render documents/progress/progress.qmd` でHTMLを再生成する

### conference/

学会発表関連:
- `CONFERENCENAME_XYZ/abstracts/`: 抄録
- `CONFERENCENAME_XYZ/slides/`: スライド

## 分析環境

- Stata-MP: ローカルで実行可能
- R: ローカルで実行可能
- Quarto (.qmd): ローカルで実行可能
- LaTeX: ローカルでコンパイル可能

## 進捗管理

進捗は `./documents/progress/progress.qmd` に一元管理する:
- 概要、方針メモ、Next Action、日誌を1ファイルにまとめている
- 進捗があれば日誌セクションに追記し、関連セクションも更新する
- 更新後は `quarto render documents/progress/progress.qmd` でHTMLを再生成する

## ファイル命名規則

- ファイル名には「高度」「comprehensive」など余計な修飾語を使わず、客観的な名前をつける
- レポートやファイル名に「final」はつけない
- シンプルな名前か、ファイル末尾に `_YYYYMMDD` をつける
- 1日に複数できる場合は `_YYYYMMDD_01` とする
- スクリプトファイルは `./script/` 内に `XXX_処理内容_YYYYMMDD.R` や `XXX_処理内容_YYYYMMDD.do` の形式で保存する（XXXは3桁または4桁の連番）

## 論文作成

### 形式
- **論文はLaTeXで英語で作成する**
- ローカルでLaTeXコンパイル可能
- 修正があればその都度コンパイルする

### ワークフロー
1. `output/` にある統計解析結果を確認する
2. `manuscript/JOURNALNAME_XYZ/00_preparation/` に今日の日付でディレクトリを作成する
3. その中で論文の下書きを作成する（LaTeX、英語）
4. 完成したら次の段階（10_submission等）に移動する

### 日付をまたいで作業を継続する場合
- 作業開始時に日付が変わっていたら、最新の日付フォルダを今日の日付でコピーしてから作業を続ける
- 例: `2025-11-25/` が最新で今日が `2025-11-26` の場合
  ```bash
  cp -r 00_preparation/2025-11-25 00_preparation/2025-11-26
  ```
- コピー後、新しいフォルダ内で作業を継続する

### LaTeXコンパイル手順

**重要**: 修正後は必ず都度コンパイルすること

#### 初回コンパイル（BibTeX使用時）
```bash
pdflatex document.tex    # 1回目: .auxファイルに引用情報を書き込む
bibtex document          # .auxを読んで.bblファイル(参考文献リスト)を生成
pdflatex document.tex    # 2回目: .bblを読み込んで引用番号を解決
pdflatex document.tex    # 3回目: 引用番号の相互参照を完全に解決
```

#### 通常の修正時（引用追加・削除がない場合）
```bash
pdflatex document.tex    # 1回のみでOK
```

#### 引用追加・削除時
```bash
pdflatex document.tex    # .auxを更新
bibtex document          # .bblを再生成
pdflatex document.tex    # 引用を反映
pdflatex document.tex    # 相互参照を解決
```

**BibTeXワークフローの重要ポイント**:
- `\cite{...}` が `[?]` と表示される場合は、bibtex実行後にpdflatexを2回実行する必要がある
- references.bibファイルを作成・修正した後は、必ず上記の完全なワークフローを実行する

### 技術的知見

#### Ghostscript libtiff 問題の解決
macOSで`libtiff.5.dylib`が見つからないエラーが発生する場合:
```bash
ln -s /opt/homebrew/Cellar/libtiff/4.7.0/lib/libtiff.6.dylib \
      /opt/homebrew/opt/libtiff/lib/libtiff.5.dylib
```

#### テンプレート使用時の注意点
- `draft` オプションは本番用ではない（ピアレビュー用の仮レイアウト）
- BibTeXスタイルファイル(.bst)は作業ディレクトリに配置すること
- 画像ファイルはEPS形式が推奨（自動的にPDFに変換される）

#### 論文構造のルール
- **セクション構造は \section と \subsection のみを使用する**
- **\subsubsection は使用しない**（論文全体で統一）
- セクション構造: 1. Introduction → 2. Methods → 3. Results → 4. Discussion
- サブセクション例: 2.1 Study design and setting, 2.2 Participants, 2.3 Intervention

#### 単位表記のルール
- eGFRの単位: `mL/min/1.73 m$^2$`（1.73とm$^2$の間に半角スペース）
- 体表面積や体重で正規化する際は数値と単位の間にスペースを入れる
