#!/usr/bin/env bash
#
# Экран, яркость и энергосбережение.
#
# Снято с MacBook Pro 16" (Liquid Retina XDR, 3456 × 2234).
#
# Важно: часть команд требует sudo — скрипт спросит пароль.
#
set -euo pipefail

echo '→ Экран и энергосбережение'

# --- Яркость экрана ----------------------------------------------------------

# Яркость не хранится в `defaults`, поэтому ставим её утилитой `brightness`
# (ставится из Brewfile). Значение — доля от максимума: 0.0 … 1.0.
# Сейчас на этом Mac примерно 0.5 (32768 из 65536 по данным ioreg).
if command -v brightness >/dev/null 2>&1; then
  brightness 0.5
else
  echo '  brightness не установлен — пропускаю (brew install brightness)'
fi

# Автояркость по датчику освещённости ВЫКЛЮЧЕНА.
# Это системный файл, поэтому нужен sudo.
sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor \
  'Automatic Display Enabled' -bool false

# --- Сон экрана и диска ------------------------------------------------------
# Всё, что ниже, — утилита pmset. Время указывается в минутах, 0 = никогда.
# Флаг -a применяет настройку ко всем источникам питания,
# -b только к батарее, -c только к сети.

# Гасить экран после 20 минут бездействия (и от сети, и от батареи).
sudo pmset -a displaysleep 20

# Останавливать диски после 10 минут простоя.
sudo pmset -a disksleep 10

# Разрешить Mac уходить в сон.
sudo pmset -a sleep 1

# Power Nap: проверять почту и обновления, пока Mac спит.
sudo pmset -a powernap 1

# Standby: глубокий сон с записью памяти на диск через несколько часов.
sudo pmset -a standby 1

# Режим гибернации 3 = память остаётся под питанием + копия на диск
# (стандарт для ноутбуков, защищает от разряда во сне).
sudo pmset -a hibernatemode 3

# Держать сетевые соединения живыми во сне (нужно для Handoff, Find My, SSH).
sudo pmset -a tcpkeepalive 1

# Не усыплять Mac, пока активна сессия в терминале (ssh, долгий билд).
sudo pmset -a ttyskeepawake 1

# Режим энергопотребления: 0 — автоматический.
# 1 — низкое потребление, 2 — максимальная производительность.
sudo pmset -a powermode 0

# Не затемнять экран автоматически при работе от батареи.
sudo pmset -b lessbright 0

# Пробуждение по сети (Wake on LAN): от сети — да, от батареи — нет.
sudo pmset -c womp 1
sudo pmset -b womp 0

# --- Опционально ------------------------------------------------------------

# Требовать пароль сразу после ухода в заставку или сон:
# defaults write com.apple.screensaver askForPassword -int 1
# defaults write com.apple.screensaver askForPasswordDelay -int 0

# Запускать заставку через 10 минут (600 секунд), 0 = никогда:
# defaults -currentHost write com.apple.screensaver idleTime -int 600

# Night Shift / True Tone через defaults не настраиваются надёжно —
# их проще включить в «Системные настройки → Мониторы».
