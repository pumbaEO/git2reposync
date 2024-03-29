# language: ru

Функционал: Клонирование существующего репозитория гит (команда clone)
    Как Пользователь
    Я хочу выполнить клонирование существующего репозитория гит
    Чтобы выполнять автоматическую выгрузку конфигураций из хранилища

Контекст: Тестовый контекст
    Когда Я очищаю параметры команды "git2reposync" в контексте
    И Я создаю новый объект ГитРепозиторий
    И Я устанавливаю путь выполнения команды "git2reposync" к текущей библиотеке
    И Я создаю временный каталог и сохраняю его в переменной "КаталогХранилища1С"
    И я скопировал каталог тестового хранилища конфигурации в каталог из переменной "КаталогХранилища1С"
    И Я создаю временный каталог и сохраняю его в переменной "URLРепозитория"
    И Я инициализирую bare репозиторий в каталоге из переменной "URLРепозитория"
    И Я наполняю bare репозиторий из переменной "URLРепозитория" тестовыми данными
    И Я создаю временный каталог и сохраняю его в переменной "ПутьКаталогаИсходников"
    И я включаю отладку лога с именем "oscript.app.git2reposync"
 
Сценарий: Клонирование репозитория гит и наполнение его служебными данными
    Допустим Я добавляю параметр "-v" для команды "git2reposync"
    И Я добавляю параметр "clone" для команды "git2reposync"
    И Я добавляю позиционный параметр для команды "git2reposync" из переменной "КаталогХранилища1С"
    И Я добавляю позиционный параметр для команды "git2reposync" из переменной "URLРепозитория"
    И Я добавляю позиционный параметр для команды "git2reposync" из переменной "ПутьКаталогаИсходников"
    Когда Я выполняю команду "git2reposync"
    Тогда Вывод команды "git2reposync" содержит "Клонирование завершено"
    И Вывод команды "git2reposync" не содержит "Внешнее исключение"
    И Код возврата команды "git2reposync" равен 0
    И В каталоге из переменной "ПутьКаталогаИсходников" создается файл или каталог "AUTHORS"
    И В каталоге из переменной "ПутьКаталогаИсходников" создается файл или каталог "VERSION"

Сценарий: Клонирование репозитория с использованием текущего рабочего каталога
    Допустим Я добавляю параметр "-v" для команды "git2reposync"
    И Я добавляю параметр "clone" для команды "git2reposync"
    И Я добавляю позиционный параметр для команды "git2reposync" из переменной "КаталогХранилища1С"
    И Я добавляю позиционный параметр для команды "git2reposync" из переменной "URLРепозитория"
    И Я устанавливаю рабочей каталог из переменной "ПутьКаталогаИсходников"
    Когда Я выполняю команду "git2reposync"
    Тогда Вывод команды "git2reposync" содержит "Клонирование завершено"
    И Вывод команды "git2reposync" не содержит "Внешнее исключение"
    И Код возврата команды "git2reposync" равен 0
    И В каталоге из переменной "ПутьКаталогаИсходников" создается файл или каталог "AUTHORS"
    И В каталоге из переменной "ПутьКаталогаИсходников" создается файл или каталог "VERSION"

Сценарий: Клонирование репозитория с использованием переменных окружения
    Допустим Я добавляю параметр "-v" для команды "git2reposync"
    И Я добавляю параметр "clone" для команды "git2reposync"
    И Я устанавливаю переменную окружения "git2reposync_REPO_URL" из переменной "URLРепозитория"
    И Я устанавливаю переменную окружения "git2reposync_STORAGE_PATH" из переменной "КаталогХранилища1С"
    И Я устанавливаю переменную окружения "git2reposync_WORKDIR" из переменной "ПутьКаталогаИсходников"
    Когда Я выполняю команду "git2reposync"
    Тогда Вывод команды "git2reposync" содержит "Клонирование завершено"
    И Вывод команды "git2reposync" не содержит "Внешнее исключение"
    И Код возврата команды "git2reposync" равен 0
    И В каталоге из переменной "ПутьКаталогаИсходников" создается файл или каталог "AUTHORS"
    И В каталоге из переменной "ПутьКаталогаИсходников" создается файл или каталог "VERSION"
    И Я очищаю значение переменных окружения 
    |git2reposync_STORAGE_PATH|
    |git2reposync_WORKDIR|
