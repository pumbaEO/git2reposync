# Подробное описание использования команды <sync>

sync (синоним s) - Выполняет синхронизацию хранилища 1С с git-репозиторием

> Подробную справку по опциям и аргументам см. `git2reposync sync --help`

### Справка по использованию команды:
```
Команда: sync, s
 Выполняет синхронизацию хранилища 1С с git-репозиторием

Строка запуска: git2reposync sync [ОПЦИИ] PATH [WORKDIR]

Аргументы:
  PATH          Путь к хранилищу конфигурации 1С. (env $git2reposync_STORAGE_PATH)
  WORKDIR       Каталог исходников внутри локальной копии git-репозитория. (env $git2reposync_WORKDIR)

Опции:
  -u, --storage-user    пользователь хранилища конфигурации (env $git2reposync_STORAGE_USER) (по умолчанию Администратор)
  -p, --storage-pwd     пароль пользователя хранилища конфигурации (env $git2reposync_STORAGE_PASSWORD, $git2reposync_STORAGE_PWD)

```
### Глобальные переменные окружения
| Имя                 | Описание                                               |
|---------------------|--------------------------------------------------------|
| `git2reposync_V8VERSION` | маска версии платформы (8.3, 8.3.5, 8.3.6.2299 и т.п.) |
| `git2reposync_VERBOSE`   | вывод отладочной информации в процессе выполнения      |
| `git2reposync_TEMP`      | путь к каталогу временных файлов                       |
| `git2reposync_EMAIL`     | домен почты для пользователей git                      |

### Переменные окружения команды

| Имя                        | Описание                                   |
|----------------------------|--------------------------------------------|
| `git2reposync_WORKDIR`          | рабочий каталог для команды                |
| `git2reposync_STORAGE_PATH`     | путь к хранилищу конфигурации 1С.          |
| `git2reposync_STORAGE_USER`     | пользователь хранилища конфигурации        |
| `git2reposync_STORAGE_PASSWORD` | пароль пользователя хранилища конфигурации |

### Значения по умолчанию

|                    |                              |
|--------------------|------------------------------|
| WORKDIR            | текущая рабочая директория   |
| -u, --storage-user | пользователь `Администратор` |

## Примеры, использования

* Простое использование

    `git2reposync sync C:/Хранилище_1С/ C:/GIT/src`

    Данная команда выполнить синхронизацию хранилища 1С по пути `C:/Хранилище_1С/` и репозитория git в каталоге `C:/GIT/src`

* Инициализация в текущем рабочем каталоге,

    > переменная окружения **`git2reposync_WORKDIR`** не должна быть задана

    ```sh
    cd C:/work_dir/
    git2reposync sync C:/Хранилище_1С/
    ```
    Данная команда выполнить синхронизацию хранилища 1С по пути `C:/Хранилище_1С/` и репозитория git в каталоге `C:/work_dir`

* Инициализация в с указанием пользователя и пароля.

    ```sh
    git2reposync sync --storage-user Admin --storage-pwd=Secret C:/Хранилище_1С/ C:/work_dir/
    ```
    Данная команда выполнить синхронизацию хранилища 1С по пути `C:/Хранилище_1С/` и репозитория git в каталоге `C:/work_dir`
    Используя для подключения к хранилищу 1С пользователя `Admin` и пароль `Secret`

* Использование синонимов (короткая версия предыдущего примера)

    ```sh
    git2reposync s -uAdmin -p=Secret C:/Хранилище_1С/ C:/work_dir/
    ```
    Данная команда выполнить синхронизацию хранилища 1С по пути `C:/Хранилище_1С/` и репозитория git в каталоге `C:/work_dir`
    Используя для подключения к хранилищу 1С пользователя `Admin` и пароль `Secret`

* Использование только переменных окружения

    linux:
    ```sh
    export git2reposync_WORKDIR=./work_dir/
    export git2reposync_STORAGE_PATH=./Хранилище_1С/

    export git2reposync_STORAGE_USER=Admin
    export git2reposync_STORAGE_PASSWORD=Secret
    export git2reposync_V8VERSION=8.3.7
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
    set git2reposync_VERBOSE=true #Можно использовать Да/Ложь/Нет/Истина
    set git2reposync_TEMP=./temp/sync

    git2reposync s
    ```
    Данная команда выполнить синхронизацию хранилища 1С по пути `C:/Хранилище_1С/` и репозитория git в каталоге `C:/work_dir`
    Используя для подключения к хранилищу 1С пользователя `Admin` и пароль `Secret`
