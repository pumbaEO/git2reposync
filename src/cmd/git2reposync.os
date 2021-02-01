﻿///////////////////////////////////////////////////////////////////
//
#Использовать cli
#Использовать tempfiles
#Использовать "../core"
#Использовать "."

Перем Лог;
Перем Плагины;
Перем ВерсияПлатформы;
Перем ВыводДополнительнойИнформации;
Перем ВременныйКаталогРаботы;
Перем ДоменПочты;
///////////////////////////////////////////////////////////////////////////////

Процедура ВыполнитьПриложение()

	Приложение = Новый КонсольноеПриложение(ПараметрыПриложения.ИмяПриложения(),
											"Приложение для синхронизации Хранилища 1С с git",
											ЭтотОбъект);
	Приложение.Версия("version", ПараметрыПриложения.Версия());
	Приложение.Опция("v8version", "8.3", "маска версии платформы 1С (8.3, 8.3.5, 8.3.6.2299 и т.п.)")
					.ВОкружении("git2reposync_V8VERSION");
	Приложение.Опция("v8-path", "", "путь к исполняемому файлу платформы 1С (Например, /opt/1C/v8.3/x86_64/1cv8)")
					.ВОкружении("git2reposync_V8_PATH");

	Приложение.Опция("v verbose", Ложь, "вывод отладочной информации в процессе выполнения")
					.Флаговый()
					.ВОкружении("git2reposync_VERBOSE");
		
	Приложение.Опция("U ib-user ib-usr db-user", "", "пользователь информационной базы")
					.ТСтрока()
					.ВОкружении("git2reposync_IB_USR git2reposync_IB_USER git2reposync_DB_USER");

	Приложение.Опция("P ib-pwd db-pwd", "", "пароль пользователя информационной базы")
					.ТСтрока()
					.ВОкружении("git2reposync_IB_PASSWORD git2reposync_IB_PWD git2reposync_DB_PSW");
	
	Приложение.Опция("C ib-connection ibconnection", "", "путь подключения к информационной базе")
					.ТСтрока()
					.ВОкружении("git2reposync_IB_CONNECTION git2reposync_IBCONNECTION");

	// Приложение.Опция("p plugins", "", "плагины к загрузке и исполнению (дополнительное ограничение)")
	// 				.ТМассивСтрок()
	// 				.ВОкружении("git2reposync_RUN_PLUGINS");

	Приложение.Опция("t tempdir", "", "путь к каталогу временных файлов")
					.ВОкружении("git2reposync_TEMP git2reposync_TEMPDIR");

	Приложение.Опция("git-path", "", "путь к исполняемому файлу git")
					.ВОкружении("git2reposync_GIT_PATH GIT_PATH");

	Приложение.Опция("domain-email", "localhost", "домен почты для пользователей git")
					.ВОкружении("git2reposync_EMAIL git2reposync_DOMAIN_EMAIL");

	Приложение.ДобавитьКоманду("usage u", "Выводит примеры использования",
								Новый КомандаUsage);
	Приложение.ДобавитьКоманду("init i", "Инициализация структуры нового хранилища git. Подготовка к синхронизации",
								Новый КомандаInit);
	Приложение.ДобавитьКоманду("sync s", "Выполняет синхронизацию хранилища 1С с git-репозиторием",
								Новый КомандаSync);
	Приложение.ДобавитьКоманду("clone c", "Клонирует существующий репозиторий и создает служебные файлы",
								Новый КомандаClone);
	Приложение.ДобавитьКоманду("all a", "Запускает синхронизацию по нескольким репозиториям",
								Новый КомандаAll);
	Приложение.ДобавитьКоманду("set-version sv", "Устанавливает необходимую версию в файл VERSION",
								Новый КомандаSetVersion);
	Приложение.ДобавитьКоманду("plugins p", "Управление плагинами git2reposync",
								Новый КомандаPlugins);

	// Приложение.УстановитьДействиеПередВыполнением(ЭтотОбъект, "ПередВыполнениемКоманды"); // TODO: Расскоментировать при исправлении ошибки в cli

	Приложение.Запустить(АргументыКоманднойСтроки);

КонецПроцедуры // ВыполнениеКоманды()

Процедура ВыполнитьКоманду(Знач КомандаПриложения) Экспорт
	
	КомандаПриложения.ВывестиСправку();

КонецПроцедуры

Процедура ПередВыполнениемКоманды(Знач Команда) Экспорт

	ВерсияПлатформы = Команда.ЗначениеОпции("v8version");
	ПутьКПлатформе = Команда.ЗначениеОпции("v8-path");
	ВыводДополнительнойИнформации = Команда.ЗначениеОпции("verbose");
	ПутьКГит = Команда.ЗначениеОпции("git-path");
	ВременныйКаталогРаботы = Команда.ЗначениеОпции("tempdir");
	ДоменПочты = Команда.ЗначениеОпции("domain-email");
	
	ПараметрыПриложения.УстановитьРежимОтладкиПриНеобходимости(ВыводДополнительнойИнформации);

	Лог.Отладка("Устанавливаю общие параметры");
	ПараметрыПриложения.УстановитьВерсиюПлатформы(ВерсияПлатформы);
	ПараметрыПриложения.УстановитьПутьКПлатформе(ПутьКПлатформе);
	ПараметрыПриложения.УстановитьПутьКГит(ПутьКГит);
	ПараметрыПриложения.УстановитьДоменПочты(ДоменПочты);
	ПараметрыПриложения.УстановитьВременныйКаталог(ВременныйКаталогРаботы);
	
КонецПроцедуры

///////////////////////////////////////////////////////

Лог = ПараметрыПриложения.Лог();
ПараметрыПриложения.ПодготовитьПлагины(); 

Попытка

	ВыполнитьПриложение();

Исключение

	Лог.КритичнаяОшибка(ОписаниеОшибки());
	ВременныеФайлы.Удалить();

	ЗавершитьРаботу(1);

КонецПопытки;