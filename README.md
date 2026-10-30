# dotfiles

Настройки macOS и рабочего окружения одной командой.

Снято с **MacBook Pro 16" (Mac16,7, Apple M4 Pro, 24 ГБ), macOS 26.7**.
Сделано по образцу [kondratevdev/dotfiles](https://github.com/kondratevdev/dotfiles).

В каждом файле у каждой строки есть комментарий — что она делает и какое значение
стоит сейчас. Блоки `# --- Опционально ---` выключены: это полезные твики,
которые на этой машине не применены.

## Что ставится

| Что | Где описано |
| --- | --- |
| Пакеты, приложения, App Store, npm, uv | [`macos/Brewfile`](macos/Brewfile) |
| Настройки системы (Dock, Finder, трекпад, яркость, энергия) | [`macos/defaults/`](macos/defaults) |
| zsh, git, htop | [`config/`](config) |
| Алиасы, функции, переменные окружения | [`shell/`](shell) |
| Настройки и расширения Cursor | [`cursor/`](cursor) |
| Настройки и расширения VS Code | [`vscode/`](vscode) |

## Установка на чистый Mac

```bash
# 1. Homebrew (если ещё нет)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Репозиторий
git clone git@github.com:Peopl3s/dotfiles.git ~/Desktop/dotfiles

# 3. Конфиги, пакеты, приложения
bash ~/Desktop/dotfiles/install.sh

# 4. Настройки самой системы (спросит пароль — нужен sudo для pmset)
bash ~/Desktop/dotfiles/macos/settings.sh
```

После шага 4 перезайди в учётную запись: раскладки клавиатуры, язык и регион
применяются только при новом входе.

> **Если запускаешь на этом же Mac, а не на чистом.** Часть программ из
> `macos/Brewfile` (Chrome, Cursor, Postman, PyCharm, Telegram и другие) была
> поставлена руками, мимо Homebrew. `brew bundle` на них ругнётся
> «It seems there is already an App at …». Это не ошибка установки — либо
> пропусти их, либо один раз передай управление brew:
> `brew install --cask --force google-chrome`.

## Как это работает

Всё держится на симлинках: файл физически лежит в репозитории, а в домашней
папке на него стоит ссылка. Правишь `config/zshrc` — изменение сразу действует
в системе, потому что `~/.zshrc` это ссылка, а не копия.

Перед заменой настоящего файла `install.sh` кладёт его копию в `backup/<дата>/`.

`install.sh` по очереди выполняет скрипты из `steps/`:

| Шаг | Что делает |
| --- | --- |
| [`steps/01-terminal.sh`](steps/01-terminal.sh) | Ссылки на zsh, git, htop и папку `shell/` |
| [`steps/02-dependencies.sh`](steps/02-dependencies.sh) | `brew bundle` по Brewfile и установка nvm |
| [`steps/03-editors.sh`](steps/03-editors.sh) | Настройки и расширения Cursor и VS Code |

Общие функции (`link`, уборка битых ссылок) лежат в
[`steps/_helpers.sh`](steps/_helpers.sh). Любой шаг запускается и отдельно:

```bash
bash ~/Desktop/dotfiles/steps/01-terminal.sh
```

> Оригинальный репозиторий раскладывает ссылки через
> [dotbot](https://github.com/anishathalye/dotbot) и описывает их в YAML.
> Здесь ссылок всего семь, поэтому вместо сабмодуля с внешней утилитой —
> полсотни строк обычного bash, где видно каждое действие. Если захочешь
> вернуться к dotbot, замени `steps/*.sh` на `steps/*.yml` — остальная
> структура репозитория совпадает.

## Настройки macOS

`macos/settings.sh` по очереди выполняет всё из `macos/defaults/`:

| Файл | О чём |
| --- | --- |
| `01-general.sh` | Тёмная тема, русская локаль, диалоги сохранения |
| `02-dock.sh` | Размер Dock, эффекты, активные углы экрана |
| `03-finder.sh` | Вид списком, панель пути, что видно на рабочем столе |
| `04-keyboard.sh` | Раскладки ABC + RussianWin, автозамена текста |
| `05-trackpad-mouse.sh` | Касание = клик, жесты, скорость курсора, Magic Mouse |
| `06-display-energy.sh` | Яркость 50%, автояркость выкл., сон экрана через 20 мин |
| `07-menubar.sh` | Часы, значки в строке меню и Пункте управления |
| `08-screenshots.sh` | Формат, папка и миниатюра скриншотов |
| `09-apps.sh` | Chrome по умолчанию, автозагрузка Shottr, Мониторинг системы |

Любой блок можно применить отдельно:

```bash
bash ~/Desktop/dotfiles/macos/defaults/02-dock.sh
```

## Как обновлять репозиторий под себя

Покрутил что-то в «Системных настройках» — сними текущее состояние и перенеси
изменившееся в скрипты:

```bash
bash ~/Desktop/dotfiles/macos/snapshot.sh
```

Поставил новую программу через brew:

```bash
brew bundle dump --force --file=~/Desktop/dotfiles/macos/Brewfile
```

> `dump` перезапишет файл и сотрёт все комментарии — сравни через `git diff`
> и верни пояснения на место.

Поставил расширение в редактор:

```bash
cursor --list-extensions > ~/Desktop/dotfiles/cursor/extensions.txt
code --list-extensions > ~/Desktop/dotfiles/vscode/extensions.txt
```

## Про настройки VS Code

`vscode/settings.json` и `vscode/keybindings.json` взяты целиком из
[sobolevn/dotfiles](https://github.com/sobolevn/dotfiles/tree/master/vscode)
(коммит `a0d77db`) — значения не менялись, добавлены только комментарии.

Подход там радикальный: скрыты строка состояния, панель значков, «хлебные
крошки» и миникарта, выключены автодополнение, автоскобки и подсказки при
наведении. Если это слишком — правь `vscode/settings.json`, у каждой строки
написано, за что она отвечает.

Настройки ссылаются на конкретные расширения и шрифт, поэтому они едут
вместе: тема `pustota`, иконки `ayu`, `custom-ui-style`, `errorlens`, Pylance
(всё в [`vscode/extensions.txt`](vscode/extensions.txt)) и шрифт Fira Code
из Brewfile. Без них редактор запустится, но будет выглядеть не так.

Свои привязки пиши в конец `vscode/keybindings.json`, в блок
«Свои привязки». VS Code читает правила сверху вниз и применяет последнее
подходящее, а выше по файлу много строк со знаком минус, которые снимают
стандартные сочетания: привязка, поставленная раньше такой строки, будет ею
же и погашена. Там уже возвращён `ctrl+shift+g` на панель Git.

Cursor — отдельная программа со своей папкой настроек, его конфиг в
[`cursor/`](cursor) и остался твоим собственным.

## Чего здесь нет

Секреты в репозиторий не попадают — они перечислены в `.gitignore`:

- `~/.ssh/` — ключи SSH
- `~/.netrc`, `~/.npmrc` — токены реестров
- `~/.env` — переменные окружения
- `~/.kube/config` — доступы к кластерам Kubernetes
- `~/.aws/`, `~/.docker/config.json` — учётные данные облаков и реестров

Храни их в менеджере паролей или в приватном репозитории.

Часть программ поставить через Homebrew нельзя — для них нет cask-а
(корпоративные VPN, ActiveCollab, Yandex.Telemost и другие). Они перечислены
отдельным блоком в конце [`macos/Brewfile`](macos/Brewfile), со ссылками, откуда
качать.

Так же не переносятся настройки, которые macOS хранит в бинарном виде и не
отдаёт через `defaults`: состав иконок в Dock, обои, Night Shift, True Tone,
Touch ID и правила Фокусирования. Их быстрее выставить руками.

## Если нужно откатить

```bash
# вернуть свои старые конфиги
ls ~/Desktop/dotfiles/backup/
cp -R ~/Desktop/dotfiles/backup/<дата>/.zshrc ~/.zshrc

# сбросить отдельную настройку системы к заводской
defaults delete com.apple.dock tilesize && killall Dock
```
