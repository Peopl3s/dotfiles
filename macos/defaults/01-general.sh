#!/usr/bin/env bash
#
# Общий вид системы: тема, язык, анимации, диалоги сохранения.
# Снято с MacBook Pro 16" (Mac16,7, M4 Pro), macOS 26.7.
#
set -euo pipefail

echo '→ Общие настройки системы'

# --- Внешний вид -------------------------------------------------------------

# Тёмная тема оформления. Чтобы вернуть светлую — `defaults delete NSGlobalDomain AppleInterfaceStyle`.
defaults write NSGlobalDomain AppleInterfaceStyle -string 'Dark'

# Не переключать тему автоматически по времени суток (всегда тёмная).
defaults write NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically -bool false

# Полосы прокрутки показываются только в момент скролла (а не всегда).
defaults write NSGlobalDomain AppleShowScrollBars -string 'WhenScrolling'

# Клик по пустому месту полосы прокрутки — прыжок на страницу, а не в точку клика.
defaults write NSGlobalDomain AppleScrollerPagingBehavior -bool false

# --- Язык и регион -----------------------------------------------------------

# Язык интерфейса: русский. Порядок в массиве = приоритет языков.
defaults write NSGlobalDomain AppleLanguages -array 'ru-RU'

# Регион: Россия. Влияет на формат дат, чисел, первый день недели.
defaults write NSGlobalDomain AppleLocale -string 'ru_RU'

# Метрическая система мер и сантиметры в линейках.
defaults write NSGlobalDomain AppleMeasurementUnits -string 'Centimeters'
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Температура в градусах Цельсия.
defaults write NSGlobalDomain AppleTemperatureUnit -string 'Celsius'

# --- Диалоги и окна ----------------------------------------------------------

# Диалог «Сохранить как…» всегда в развёрнутом виде (видно дерево папок).
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Диалог печати тоже всегда развёрнут.
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Новые документы сохраняются на диск, а не в iCloud Drive.
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# --- Опционально (раскомментируй, если захочешь) -----------------------------

# Отключить «резиновую» инерцию при прокрутке до края страницы:
# defaults write NSGlobalDomain NSScrollViewRubberbanding -int 0

# Ускорить анимацию изменения размера окон (0.2 → 0.001 секунды):
# defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Полностью отключить анимацию открытия окон:
# defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Убрать звук при загрузке Mac (нужен sudo и перезагрузка):
# sudo nvram StartupMute=%01
