# Visual Studio Code 拡張機能インストール

# カレントにパスが通っていない場合は通す
if (-not $env:path.Split(';').Contains('.\')) {
    $env:path = $env:path + ';.\'
}

# binへのパスが未登録ならカレントディレクトリ変更
$binPath = Join-Path ([Environment]::GetFolderPath('LocalApplicationData')) 'Programs\Microsoft VS Code\bin'
if ($env:path.IndexOf($binpath, [System.StringComparison]::OrdinalIgnoreCase) -eq -1) {
    cd $binPath
}


# 日本語パック
code --install-extension ms-ceintl.vscode-language-pack-ja --force

# コーディング支援
code --install-extension shardulm94.trailing-spaces --force
code --install-extension coenraads.bracket-pair-colorizer-2 --force
code --install-extension wayou.vscode-todo-highlight --force
code --install-extension vscode-icons-team.vscode-icons --force
code --install-extension mechatroner.rainbow-csv --force

# デバッグ支援
code --install-extension formulahendry.code-runner --force
code --install-extension ritwickdey.liveserver --force

# Ruby
code --install-extension rebornix.ruby --force
code --install-extension wingrunr21.vscode-ruby --force

# Python
code --install-extension ms-python.python --force

# PHP
code --install-extension onecentlin.laravel-blade --force

# PowerShell
code --install-extension ms-vscode.powershell --force

# ドキュメント作成
code --install-extension docsmsft.docs-markdown --force
code --install-extension yzane.markdown-pdf --force
code --install-extension hediet.vscode-drawio --force

# リモート接続
code --install-extension ms-vscode-remote.vscode-remote-extensionpack --force
code --install-extension ms-vscode-remote.remote-ssh --force
code --install-extension ms-vscode-remote.remote-ssh-edit --force
code --install-extension ms-vscode-remote.remote-wsl --force
code --install-extension ms-vscode-remote.remote-containers --force

# HTML/CSS
code --install-extension abusaidm.html-snippets --force
code --install-extension mkaufman.HTMLHint --force
code --install-extension Zignd.html-css-class-completion --force
