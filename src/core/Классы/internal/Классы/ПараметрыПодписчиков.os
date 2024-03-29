#Использовать logos

Перем ИндексПараметров;
Перем Лог;

#Область Экспортные_методы

// Получает и возвращает значение из индекса параметров
//
// Параметры:
//   СтрокаИмениПараметра - Строка - имя параметра
//                                  допустимо указание нескольких имен к параметру через пробел (например, "config --config -c c")
//   ЗначениеПоУмолчанию  - Произвольный - возвращаемое значение в случае отсутствия параметра после получения из индекса
//
// Возвращаемое значение:
//   Строка, Число, Булево, Массив, Соответствие, Неопределено - значение параметра
//
Функция Параметр(Знач СтрокаИмениПараметра, Знач ЗначениеПоУмолчанию = Неопределено) Экспорт

	МассивИменПараметра = СтрРазделить(СтрокаИмениПараметра, " ", Ложь);

	Для каждого ИмяПараметра Из МассивИменПараметра Цикл
		
		ПолученноеЗначение = ПолучитьЗначение(ИмяПараметра);

		Если Не ПолученноеЗначение = Неопределено Тогда
			Возврат ПреобразоватьКТипу(ПолученноеЗначение, ТипЗнч(ЗначениеПоУмолчанию));
		КонецЕсли;

	КонецЦикла;

	Возврат ЗначениеПоУмолчанию;

КонецФункции

// Возвращает используемый индекс параметров 
//
// Возвращаемое значение:
//   Соответствие - соответствие ключей и значение параметров
//
Функция ПолучитьПараметры() Экспорт

	Возврат ИндексПараметров;

КонецФункции

#КонецОбласти

#Область Вспомогательные_процедуры_и_функции

Функция ПреобразоватьКТипу(Знач ВходящееЗначение, Знач НужныйТип)

	Значение = ВходящееЗначение;
	
	Если ТипЗнч(ВходящееЗначение) = НужныйТип Тогда
		Возврат ВходящееЗначение;
	КонецЕсли;

	Если Тип("Число") = НужныйТип Тогда
		Значение = Число(ВходящееЗначение);
	ИначеЕсли Тип("Строка") = НужныйТип Тогда
		Значение = Строка(ВходящееЗначение);
	ИначеЕсли Тип("Булево") = НужныйТип Тогда
		Значение = Булево(ВходящееЗначение);
	ИначеЕсли Тип("Дата") = НужныйТип Тогда
		Значение = Дата(ВходящееЗначение);
	КонецЕсли;
	
	Возврат Значение;

КонецФункции

Функция ПолучитьЗначение(Знач ИмяПараметра)
	
	ПолученноеЗначение = ПолучитьЗначениеИзИндекса(ИмяПараметра);

	Если Не ПолученноеЗначение = Неопределено Тогда
		Возврат ПолученноеЗначение;
	КонецЕсли;
	
	ОчиститьОтТире(ИмяПараметра);

	ПолученноеЗначение = ПолучитьЗначениеИзИндекса(ИмяПараметра);

	Если Не ПолученноеЗначение = Неопределено Тогда
		Возврат ПолученноеЗначение;
	КонецЕсли;

	ДополнитьТире(ИмяПараметра);

	ПолученноеЗначение = ПолучитьЗначениеИзИндекса(ИмяПараметра);

	Возврат ПолученноеЗначение;
	
КонецФункции

Процедура ОчиститьОтТире(ИмяПараметра)
	
	НачальныйСимвол = 2;

	Пока СтрНачинаетсяС(ИмяПараметра, "-") Цикл
		ИмяПараметра = Сред(ИмяПараметра, НачальныйСимвол);
	КонецЦикла;

КонецПроцедуры

Процедура ДополнитьТире(ИмяПараметра)
	
	Если СтрДлина(ИмяПараметра) = 1 Тогда
		
		ИмяПараметра = СтрШаблон("-%1", ИмяПараметра);

	ИначеЕсли ВРег(ИмяПараметра) = ИмяПараметра Тогда
		// Это аргумент ничего не надо добавлять
	Иначе

		ИмяПараметра = СтрШаблон("--%1", ИмяПараметра);

	КонецЕсли;

КонецПроцедуры

Функция ПолучитьЗначениеИзИндекса(Знач ИмяПараметра)

	Возврат ИндексПараметров[ИмяПараметра];
	
КонецФункции

Процедура ПриСозданииОбъекта(ВходящийИндексПараметров)

	ИндексПараметров = ВходящийИндексПараметров;
	Лог = Логирование.ПолучитьЛог("oscript.lib.git2reposync.plugins.params");

КонецПроцедуры

#КонецОбласти
