#!/usr/bin/env bash
#
# Ставит расширения Cursor из cursor/extensions.txt.
#
set -euo pipefail

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly BASEDIR

# CLI `cursor` появляется после команды
# «Shell Command: Install 'cursor' command in PATH» из палитры команд Cursor.
if ! command -v cursor >/dev/null 2>&1; then
  echo 'Команда `cursor` не найдена.' >&2
  echo 'Открой Cursor → ⌘⇧P → Shell Command: Install '"'"'cursor'"'"' command in PATH' >&2
  exit 1
fi

# Читаем файл построчно, пропуская комментарии и пустые строки.
while IFS= read -r extension; do
  case "$extension" in
    ''|\#*) continue ;;
  esac
  echo "→ $extension"
  cursor --install-extension "$extension" --force
done < "$BASEDIR/extensions.txt"

echo 'Расширения установлены.'
