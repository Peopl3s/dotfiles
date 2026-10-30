#!/usr/bin/env bash
#
# Применяет все настройки macOS из macos/defaults/*.sh.
#
# Запуск:
#   bash ~/Desktop/dotfiles/macos/settings.sh
#
# Запустить только один блок:
#   bash ~/Desktop/dotfiles/macos/defaults/02-dock.sh
#
set -euo pipefail

# Папка, в которой лежит этот файл, — чтобы скрипт работал из любого места.
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly BASEDIR

echo 'Настраиваю macOS. Это займёт несколько секунд.'

# Закрываем «Системные настройки»: иначе они перезапишут часть значений
# своими, когда приложение будет закрываться.
osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true
osascript -e 'tell application "System Preferences" to quit' 2>/dev/null || true

# Просим sudo один раз в начале (нужен в 06-display-energy.sh),
# чтобы пароль не спрашивали посреди работы.
sudo -v

# Пока скрипт работает, держим sudo-сессию живой в фоне.
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" 2>/dev/null || exit
done 2>/dev/null &

# Выполняем блоки по порядку номеров: 01-…, 02-… и так далее.
for part in "$BASEDIR"/defaults/*.sh; do
  bash "$part"
done

# --- Перезапуск служб, чтобы изменения применились ---------------------------
#
# Большинство настроек читается приложением только при старте,
# поэтому перезапускаем те, которых мы коснулись.

echo '→ Перезапускаю Finder, Dock и строку меню'

for app in \
  'Finder' \
  'Dock' \
  'SystemUIServer' \
  'ControlCenter' \
  'TextInputMenuAgent'; do
  killall "$app" >/dev/null 2>&1 || true
done

echo
echo 'Готово.'
echo 'Что применится не сразу:'
echo '  • раскладки клавиатуры — после перезахода в учётную запись;'
echo '  • язык и регион — после перезагрузки.'
