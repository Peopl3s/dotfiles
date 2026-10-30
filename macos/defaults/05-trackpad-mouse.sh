#!/usr/bin/env bash
#
# Трекпад, мышь и жесты.
#
# Настройки трекпада живут сразу в двух доменах:
#   com.apple.AppleMultitouchTrackpad                  — встроенный трекпад MacBook
#   com.apple.driver.AppleBluetoothMultitouch.trackpad — внешний Magic Trackpad
# Пишем в оба, чтобы поведение совпадало.
#
set -euo pipefail

echo '→ Трекпад и мышь'

TRACKPAD_DOMAINS=(
  'com.apple.AppleMultitouchTrackpad'
  'com.apple.driver.AppleBluetoothMultitouch.trackpad'
)

# Маленький помощник: пишет один и тот же ключ в оба домена трекпада.
trackpad_write () {
  local key="$1" type="$2" value="$3"
  for domain in "${TRACKPAD_DOMAINS[@]}"; do
    defaults write "$domain" "$key" "$type" "$value"
  done
}

# --- Клики трекпада ----------------------------------------------------------

# Касание = клик (не нужно продавливать трекпад).
trackpad_write Clicking -bool true

# «Перетаскивание касанием» выключено — таскаем тремя пальцами (см. ниже).
trackpad_write Dragging -bool false

# Фиксация перетаскивания (объект «прилипает» к курсору) выключена.
trackpad_write DragLock -bool false

# Усилие нажатия: 0 — лёгкое, 1 — среднее, 2 — сильное. Стоит среднее.
trackpad_write FirstClickThreshold -int 1
trackpad_write SecondClickThreshold -int 1

# Тактильная отдача (щелчок Taptic Engine) включена.
trackpad_write ActuateDetents -bool true

# Force Touch (сильное нажатие) НЕ подавлен, т.е. работает.
trackpad_write ForceSuppressed -bool false

# Глобальный флаг Force Click и «тактильной обратной связи».
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool true

# Правый клик двумя пальцами включён…
trackpad_write TrackpadRightClick -bool true

# …а правый клик по углу трекпада выключен.
trackpad_write TrackpadCornerSecondaryClick -int 0

# --- Прокрутка ---------------------------------------------------------------

# Вертикальная прокрутка двумя пальцами.
trackpad_write TrackpadScroll -bool true

# Горизонтальная прокрутка двумя пальцами.
trackpad_write TrackpadHorizScroll -bool true

# Инерция прокрутки (продолжает ехать после отрыва пальцев).
trackpad_write TrackpadMomentumScroll -bool true

# «Естественная» прокрутка: контент едет за пальцами, как на iPhone.
# Это глобальная настройка — общая для трекпада и мыши.
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

# Игнорировать случайные касания ладонью.
trackpad_write TrackpadHandResting -bool true

# --- Жесты -------------------------------------------------------------------

# Масштабирование щипком.
trackpad_write TrackpadPinch -bool true

# Поворот двумя пальцами.
trackpad_write TrackpadRotate -bool true

# Двойное касание двумя пальцами = «умное увеличение».
trackpad_write TrackpadTwoFingerDoubleTapGesture -int 1

# Свайп двумя пальцами от правого края = Центр уведомлений.
trackpad_write TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3

# Перетаскивание окон тремя пальцами (включается в Универсальном доступе).
trackpad_write TrackpadThreeFingerDrag -bool true

# Жесты тремя пальцами отключены, потому что три пальца заняты перетаскиванием.
trackpad_write TrackpadThreeFingerHorizSwipeGesture -int 0
trackpad_write TrackpadThreeFingerVertSwipeGesture -int 0
trackpad_write TrackpadThreeFingerTapGesture -int 0

# Четыре пальца: вверх — Mission Control, вниз — Окна программы,
# влево/вправо — переключение рабочих столов. 2 = жест включён.
trackpad_write TrackpadFourFingerVertSwipeGesture -int 2
trackpad_write TrackpadFourFingerHorizSwipeGesture -int 2

# Щипок четырьмя пальцами = Launchpad, разведение пяти = показать рабочий стол.
trackpad_write TrackpadFourFingerPinchGesture -int 2
trackpad_write TrackpadFiveFingerPinchGesture -int 2

# Трекпад продолжает работать, когда подключена USB-мышь.
trackpad_write USBMouseStopsTrackpad -bool false

# --- Скорость курсора --------------------------------------------------------

# Скорость мыши: 2.0 из диапазона 0…3 (ползунок чуть правее середины).
defaults write NSGlobalDomain com.apple.mouse.scaling -float 2

# Скорость трекпада не переопределена — остаётся системная.
# Чтобы задать явно (диапазон 0…3):
# defaults write NSGlobalDomain com.apple.trackpad.scaling -float 1.5

# --- Пружинящее открытие папок ----------------------------------------------

# Папка раскрывается, если подержать над ней перетаскиваемый файл.
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Задержка до раскрытия — 0.5 секунды.
defaults write NSGlobalDomain com.apple.springing.delay -float 0.5

# --- Magic Mouse -------------------------------------------------------------
# Применяется, когда подключена мышь Apple. На встроенный трекпад не влияет.

MOUSE_DOMAINS=(
  'com.apple.AppleMultitouchMouse'
  'com.apple.driver.AppleBluetoothMultitouch.mouse'
)

mouse_write () {
  local key="$1" type="$2" value="$3"
  for domain in "${MOUSE_DOMAINS[@]}"; do
    defaults write "$domain" "$key" "$type" "$value"
  done
}

# Мышь работает как двухкнопочная (есть правый клик).
mouse_write MouseButtonMode -string 'TwoButton'

# Граница между левой и правой кнопкой — 55% ширины поверхности.
mouse_write MouseButtonDivision -int 55

# Вертикальная и горизонтальная прокрутка одним пальцем.
mouse_write MouseVerticalScroll -bool true
mouse_write MouseHorizontalScroll -bool true

# Инерция прокрутки.
mouse_write MouseMomentumScroll -bool true

# Двойное касание одним пальцем — выключено.
mouse_write MouseOneFingerDoubleTapGesture -int 0

# Двойное касание двумя пальцами = Mission Control.
mouse_write MouseTwoFingerDoubleTapGesture -int 3

# Свайп двумя пальцами влево/вправо = переключение страниц/рабочих столов.
mouse_write MouseTwoFingerHorizSwipeGesture -int 2
