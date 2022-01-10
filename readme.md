# Синхронизация хранилища 1С с репозиторием git

Обсудить [![ЧАТ ДЛЯ ОБЩЕНИЯ https://gitter.im/EvilBeaver/oscript-library](https://badges.gitter.im/EvilBeaver/oscript-library.svg)](https://gitter.im/EvilBeaver/oscript-library?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![GitHub release](https://img.shields.io/github/release/pumbaEO/git2reposync.svg)](https://github.com/oscript-library/git2reposync/releases)

# Оглавление

<!-- TOC insertAnchor:true -->

- [Введение](#введение)
- [Установка](#установка)
  - [Вручную](#вручную)
  - [Через пакетный менеджер opm](#через-пакетный-менеджер-opm)
- [Требования](#требования)
- [Особенности](#особенности)
  - [Описание функциональности](#описание-функциональности)
- [Использование приложения `git2reposync`](#использование-приложения-git2reposync)
  - [Настройка плагинов синхронизации](#настройка-плагинов-синхронизации)
  - [Синхронизация](#синхронизация)
    - [Справка по использованию команды](#справка-по-использованию-команды)
    - [Глобальные переменные окружения](#глобальные-переменные-окружения)
    - [Переменные окружения команды](#переменные-окружения-команды)
    - [Значения по умолчанию](#значения-по-умолчанию)
    - [Примеры использования](#примеры-использования)
- [Использование библиотеки `git2reposync`](#использование-библиотеки-git2reposync)
- [Доработка и разработка плагинов](#доработка-и-разработка-плагинов)
- [Механизм подписок на события](#механизм-подписок-на-события)
- [Сборка проекта](#сборка-проекта)
- [Доработка](#доработка)
- [Лицензия](#лицензия)

<!-- /TOC -->

<a id="markdown-введение" name="введение"></a>

## Введение

Проект является форком проекта gitsync см. [https://github.com/oscript-library/gitsync](https://github.com/oscript-library/gitsync)
Проект _git2reposync_ представляет собой:

1. Библиотеку `git2reposync` (`src/core`) - которая реализует основные классы для синхронизации хранилища git c 1С
2. Приложение `git2reposync` (`src/cmd`) - консольное приложение на основе библиотеки `cli`

[Документация и описание публичного API библиотеки](docs/README.md)

<a id="markdown-установка" name="установка"></a>

## Установка

<a id="markdown-вручную" name="вручную"></a>

### Вручную

1. Скачать файл `git2reposync*.ospx` из раздела [releases](https://github.com/pumbaEO/git2reposync/releases)
2. Воспользоваться командой:

```
$ opm install -f <ПутьКФайлу>
```

2. Запустить командой `git2reposync`

<a id="markdown-Требования" name="Требования"></a>

## Требования

- утилита `ring` и `` - для синхронизации с edt проектами

<a id="markdown-особенности" name="особенности"></a>

## Особенности

- обходит коммиты для синхронизации в обратном, т.е. хронологическом порядке, если указываем sha комитов списком abc1234..cbc56778,
  то первым коммитом для синхронизации из полученного диапазона будет cbc56778
- при синхронизации ппроверяет необходимость коммита поиском ключевого слова в списке истории хранилища `git2reposha:" + shacommit`, если такая версия уже есть значит пропускаем ее
- Работа с хранилищем конфигурации реализовано на основании библиотеки `v8storage`
- Реализована поддержка работы с `http` и `tcp` хранилищами
- Расширяемость функционала за счет использования механизма подписок на события

<a id="markdown-описание-функциональности" name="описание-функциональности"></a>

### Описание функциональности

> Раздел документации в разработке

<!-- TODO: Сделать описание функциональности -->

<a id="markdown-использование-приложения-git2reposync" name="использование-приложения-git2reposync"></a>

## Использование приложения `git2reposync`

<a id="markdown-подготовка-нового-репозитория" name="подготовка-нового-репозитория"></a>

### Настройка плагинов синхронизации

> Данный пункт можно пропустить, если Вам не требуется дополнительная функциональность синхронизации

Для расширения функциональности синхронизации предлагается механизм _плагинов_.
Данный механизм реализован через подписки на события синхронизации, с возможностью переопределения стандартной обработки.

Для обеспечения управления плагинами реализована подкоманда `plugins`, а так же ряд вложенных команд:

1. `init` - Инициализация предустановленных плагинов
1. `list` - Вывод списка плагинов
1. `enable` - Активизация установленных плагинов
1. `disable` - Деактивизация установленных плагинов
1. `install` - Установка новых плагинов
1. `clear` - Очистка установленных плагинов
1. `help` - Вывод справки по выбранным плагинам

Пример использования:

- `git2reposync plugins enable edt` - будет активирован плагин `limit`
- `git2reposync plugins list` - будет выведен список всех _активированных_ плагинов
- `git2reposync plugins list -a` - будет выведен список всех _установленных_ плагинов

Справка по команде `plugins`: `git2reposync plugins --help`

Для удобства использования команда `plugins` имеет короткое название `p`.

Больше примеров можно увидеть, использовав команду `git2reposync usage plugins`

> Для хранения установленных плагинов и списка активных плагинов используется каталог `локальных данных приложения`

Список предустановленных плагинов:

> Для инициализации предустановленных плагинов необходимо выполнить команду `git2reposync plugins init`

1. `edt` - обеспечивает поддержку сборки cf из edt конфигураций
1. `runner` - обеспечивает сборку с с помощью фреймворка vanessa-runner полезно для толстых форм.

<a id="markdown-синхронизация" name="синхронизация"></a>

### Синхронизация

Команда `sync` (синоним s) - выполняет синхронизацию хранилища 1С с git-репозиторием

> Подробную справку по опциям и аргументам см. `git2reposync sync --help`

<a id="markdown-справка-по-использованию-команды" name="справка-по-использованию-команды"></a>

#### Справка по использованию команды

```
Команда: sync, s
 Выполняет синхронизацию хранилища  git-репозиторием с 1С

Строка запуска: git2reposync sync [ОПЦИИ] PATH [WORKDIR]

Аргументы:
  PATH          Путь к хранилищу конфигурации 1С. (env $git2reposync_STORAGE_PATH)
  WORKDIR       Каталог исходников внутри локальной копии git-репозитория. (env $git2reposync_WORKDIR)

Опции:
  -u, --storage-user    пользователь хранилища конфигурации (env $git2reposync_STORAGE_USER) (по умолчанию Администратор)
  -p, --storage-pwd     пароль пользователя хранилища конфигурации (env $git2reposync_STORAGE_PASSWORD, $git2reposync_STORAGE_PWD)
  -m  --merge-file      путь к файлу mergesettings, определяющий как будет происходить сравнение объединение в 1с,
                        по умолчанию в корне проекта merge.xml, пример можно найти в .\templates\mergesettingsRecursor.xml

```

<a id="markdown-глобальные-переменные-окружения" name="глобальные-переменные-окружения"></a>

#### Глобальные переменные окружения

| Имя                      | Описание                                                                    |
| ------------------------ | --------------------------------------------------------------------------- |
| `git2reposync_V8VERSION` | маска версии платформы (8.3, 8.3.5, 8.3.6.2299 и т.п.)                      |
| `git2reposync_V8_PATH`   | путь к исполняемому файлу платформы 1С (Например, /opt/1C/v8.3/x86_64/1cv8) |
| `git2reposync_VERBOSE`   | вывод отладочной информации в процессе выполнения                           |
| `git2reposync_TEMP`      | путь к каталогу временных файлов                                            |

<a id="markdown-переменные-окружения-команды" name="переменные-окружения-команды"></a>

#### Переменные окружения команды

| Имя                             | Описание                                   |
| ------------------------------- | ------------------------------------------ |
| `git2reposync_WORKDIR`          | рабочий каталог для команды                |
| `git2reposync_STORAGE_PATH`     | путь к хранилищу конфигурации 1С.          |
| `git2reposync_STORAGE_USER`     | пользователь хранилища конфигурации        |
| `git2reposync_STORAGE_PASSWORD` | пароль пользователя хранилища конфигурации |

<a id="markdown-значения-по-умолчанию" name="значения-по-умолчанию"></a>

#### Значения по умолчанию

|                    |                              |
| ------------------ | ---------------------------- |
| WORKDIR            | текущая рабочая директория   |
| -u, --storage-user | пользователь `Администратор` |

<a id="markdown-примеры-использования" name="примеры-использования"></a>

#### Примеры использования

- Простое использование

  `git2reposync sync C:/Хранилище_1С/ C:/GIT/src`

  Данная команда выполнить синхронизацию хранилища 1С по пути `C:/Хранилище_1С/` и репозитория git в каталоге `C:/GIT/src`

- Инициализация в текущем рабочем каталоге,

  > переменная окружения **`git2reposync_WORKDIR`** не должна быть задана

  ```sh
  cd C:/work_dir/
  git2reposync sync C:/Хранилище_1С/
  ```

  Данная команда выполнить синхронизацию хранилища 1С по пути `C:/Хранилище_1С/` и репозитория git в каталоге `C:/work_dir`

- Инициализация в с указанием пользователя и пароля.

  ```sh
  git2reposync sync --storage-user Admin --storage-pwd=Secret C:/Хранилище_1С/ C:/work_dir/
  ```

  Данная команда выполнить синхронизацию хранилища 1С по пути `C:/Хранилище_1С/` и репозитория git в каталоге `C:/work_dir`
  Используя для подключения к хранилищу 1С пользователя `Admin` и пароль `Secret`

- Использование синонимов (короткая версия предыдущего примера)

  ```sh
  git2reposync s -uAdmin -p=Secret C:/Хранилище_1С/ C:/work_dir/
  ```

  Данная команда выполнить синхронизацию хранилища 1С по пути `C:/Хранилище_1С/` и репозитория git в каталоге `C:/work_dir`
  Используя для подключения к хранилищу 1С пользователя `Admin` и пароль `Secret`

- Использование конкретной исполняемого файла платформы

  ```sh
  git2reposync --v8-path /opt/1C/v8.3/x86_64/1cv8 s -uAdmin -p=Secret C:/Хранилище_1С/ C:/work_dir/
  ```

  Данная команда синхронизации выполнится с использованием исполняемого файла платформы `/opt/1C/v8.3/x86_64/1cv8` для хранилища 1С по пути `C:/Хранилище_1С/` и репозитория git в каталоге `C:/work_dir`
  Используя для подключения к хранилищу 1С пользователя `Admin` и пароль `Secret`

- Использование только переменных окружения

  linux:

  ```sh
  export git2reposync_WORKDIR=./work_dir/
  export git2reposync_STORAGE_PATH=./Хранилище_1С/

  export git2reposync_STORAGE_USER=Admin
  export git2reposync_STORAGE_PASSWORD=Secret
  export git2reposync_V8VERSION=8.3.7
  # Указание конкретного исполняемого файла платформы 1С
  #export git2reposync_V8_PATH=/opt/1C/v8.3/x86_64/1cv8 # Надо обернуть в кавычки если путь содержит пробелы
  export git2reposync_VERBOSE=true #Можно использовать Да/Ложь/Нет/Истина
  export git2reposync_TEMP=./temp/sync
  git2reposync s
  ```

  windows:

  ```cmd
  set git2reposync_WORKDIR=./work_dir/
  set git2reposync_STORAGE_PATH=./Хранилище_1С/

  set git2reposync_STORAGE_USER=Admin
  set git2reposync_STORAGE_PASSWORD=Secret
  set git2reposync_V8VERSION=8.3.7
  # Указание конкретного исполняемого файла платформы 1С
  #set git2reposync_V8_PATH="C:\Program Files (x86)\1cv8\8.3.12.1567\bin\1cv8.exe" # Надо обернуть в кавычки если путь содержит пробелы
  set git2reposync_VERBOSE=true #Можно использовать Да/Ложь/Нет/Истина
  set git2reposync_TEMP=./temp/sync

  git2reposync s
  ```

  Данная команда выполнить синхронизацию хранилища 1С по пути `C:/Хранилище_1С/` и репозитория git в каталоге `C:/work_dir`
  Используя для подключения к хранилищу 1С пользователя `Admin` и пароль `Secret`

<a id="markdown-использование-библиотеки-git2reposync" name="использование-библиотеки-git2reposync"></a>

## Использование библиотеки `git2reposync`

> Раздел документации в разработке

<!-- TODO: Сделать описание функциональности -->

<a id="markdown-доработка-и-разработка-плагинов" name="доработка-и-разработка-плагинов"></a>

## Доработка и разработка плагинов

Как разработать свой или доработать текущие плагины

1. [Как создать свой плагин](./create-new-plugin.md)
1. Доработка предустановленных плагинов производится в отдельном репозитории [git2reposync-plugins](https://github.com/pumbaEO/git2reposync-plugins)

<a id="markdown-механизм-подписок-на-события" name="механизм-подписок-на-события"></a>

## Механизм подписок на события

> Раздел документации в разработке

Проект `git2reposync` поддерживает ряд подписок на события

<!-- TODO: Сделать описание функциональности -->

<a id="markdown-сборка-проекта" name="сборка-проекта"></a>

## Сборка проекта

Сборка производится в 2-х режимах:

1. Сборка обычного пакета (без зависимостей)

   `opm build .`

   > при данной сборки не собираются предустановленные пакеты. Их надо будет устанавливать отдельно

2. Сборка пакета с зависимостями

   `opm build -mf ./build_packagedef .`

   При данной сборке будут дополнительно собраны из репозиториев:

   - `opm` - из ветки develop
   - `git2reposync-pre-plugins` - из вертки develop

<a id="markdown-доработка" name="доработка"></a>

## Доработка

Доработка проводится по git-flow. Жду ваших PR.

<a id="markdown-лицензия" name="лицензия"></a>

## Лицензия

Смотри файл [`LICENSE`](./LICENSE).
