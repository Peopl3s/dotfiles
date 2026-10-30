#!/usr/bin/env bash
#
# Клавиатура, раскладки и автоматическая правка текста.
#
set -euo pipefail

echo '→ Клавиатура и текст'

# --- Автозамена при наборе ---------------------------------------------------

# Автоисправление орфографии ВЫКЛЮЧЕНО (сильно мешает в коде и терминале).
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Автоматическая заглавная буква в начале предложения — включена.
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool true

# Двойной пробел ставит точку — включено.
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool true

# «Умные» кавычки — включены (дефолт macOS).
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool true

# «Умные» тире (-- превращается в —) — включены (дефолт macOS).
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool true

# --- Раскладки клавиатуры ----------------------------------------------------
#
# Сейчас включены две раскладки: ABC (английская) и RussianWin (русская,
# как в Windows — с точкой/запятой на той же клавише).
# Применяется после перезахода в учётную запись.

defaults write com.apple.HIToolbox AppleEnabledInputSources -array \
  '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>252</integer><key>KeyboardLayout Name</key><string>ABC</string></dict>' \
  '<dict><key>Bundle ID</key><string>com.apple.CharacterPaletteIM</string><key>InputSourceKind</key><string>Non Keyboard Input Method</string></dict>' \
  '<dict><key>Bundle ID</key><string>com.apple.PressAndHold</string><key>InputSourceKind</key><string>Non Keyboard Input Method</string></dict>' \
  '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>19458</integer><key>KeyboardLayout Name</key><string>RussianWin</string></dict>'

# Показывать флажок текущей раскладки в строке меню.
defaults write com.apple.TextInputMenu visible -bool true

# --- Опционально ------------------------------------------------------------

# Быстрый автоповтор символа при зажатой клавише.
# KeyRepeat — пауза между повторами (меньше = быстрее, минимум 1 ≈ 15 мс),
# InitialKeyRepeat — задержка до начала повтора (минимум 10 ≈ 150 мс).
# Сейчас стоят системные значения, но для кода удобнее раскомментировать:
# defaults write NSGlobalDomain KeyRepeat -int 2
# defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Отключить всплывашку с диакритикой при зажатии клавиши (нужно для повтора выше):
# defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Tab переключает фокус между ВСЕМИ элементами окна, включая кнопки диалогов:
# defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Клавиша Fn: 0 — ничего, 1 — смена языка, 2 — эмодзи, 3 — диктовка:
# defaults write com.apple.HIToolbox AppleFnUsageType -int 0

# F1…F12 работают как обычные функциональные клавиши, а не как яркость/звук:
# defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true
