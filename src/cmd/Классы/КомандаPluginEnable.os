#Использовать "../../core"

Перем Лог;

Процедура ОписаниеКоманды(Команда) Экспорт
	
	Команда.Опция("a all", Ложь, "включить все установленные плагинов")
				.ВОкружении("git2reposync_ENABLE_ALL_PLUGINS");
	Команда.Аргумент("PLUGIN", "", "Имя установленного плагина")
				.ТМассивСтрок()
				.ВОкружении("git2reposync_PLUGINS");

	Команда.Спек = "(-a | --all) | PLUGIN...";

КонецПроцедуры

Процедура ВыполнитьКоманду(Знач Команда) Экспорт

	ИменаПлагинов = Команда.ЗначениеАргумента("PLUGIN");
	ВсеУстановленные = Команда.ЗначениеОпции("all");

	МенеджерПлагинов = ПараметрыПриложения.МенеджерПлагинов();
	
	Если ВсеУстановленные Тогда
		МенеджерПлагинов.ВключитьВсеПлагины();
	Иначе

		ВсеПлагины = МенеджерПлагинов.ПолучитьИндексПлагинов();

		Для каждого Плагин Из ИменаПлагинов Цикл

			ИмяПлагина = СокрЛ(Плагин);
			НашлиПлагин = ВсеПлагины[ИмяПлагина];

			Если НашлиПлагин = Неопределено Тогда
				Сообщить(СтрШаблон("Нашли не установленный плагин: %1", Плагин));
				Продолжить;
			КонецЕсли;

			НашлиПлагин.Включить();

			Сообщить("Включен плагин: "+ ИмяПлагина);

		КонецЦикла;

	КонецЕсли;

	ПараметрыПриложения.ЗаписатьВключенныеПлагины();

КонецПроцедуры

Лог = ПараметрыПриложения.Лог();
