#!/usr/bin/env bash
#
# Общие функции для шагов установки. Подключается через `source`.
#
# Весь смысл репозитория в симлинках: файл физически лежит здесь,
# а в домашней папке на него стоит ссылка. Правишь файл в репозитории —
# изменение сразу видно системе, копировать ничего не надо.
#

# Корень репозитория (папка на уровень выше steps/).
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export DOTFILES

# Куда складывать оригиналы заменяемых файлов.
BACKUP_DIR="${BACKUP_DIR:-$DOTFILES/backup/$(date +%Y-%m-%d_%H-%M-%S)}"
export BACKUP_DIR

# link <файл в репозитории> <куда поставить ссылку>
#
# Пример: link config/zshrc "$HOME/.zshrc"
link () {
  local source_path="$DOTFILES/$1"
  local target_path="$2"

  # Если исходника нет — это опечатка в вызове, лучше сказать громко.
  if [ ! -e "$source_path" ]; then
    echo "  ПРОПУСК: в репозитории нет $1" >&2
    return 0
  fi

  # Создаём родительскую папку цели (например ~/.config/htop).
  mkdir -p "$(dirname "$target_path")"

  # Ссылка уже стоит и ведёт куда надо — ничего не делаем.
  if [ -L "$target_path" ] && [ "$(readlink "$target_path")" = "$source_path" ]; then
    echo "  уже на месте: $target_path"
    return 0
  fi

  # На месте лежит настоящий файл (не наша ссылка) — сначала копируем его в backup/.
  if [ -e "$target_path" ] && [ ! -L "$target_path" ]; then
    mkdir -p "$BACKUP_DIR"
    cp -R "$target_path" "$BACKUP_DIR/"
    echo "  сохранил старый файл: $BACKUP_DIR/$(basename "$target_path")"
  fi

  # Удаляем то, что было (файл, папку или чужую ссылку), и ставим свою.
  rm -rf "$target_path"
  ln -s "$source_path" "$target_path"
  echo "  ссылка: $target_path → $1"
}

# Убирает из домашней папки «битые» симлинки, ведущие в этот репозиторий.
# Нужно, если файл из репозитория удалили или переименовали.
clean_broken_links () {
  local dir="$1" entry
  for entry in "$dir"/.??* "$dir"/*; do
    # -L: это симлинк; ! -e: цель не существует.
    if [ -L "$entry" ] && [ ! -e "$entry" ]; then
      case "$(readlink "$entry")" in
        "$DOTFILES"/*)
          echo "  убрал битую ссылку: $entry"
          rm -f "$entry"
          ;;
      esac
    fi
  done
}
