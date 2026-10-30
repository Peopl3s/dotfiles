#!/usr/bin/env bash
#
# Настройки отдельных приложений и системные мелочи вокруг них.
#
set -euo pipefail

echo '→ Приложения'

# --- Браузер по умолчанию ----------------------------------------------------

# Сейчас по умолчанию Google Chrome (com.google.chrome).
# Через `defaults` это меняется ненадёжно: LaunchServices кеширует значение,
# поэтому используем сам Chrome — он умеет назначать себя одной командой.
if [ -x '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' ]; then
  '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' \
    --make-default-browser >/dev/null 2>&1 || true
fi

# --- Автозагрузка ------------------------------------------------------------

# В автозагрузке сейчас один пункт — Shottr (скриншоты).
# System Events добавляет его в «Объекты входа».
if [ -d '/Applications/Shottr.app' ]; then
  osascript <<'APPLESCRIPT' >/dev/null 2>&1 || true
tell application "System Events"
  if not (exists login item "Shottr") then
    make new login item at end with properties ¬
      {path:"/Applications/Shottr.app", hidden:false}
  end if
end tell
APPLESCRIPT
fi

# --- Мониторинг системы ------------------------------------------------------

# Открывать главное окно сразу при запуске «Мониторинга системы».
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Иконка в Dock показывает график загрузки CPU (5 = CPU History).
defaults write com.apple.ActivityMonitor IconType -int 5

# Показывать все процессы, а не только свои (0 = All Processes).
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Сортировать по использованию CPU, по убыванию.
defaults write com.apple.ActivityMonitor SortColumn -string 'CPUUsage'
defaults write com.apple.ActivityMonitor SortDirection -int 0

# --- App Store ---------------------------------------------------------------

# Не показывать всплывающие просьбы оценить приложение.
defaults write com.apple.appstore InAppReviewEnabled -int 0

# --- Опционально ------------------------------------------------------------

# Меню «Разработка» в Safari:
# defaults write com.apple.Safari IncludeDevelopMenu -bool true

# Автопроверка обновлений macOS:
# defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
# defaults write com.apple.SoftwareUpdate AutomaticDownload -bool true

# Не предлагать делать Time Machine-бэкап на каждый новый внешний диск:
# defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
