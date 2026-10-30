#!/usr/bin/env bash
#
# Dock, Mission Control и активные углы экрана.
#
set -euo pipefail

echo '→ Dock и Mission Control'

# --- Размер и поведение Dock -------------------------------------------------

# Размер иконок в Dock в точках. Сейчас 63 (ползунок примерно посередине).
defaults write com.apple.dock tilesize -int 63

# Увеличение иконки под курсором выключено.
defaults write com.apple.dock magnification -bool false

# Размер увеличенной иконки. Работает только когда magnification = true.
defaults write com.apple.dock largesize -int 16

# Dock всегда на экране (не прячется автоматически).
defaults write com.apple.dock autohide -bool false

# Dock снизу экрана. Варианты: left / bottom / right.
defaults write com.apple.dock orientation -string 'bottom'

# Эффект сворачивания окна: genie (джинн). Варианты: genie / scale / suck.
defaults write com.apple.dock mineffect -string 'genie'

# Свёрнутые окна прячутся в иконку своего приложения, а не висят отдельно справа.
defaults write com.apple.dock minimize-to-application -bool true

# Точка-индикатор под иконками запущенных приложений.
defaults write com.apple.dock show-process-indicators -bool true

# Не показывать секцию «Недавние» в конце Dock.
defaults write com.apple.dock show-recents -bool false

# Анимация «подпрыгивания» иконки при запуске приложения включена.
defaults write com.apple.dock launchanim -bool true

# --- Активные углы экрана (Hot Corners) --------------------------------------
#
# Коды действий:
#   0  — ничего          2  — Mission Control    3  — Окна программы
#   4  — Рабочий стол    5  — Экранная заставка  6  — Выключить заставку
#   7  — Dashboard      10  — Перевести в сон   11  — Launchpad
#  12  — Центр уведомлений                      13  — Заблокировать экран
#  14  — Быстрая заметка
#
# Второй ключ `-modifier` — какие клавиши надо удерживать (0 = без модификаторов).

# Левый верхний угол — ничего.
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0

# Правый верхний угол — ничего.
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0

# Левый нижний угол — ничего.
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0

# Правый нижний угол — Быстрая заметка (так настроено сейчас, это дефолт macOS).
defaults write com.apple.dock wvous-br-corner -int 14
defaults write com.apple.dock wvous-br-modifier -int 0

# --- Опционально ------------------------------------------------------------

# Показывать Dock мгновенно, без задержки (полезно при autohide = true):
# defaults write com.apple.dock autohide-delay -float 0

# Ускорить анимацию появления Dock:
# defaults write com.apple.dock autohide-time-modifier -float 0.15

# Запретить менять размер Dock мышкой (чтобы случайно не сбить):
# defaults write com.apple.dock size-immutable -bool true

# Не переупорядочивать рабочие столы по частоте использования:
# defaults write com.apple.dock mru-spaces -bool false

# Группировать окна по приложениям в Mission Control:
# defaults write com.apple.dock expose-group-apps -bool true
