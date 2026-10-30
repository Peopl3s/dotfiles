#!/usr/bin/env bash
#
# Разворачивает рабочее окружение: симлинки на конфиги, пакеты, приложения.
#
# Запуск:
#   bash ~/Desktop/dotfiles/install.sh
#
# Настройки самой macOS применяются отдельно (там нужен sudo):
#   bash ~/Desktop/dotfiles/macos/settings.sh
#
# -e  — падать на первой ошибке
# -u  — ругаться на необъявленные переменные
# -o pipefail — считать конвейер упавшим, если упало любое его звено
set -euo pipefail

# Папка этого скрипта — чтобы install.sh работал из любого каталога.
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly BASEDIR

# Одна папка backup/<дата>/ на весь запуск — её увидят все шаги.
BACKUP_DIR="$BASEDIR/backup/$(date +%Y-%m-%d_%H-%M-%S)"
export BACKUP_DIR

# --- Проверки до начала работы -----------------------------------------------

# Только macOS: ниже используются defaults, pmset и пути ~/Library.
if [ "$(uname -s)" != 'Darwin' ]; then
  echo 'Этот набор настроек рассчитан только на macOS.' >&2
  exit 1
fi

# Homebrew обязателен — без него не отработает шаг 2.
if ! command -v brew >/dev/null 2>&1; then
  echo 'Homebrew не найден. Установи его и запусти скрипт заново:' >&2
  echo '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"' >&2
  exit 1
fi

# --- Шаги --------------------------------------------------------------------
#
# Каждый шаг — отдельный скрипт в steps/, его можно запустить и в одиночку.
# `|| true` — чтобы сбой одного шага (нет Cursor, нет интернета для одного
# пакета) не обрывал остальные.

echo "Разворачиваю окружение из $BASEDIR"
echo

for step in "$BASEDIR"/steps/[0-9]*.sh; do
  bash "$step" || echo "  шаг $(basename "$step") завершился с ошибкой — продолжаю"
  echo
done

# --- Итог --------------------------------------------------------------------

if [ -d "$BACKUP_DIR" ]; then
  echo "Копии старых конфигов: $BACKUP_DIR"
fi

echo 'Готово. Дальше:'
echo '  1. Открой новый терминал, чтобы подхватился новый ~/.zshrc'
echo '  2. Примени настройки системы: bash macos/settings.sh'
