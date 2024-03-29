# language: ru

Функционал: Синхронизация хранилища конфигурации 1С и гит (команды sync)
    Как Пользователь
    Я хочу выполнять автоматическую синхронизацию конфигурации из хранилища
    Чтобы автоматизировать свою работы с хранилищем с git

Контекст: Тестовый контекст синхронизации
    Когда Я создаю новый объект ГитРепозиторий
    И Я создаю новый объект МенеджерСинхронизации
    И Я создаю временный каталог и сохраняю его в переменной "КаталогХранилища1С"
    И я скопировал каталог тестового хранилища конфигурации в каталог из переменной "КаталогХранилища1С"
    И Я создаю временный каталог и сохраняю его в переменной "ПутьКаталогаИсходников"
    И Я инициализирую репозиторий в каталоге из переменной "ПутьКаталогаИсходников"
    И Я создаю тестовой файл AUTHORS 
    И Я записываю "0" в файл VERSION
    И Я включаю отладку лога с именем "oscript.app.git2reposync.plugins.loader"
    И Я включаю отладку лога с именем "oscript.app.git2reposync.plugins.event-subscriptions"

Сценарий: Простая синхронизация хранилища с git-репозиторием
    Допустим Я устанавливаю авторизацию в хранилище пользователя "Администратор" с паролем ""
    И Я устанавливаю версию платформы "8.3"
    Когда Я выполняю выполняют синхронизацию
    Тогда Вывод лога содержит "Завершена синхронизации с git"

Сценарий: Cинхронизация хранилища с git-репозиторием c плагинами
    Допустим Я устанавливаю авторизацию в хранилище пользователя "Администратор" с паролем ""
    И Я устанавливаю версию платформы "8.3"
    И Я создаю временный каталог и сохраняю его в переменной "КаталогПлагинов"
    И Я создаю новый МенеджерПлагинов
    И Я собираю тестовый плагин и сохраняю в контекст "ПутьКФайлуПлагина"
    И Я устанавливаю файл плагина из переменной "ПутьКФайлуПлагина"
    И Я загружаю плагины из каталога в переменной "КаталогПлагинов"
    И Я подключаю плагины в МенеджерСинхронизации
    Когда Я выполняю выполняют синхронизацию
    Тогда Вывод лога содержит "Завершена синхронизации с git"
    И Вывод лога содержит "Вызвано событие <ПриАктивизации> для плагина <test_plugin>"
    