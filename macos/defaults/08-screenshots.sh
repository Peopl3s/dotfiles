#!/usr/bin/env bash
#
# Скриншоты.
#
# На этом Mac для скриншотов стоит Shottr (ставится из Brewfile),
# поэтому встроенный инструмент оставлен с заводскими настройками.
# Блок ниже их фиксирует явно, чтобы состояние было воспроизводимым.
#
set -euo pipefail

echo '→ Скриншоты'

# Куда сохранять. Папка должна существовать, иначе macOS молча вернётся на Рабочий стол.
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Формат файла: png. Другие варианты: jpg, pdf, tiff, heic.
defaults write com.apple.screencapture type -string 'png'

# Тень вокруг снимка окна — оставить.
defaults write com.apple.screencapture disable-shadow -bool false

# Дата и время в имени файла.
defaults write com.apple.screencapture include-date -bool true

# Плавающая миниатюра в углу экрана после снимка.
defaults write com.apple.screencapture show-thumbnail -bool true

# --- Опционально ------------------------------------------------------------

# Складывать скриншоты в отдельную папку, чтобы не засорять Рабочий стол:
# mkdir -p "${HOME}/Pictures/Screenshots"
# defaults write com.apple.screencapture location -string "${HOME}/Pictures/Screenshots"

# Сменить префикс имени файла («Снимок экрана» → «screenshot»):
# defaults write com.apple.screencapture name -string 'screenshot'
