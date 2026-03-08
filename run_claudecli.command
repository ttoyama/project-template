#!/bin/bash
cd "$(dirname "$0")"
REAL_DIR="$(pwd)"
echo "作業ディレクトリ: $REAL_DIR"

# パスが長いと Claude Code のソケット作成に失敗するため、短いシンボリックリンク経由で起動する
WORK_DIR="$REAL_DIR"
PATH_LEN=$(printf '%s' "$REAL_DIR" | wc -c | tr -d ' ')
if [ "$PATH_LEN" -gt 80 ]; then
    SHORT_LINK="/tmp/_claude_$$"
    ln -sfn "$REAL_DIR" "$SHORT_LINK"
    WORK_DIR="$SHORT_LINK"
    trap 'rm -f "$SHORT_LINK"' EXIT
    echo "パスが長いため短縮リンクを使用: $SHORT_LINK"
fi

# 福井大学内LANからの接続の場合のみプロキシを適用
PROXY_CMDS=""
if [[ $(hostname) == *"u-fukui.ac.jp" ]]; then
    export http_proxy="http://ufproxy.m.cii.u-fukui.ac.jp:8080/"
    export https_proxy="http://ufproxy.m.cii.u-fukui.ac.jp:8080/"
    PROXY_CMDS="export http_proxy='http://ufproxy.m.cii.u-fukui.ac.jp:8080/' && export https_proxy='http://ufproxy.m.cii.u-fukui.ac.jp:8080/' && "
    echo "福井大学内LANから接続中: プロキシを設定しました"
else
    echo "大学外からの接続: プロキシ設定をスキップしました"
fi

# claude コマンドの存在確認
if ! command -v claude &>/dev/null; then
    echo "エラー: claude コマンドが見つかりません"
    echo "任意のキーを押して終了..."
    read -n 1
    exit 1
fi

cd "$WORK_DIR"
claude --dangerously-skip-permissions
