#!/usr/bin/env bash
#
# Шаг 3: редакторы — Cursor и VS Code.
#
# Можно запускать отдельно:
#   bash ~/Desktop/dotfiles/steps/03-editors.sh
#
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_helpers.sh"

# --- Cursor ------------------------------------------------------------------

echo '→ Шаг 3a: Cursor'

# Cursor хранит пользовательские настройки здесь (путь с пробелом — в кавычках).
CURSOR_USER="$HOME/Library/Application Support/Cursor/User"

link cursor/settings.json "$CURSOR_USER/settings.json"
link cursor/keybindings.json "$CURSOR_USER/keybindings.json"

# Расширения ставятся через CLI `cursor` — отдельным скриптом.
# `|| true` — если CLI не установлена, шаг не должен валить всю установку.
bash "$DOTFILES/cursor/install-extensions.sh" || true

# --- VS Code -----------------------------------------------------------------

echo '→ Шаг 3b: VS Code'

# У VS Code своя папка настроек, рядом с Cursor.
VSCODE_USER="$HOME/Library/Application Support/Code/User"

link vscode/settings.json "$VSCODE_USER/settings.json"
link vscode/keybindings.json "$VSCODE_USER/keybindings.json"

bash "$DOTFILES/vscode/install-extensions.sh" || true
