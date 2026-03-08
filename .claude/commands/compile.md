LaTeX文書をコンパイルする。

手順:
1. `manuscript/` 以下で最新の日付ディレクトリを探す
2. そのディレクトリ内の .tex ファイルを `ls *.tex` で検出する
3. compile.sh が存在すればそれを使う。なければ以下の手順でコンパイルする
4. .bib ファイルが存在する場合はBibTeX付きフルコンパイルを実行する:
   ```bash
   pdflatex FILENAME.tex
   bibtex FILENAME
   pdflatex FILENAME.tex
   pdflatex FILENAME.tex
   ```
5. .bib ファイルが存在しない場合は単独コンパイルを実行する:
   ```bash
   pdflatex FILENAME.tex
   ```
6. コンパイルエラーがあれば内容を報告する
7. 成功したらPDFのページ数を確認して報告する
