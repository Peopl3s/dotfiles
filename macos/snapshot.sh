#!/usr/bin/env bash
#
# Показывает текущие значения всех настроек, которыми управляет этот репозиторий.
#
# Зачем: покрутил что-то в «Системных настройках» — запусти снимок,
# сравни с macos/defaults/*.sh и перенеси изменившееся в скрипты.
#
# Запуск:
#   bash ~/Desktop/dotfiles/macos/snapshot.sh
#   bash ~/Desktop/dotfiles/macos/snapshot.sh > /tmp/snapshot.txt
#
set -uo pipefail

# Печатает «домен ключ = значение» или «<не задано>», если ключа нет.
show () {
  local domain="$1" key="$2" value
  value="$(defaults read "$domain" "$key" 2>/dev/null)" || value='<не задано>'
  printf '  %-48s = %s\n' "$key" "$value"
}

echo '=== Общие (NSGlobalDomain) ==='
for key in \
  AppleInterfaceStyle AppleLanguages AppleLocale AppleShowAllExtensions \
  AppleShowScrollBars AppleMeasurementUnits AppleTemperatureUnit \
  NSAutomaticSpellingCorrectionEnabled NSAutomaticCapitalizationEnabled \
  NSAutomaticPeriodSubstitutionEnabled NSAutomaticQuoteSubstitutionEnabled \
  NSAutomaticDashSubstitutionEnabled KeyRepeat InitialKeyRepeat \
  AppleKeyboardUIMode com.apple.mouse.scaling com.apple.trackpad.scaling \
  com.apple.swipescrolldirection com.apple.springing.enabled \
  com.apple.springing.delay com.apple.trackpad.forceClick; do
  show NSGlobalDomain "$key"
done

echo
echo '=== Dock ==='
for key in \
  tilesize magnification largesize autohide orientation mineffect \
  minimize-to-application show-process-indicators show-recents launchanim \
  wvous-tl-corner wvous-tr-corner wvous-bl-corner wvous-br-corner; do
  show com.apple.dock "$key"
done

echo
echo '=== Finder ==='
for key in \
  ShowPathbar ShowStatusBar ShowSidebar FXPreferredViewStyle \
  _FXSortFoldersFirst AppleShowAllFiles NewWindowTarget \
  ShowHardDrivesOnDesktop ShowExternalHardDrivesOnDesktop \
  ShowRemovableMediaOnDesktop ShowMountedServersOnDesktop; do
  show com.apple.finder "$key"
done

echo
echo '=== Трекпад (встроенный) ==='
defaults read com.apple.AppleMultitouchTrackpad 2>/dev/null | sed 's/^/  /'

echo
echo '=== Мышь ==='
defaults read com.apple.AppleMultitouchMouse 2>/dev/null | sed 's/^/  /'

echo
echo '=== Строка меню: часы ==='
defaults read com.apple.menuextra.clock 2>/dev/null | sed 's/^/  /'

echo
echo '=== Скриншоты ==='
for key in location type disable-shadow include-date show-thumbnail name; do
  show com.apple.screencapture "$key"
done

echo
echo '=== Яркость и экран ==='
printf '  %-48s = %s\n' 'яркость (0…1)' \
  "$(command -v brightness >/dev/null 2>&1 && brightness -l 2>/dev/null \
      | awk -F': ' '/brightness/ {print $2; exit}' || echo '<нет утилиты brightness>')"
system_profiler SPDisplaysDataType 2>/dev/null \
  | grep -E 'Resolution|Automatically Adjust Brightness' | sed 's/^ */  /'

echo
echo '=== Энергосбережение (pmset) ==='
pmset -g custom | sed 's/^/  /'

echo
echo '=== Homebrew ==='
echo '  Чтобы обновить macos/Brewfile текущим списком пакетов:'
echo '  brew bundle dump --force --file=~/Desktop/dotfiles/macos/Brewfile'
