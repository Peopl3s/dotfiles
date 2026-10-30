#!/usr/bin/env bash
#
# Ставит расширения VS Code из vscode/extensions.txt.
#
set -euo pipefail

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly BASEDIR

# CLI `code` появляется в PATH после команды
# «Shell Command: Install 'code' command in PATH» из палитры команд.
# Если её не запускали — берём бинарник прямо из бандла приложения.
if command -v code >/dev/null 2>&1; then
  CODE_BIN='code'
elif [ -x '/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code' ]; then
  CODE_BIN='/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code'
else
  echo 'VS Code не найден — пропускаю установку расширений.' >&2
  exit 1
fi

# Читаем файл построчно, пропуская комментарии и пустые строки.
while IFS= read -r extension; do
  case "$extension" in
    ''|\#*) continue ;;
  esac
  echo "→ $extension"
  "$CODE_BIN" --install-extension "$extension" --force
done < "$BASEDIR/extensions.txt"

echo 'Расширения VS Code установлены.'
