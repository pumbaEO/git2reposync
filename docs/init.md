# Подробное описание использования команды <init>

init (синоним i) - инициализация нового хранилища git и наполнение его данными из хранилища 1С

> Подробную справку по опциям и аргументам см. `git2reposync init --help`

--------------
### Справка по использованию команды:
```
Команда: init, i
 Инициализация структуры нового хранилища git. Подготовка к синхронизации

Строка запуска: git2reposync init [ОПЦИИ] PATH [WORKDIR]

Аргументы:
  PATH          Путь к хранилищу конфигурации 1С. (env $git2reposync_STORAGE_PATH)
  WORKDIR       Адрес локального репозитория GIT или каталог исходников внутри локальной копии git-репозитория. По умолчанию текущий каталог (env $git2reposync_WORKDIR)

Опции:
  -u, --storage-user    пользователь хранилища конфигурации (env $git2reposync_STORAGE_USER) (по умолчанию Администратор)
  -p, --storage-pwd     пароль пользователя хранилища конфигурации (env $git2reposync_STORAGE_PASSWORD, $git2reposync_STORAGE_PWD)
```
--------------
### Глобальные переменные окружения
| Имя                 | Описание                                               |
|---------------------|--------------------------------------------------------|
| `git2reposync_V8VERSION` | маска версии платформы (8.3, 8.3.5, 8.3.6.2299 и т.п.) |
| `git2reposync_VERBOSE`   | вывод отладочной информации в процессе выполнения      |
| `git2reposync_TEMP`      | путь к каталогу временных файлов                       |
| `git2reposync_EMAIL`     | домен почты для пользователей git                      |

--------------
### Переменные окружения команды

| Имя                        | Описание                                   |
|----------------------------|--------------------------------------------|
| `git2reposync_WORKDIR`          | рабочий каталог для команды                |
| `git2reposync_STORAGE_PATH`     | путь к хранилищу конфигурации 1С.          |
| `git2reposync_STORAGE_USER`     | пользователь хранилища конфигурации        |
| `git2reposync_STORAGE_PASSWORD` | пароль пользователя хранилища конфигурации |
--------------
### Значения по умолчанию:
|                    |                              |
|--------------------|------------------------------|
| WORKDIR            | текущая рабочая директория   |
| -u, --storage-user | пользователь `Администратор` |

--------------
## Примеры, использования
***
* Простое использование

    `git2reposync init C:/Хранилище_1С/ C:/GIT/src`

    Данная команда создаст новый репозиторий git в каталоге `C:/GIT/src` из хранилища 1С по пути `C:/Хранилище_1С/`
***
* Указание конкретной версии платформы

    `git2reposync --v8version=8.3.9 init C:/Хранилище_1С/ C:/GIT/src`

    Данная команда создаст новый репозиторий git в каталоге `C:/GIT/src` из хранилища 1С по пути `C:/Хранилище_1С/`
    Для работы будет использоваться платформа 8.3.9.xxxx
***
* Указание вывода отладочных логов

    `git2reposync --verbose init C:/Хранилище_1С/ C:/GIT/src`
    или
    `git2reposync -v init C:/Хранилище_1С/ C:/GIT/src`

    Данная команда создаст новый репозиторий git в каталоге `C:/GIT/src` из хранилища 1С по пути `C:/Хранилище_1С/`
    После указания будет выводиться дополнительные отладочные логи с признаком `Отладка`
***
* Указание каталога временных файлов при работе приложения

    `git2reposync --tempdir=./temp_sync/ init C:/Хранилище_1С/ C:/GIT/src`
    или
    `git2reposync -t ./temp_sync/ init C:/Хранилище_1С/ C:/GIT/src`

    Данная команда создаст новый репозиторий git в каталоге `C:/GIT/src` из хранилища 1С по пути `C:/Хранилище_1С/`
    Для работы будет использоваться каталог временных файлов `./temp_sync/`
***
* Инициализация в текущем рабочем каталоге,

    > переменная окружения **`git2reposync_WORKDIR`** не должна быть задана

    ```sh
    cd C:/work_dir/
    git2reposync init C:/Хранилище_1С/
    ```
    Данная команда создаст новый репозиторий git в каталоге `C:/work_dir/` из хранилища 1С по пути `C:/Хранилище_1С/`
***
* Инициализация в с указанием пользователя и пароля.

    ```sh
    git2reposync init --storage-user Admin --storage-pwd=Secret C:/Хранилище_1С/ C:/work_dir/
    ```
    Данная команда создаст новый репозиторий git в каталоге `C:/work_dir/` из хранилища 1С по пути `C:/Хранилище_1С/`
***
* Использование синонимов (короткая версия предыдущего примера)

    ```sh
    git2reposync i -uAdmin -p=Secret C:/Хранилище_1С/ C:/work_dir/
    ```
    Данная команда создаст новый репозиторий git в каталоге `C:/work_dir/` из хранилища 1С по пути `C:/Хранилище_1С/`
***
* Использование только переменных окружения

    linux:
    ```sh
    export git2reposync_WORKDIR=./work_dir/
    export git2reposync_STORAGE_PATH=./Хранилище_1С/

    export git2reposync_STORAGE_USER=Админ
    export git2reposync_STORAGE_PASSWORD=Пароль
    export git2reposync_V8VERSION=8.3.7
    export git2reposync_VERBOSE=true #Можно использовать Да/Ложь/Нет/Истина
    export git2reposync_TEMP=./temp/sync
    git2reposync i
    ```
    
    windows:
    ```cmd
    set git2reposync_WORKDIR=./work_dir/
    set git2reposync_STORAGE_PATH=./Хранилище_1С/

    set git2reposync_STORAGE_USER=Админ
    set git2reposync_STORAGE_PASSWORD=Пароль
    set git2reposync_V8VERSION=8.3.7
    set git2reposync_VERBOSE=true #Можно использовать Да/Ложь/Нет/Истина
    set git2reposync_TEMP=./temp/sync

    git2reposync i
    ```
    Данная команда создаст новый репозиторий git в каталоге `C:/work_dir/` из хранилища 1С по пути `C:/Хранилище_1С/`
