#!/usr/bin/env bash
#
# Строка меню и Пункт управления.
#
set -euo pipefail

echo '→ Строка меню'

# --- Часы --------------------------------------------------------------------

# Показывать AM/PM (в русской локали влияет на формат, если выключен 24-часовой).
defaults write com.apple.menuextra.clock ShowAMPM -bool true

# День недели — показывать.
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true

# Дату — не показывать (экономим место в строке меню рядом с «чёлкой»).
defaults write com.apple.menuextra.clock ShowDate -int 0

# Секунды — не показывать.
defaults write com.apple.menuextra.clock ShowSeconds -bool false

# Часы цифровые, а не аналоговые.
defaults write com.apple.menuextra.clock IsAnalog -bool false

# --- Значки в строке меню ----------------------------------------------------
#
# Ключи вида «NSStatusItem Visible X» управляют показом в строке меню,
# «NSStatusItem VisibleCC X» — показом внутри Пункта управления.
# Значения: 0 — скрыт, 1 — виден.

# Сам Пункт управления (BentoBox — та самая иконка с двумя тумблерами).
defaults write com.apple.controlcenter 'NSStatusItem Visible BentoBox' -int 1

# Значок «Быстрые команды универсального доступа» скрыт.
defaults write com.apple.controlcenter 'NSStatusItem Visible AccessibilityShortcuts' -int 0

# Что видно внутри самого Пункта управления.
defaults write com.apple.controlcenter 'NSStatusItem VisibleCC Battery' -int 1
defaults write com.apple.controlcenter 'NSStatusItem VisibleCC Bluetooth' -int 1
defaults write com.apple.controlcenter 'NSStatusItem VisibleCC WiFi' -int 1
defaults write com.apple.controlcenter 'NSStatusItem VisibleCC Sound' -int 1
defaults write com.apple.controlcenter 'NSStatusItem VisibleCC Clock' -int 1
defaults write com.apple.controlcenter 'NSStatusItem VisibleCC KeyboardBrightness' -int 1

# Флажок текущей раскладки клавиатуры виден (дублирует 04-keyboard.sh).
defaults write com.apple.TextInputMenu visible -bool true

# --- Опционально ------------------------------------------------------------

# Проценты заряда прямо на иконке батареи:
# defaults write com.apple.controlcenter BatteryShowPercentage -bool true

# Уплотнить значки в строке меню, чтобы больше влезало рядом с «чёлкой»:
# defaults write NSGlobalDomain NSStatusItemSpacing -int 12
# defaults write NSGlobalDomain NSStatusItemSelectionPadding -int 12

# Автоматически скрывать строку меню:
# defaults write NSGlobalDomain _HIHideMenuBar -bool true
