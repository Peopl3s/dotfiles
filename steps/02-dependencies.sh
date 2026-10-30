#!/usr/bin/env bash
#
# Шаг 2: пакеты, приложения и менеджеры версий.
#
# Можно запускать отдельно:
#   bash ~/Desktop/dotfiles/steps/02-dependencies.sh
#
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_helpers.sh"

echo '→ Шаг 2: пакеты и приложения'

# Homebrew ставит всё из Brewfile: формулы, cask-приложения,
# программы из App Store (через mas), глобальные пакеты npm и uv.
# --no-upgrade — не трогать то, что уже установлено.
brew bundle --no-upgrade --file="$DOTFILES/macos/Brewfile"

# nvm ставим не через brew: brew-версия конфликтует с `nvm use`
# и автоподстановкой версии из .nvmrc. Официальный установщик надёжнее.
if [ ! -d "$HOME/.nvm" ]; then
  echo '  ставлю nvm'
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
else
  echo '  nvm уже установлен'
fi
