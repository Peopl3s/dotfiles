#!/usr/bin/env bash
#
# Шаг 1: терминал, shell и git.
#
# Можно запускать отдельно:
#   bash ~/Desktop/dotfiles/steps/01-terminal.sh
#
set -euo pipefail

# shellcheck source=steps/_helpers.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_helpers.sh"

echo '→ Шаг 1: терминал, shell, git'

# Сначала подчищаем ссылки, ведущие в никуда.
clean_broken_links "$HOME"

# Папка с модулями шелла: ~/.shell/.aliases, ~/.shell/.exports, ~/.shell/.functions.
link shell "$HOME/.shell"

# Загрузочные файлы zsh.
# .zprofile читается один раз при входе в систему (PATH, brew, nvm, pyenv).
link config/zprofile "$HOME/.zprofile"
# .zshrc читается при каждом запуске терминала (алиасы, функции, автодополнение).
link config/zshrc "$HOME/.zshrc"

# Git: имя, почта, алиасы.
link config/gitconfig "$HOME/.gitconfig"
# Глобальный .gitignore, подключён через core.excludesFile.
link config/gitignore "$HOME/.gitignore_global"

# htop: набор колонок и внешний вид.
link config/htoprc "$HOME/.config/htop/htoprc"
