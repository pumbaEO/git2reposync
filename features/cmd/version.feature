# language: ru

Функционал: Инициализация каталога исходников конфигурации
    Как Пользователь
    Я хочу получать версию продукта git2reposync
    Чтобы понимать актуальность продукта

Контекст: Тестовый каталог
    Когда Я очищаю параметры команды "git2reposync" в контексте
    И Я устанавливаю путь выполнения команды "git2reposync" к текущей библиотеке

Сценарий: Получение версии продукта
    Когда Я добавляю параметр "--version" для команды "git2reposync"
    Когда Я выполняю команду "git2reposync"
    Тогда Вывод команды "git2reposync" содержит "."
    И Вывод команды "git2reposync" не содержит "Внешнее исключение"
    И Код возврата команды "git2reposync" равен 0