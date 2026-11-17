# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## プロジェクト概要

（プロジェクトごとに記入する）

## 禁止事項

- 患者個人識別情報（氏名・生年月日・ID・住所等）を log・report・output に出力しない
- `data/` の生データファイルは Claude が直接読まない。データ構造は R や Stata のスクリプト経由で確認し、解析もスクリプト側で完結させる（`.claudeignore` で除外済み）
- `data/` の生データを chat・commit message・issue本文・PR本文に貼り付けない
- 認証情報（APIキー・password）はコードにハードコードしない。環境変数または keychain (`security find-generic-password`) 経由で取得する
- `data/` 配下のファイルは delete・上書きしない。row も削除せず flag で管理する（解析時の dedup は `if baseline_row == 1` 等で行う）
- 解析結果（個票・集計値）を外部の生成AI API（ChatGPT 等）に送信しない

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
│   │           └── mock/          #     mock table / mock figure
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
│   └── JOURNALNAME_XYZ/           # 投稿する雑誌ごとに1つ
│       ├── instructions_for_authors/  # 投稿規程
│       ├── 00_initial_submission/     # 初回投稿
│       │   └── YYYY-MM-DD/            # 更新ごとの版。最後の日付が投稿した最終原稿
│       │       ├── main_text/
│       │       ├── figures/
│       │       └── cover_letter/
│       ├── 10_first_revision/         # R1
│       │   ├── 10_R1_10_before_revision/    # 修正前の原稿一式（投稿版を写す）
│       │   ├── 10_R1_20_received_comments/  # 査読コメント・決定通知
│       │   └── 10_R1_30_preparing_revision/ # 修正の作業場
│       │       └── YYYY-MM-DD/              # 更新ごとの版。最後の日付が R1 の提出版
│       │           ├── main_text/
│       │           ├── figures/
│       │           ├── response_letter/
│       │           └── cover_letter/
│       ├── 20_second_revision/        # R2（R1 と同じ形）
│       │   ├── 20_R2_10_before_revision/
│       │   ├── 20_R2_20_received_comments/
│       │   └── 20_R2_30_preparing_revision/
│       │       └── YYYY-MM-DD/
│       └── 90_post_acceptance/        # 受理後
│           ├── oa_fee/
│           └── outreach/
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

論文原稿の管理。投稿する雑誌ごとに `JOURNALNAME_XYZ/` を作る。リジェクトされて別の雑誌に出し直すときは、新しい雑誌名のフォルダを作って 00 から始め、前の雑誌のフォルダは残す。

- `00_initial_submission/YYYY-MM-DD/`: 初回投稿までの原稿。直すたびに新しい日付フォルダを作り（前の版を写してから直す）、古い日付のフォルダは上書きしない。日付フォルダが版の数だけ並び、**最後の日付のものが初回投稿の最終原稿**になる。日付は投稿日ではなく、その版を作った日である
- `10_first_revision/`: R1
  - `10_R1_10_before_revision/`: 修正前の原稿一式。R1 に入ったら最初に投稿版を写し、以後は触らない
  - `10_R1_20_received_comments/`: 査読コメント・決定通知
  - `10_R1_30_preparing_revision/YYYY-MM-DD/`: 修正の作業場。00 と同じく更新ごとに日付フォルダを作り、最後の日付のものが R1 の提出版になる。main_text/, figures/, response_letter/, cover_letter/ を含む
  - 共著者からのフィードバックは `10_R1_30_preparing_revision/` 直下に `YYYY-MM-DD_共著者名/` のように都度作成する
- `20_second_revision/`: R2。中身は R1 と同じ形（`20_R2_10_…` `20_R2_20_…` `20_R2_30_…`）。R3 以降は `30_third_revision/` を足す
- `90_post_acceptance/`: 受理後。`oa_fee/`（掲載料・OA の手続き）、`outreach/`（広報）
- `instructions_for_authors/`: 投稿規程の PDF・チェックリスト

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
  - `SAP/YYYY-MM-DD/mock/`: SAP に付随する mock table / mock figure（数値が入っていない表・図の雛形）を置く。SAP 本体と同じ日付フォルダに入れ、版を一対一で対応させる
  - mock は SAP の付属物なので `documents/` 直下には置かない。実データを入れた成果物は `output/tables/` `output/figures/` 側で管理し、mock とは分ける
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
2. `manuscript/JOURNALNAME_XYZ/00_initial_submission/` に今日の日付でディレクトリを作成する
3. その中で論文の下書きを作成する（LaTeX、英語）
4. 直すたびに日付フォルダを足し、最後の日付の版で投稿する。投稿版を別のフォルダへ移さない
5. 査読が返ってきたら `10_first_revision/10_R1_10_before_revision/` に投稿版を写してから R1 の作業に入る

### 日付をまたいで作業を継続する場合
- 作業開始時に日付が変わっていたら、最新の日付フォルダを今日の日付でコピーしてから作業を続ける
- 例: `2025-11-25/` が最新で今日が `2025-11-26` の場合
  ```bash
  cp -r 00_initial_submission/2025-11-25 00_initial_submission/2025-11-26
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
