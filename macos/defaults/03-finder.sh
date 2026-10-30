#!/usr/bin/env bash
#
# Finder и рабочий стол.
#
set -euo pipefail

echo '→ Finder'

# --- Панели в окне Finder ----------------------------------------------------

# Нижняя строка с путём до текущей папки («хлебные крошки»).
defaults write com.apple.finder ShowPathbar -bool true

# Строка состояния внизу: сколько объектов и свободного места.
defaults write com.apple.finder ShowStatusBar -bool true

# Боковая панель с «Избранным», дисками и тегами.
defaults write com.apple.finder ShowSidebar -bool true

# --- Вид и сортировка --------------------------------------------------------

# Вид по умолчанию — «Список». Коды: icnv = значки, Nlsv = список,
# clmv = колонки, glyv = Cover Flow / галерея.
defaults write com.apple.finder FXPreferredViewStyle -string 'Nlsv'

# При сортировке по имени папки всегда идут выше файлов.
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Всегда показывать расширения файлов (.txt, .py и т.д.).
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Новое окно Finder открывается в «Последних» (PfAF = All My Files / Recents).
# Другие варианты: PfHm — домашняя папка, PfDe — Рабочий стол, PfLo — своя папка.
defaults write com.apple.finder NewWindowTarget -string 'PfAF'

# --- Что видно на рабочем столе ----------------------------------------------

# Внутренний диск Macintosh HD на рабочем столе НЕ показывать.
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false

# Внешние диски — показывать.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

# Флешки и CD/DVD — показывать.
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Подключённые сетевые диски — не показывать (текущее поведение по умолчанию).
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false

# --- Опционально ------------------------------------------------------------

# Показывать скрытые файлы (точки) прямо в Finder.
# То же самое делает горячая клавиша ⌘ + ⇧ + . — поэтому тут выключено:
# defaults write com.apple.finder AppleShowAllFiles -bool true

# Показывать полный POSIX-путь в заголовке окна:
# defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Поиск по умолчанию — в текущей папке (SCcf), а не по всему Mac (SCev):
# defaults write com.apple.finder FXDefaultSearchScope -string 'SCcf'

# Не предупреждать при смене расширения файла:
# defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Разрешить закрывать Finder по ⌘ + Q (скроет значки с рабочего стола):
# defaults write com.apple.finder QuitMenuItem -bool true

# Не создавать .DS_Store на сетевых дисках и флешках:
# defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Снять с папки ~/Library флаг «скрытая»:
# chflags nohidden ~/Library
