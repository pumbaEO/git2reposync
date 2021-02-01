#Использовать tempfiles

#Область ПрограммныйИнтерфейс

Функция ПолучитьПутьКФайлу(Знач ИмяФайла) Экспорт

	Возврат ПолучитьВременныйПутьКФайлу(ИмяФайла);

КонецФункции

Функция ПолучитьВременныйПутьКФайлу(Знач ИмяФайла) Экспорт

	МенеджерЗапакованныхФайлов = Новый МенеджерЗапакованныхФайловgit2reposync;
	ИндексФайлов = МенеджерЗапакованныхФайлов.ПолучитьИндексФайлов();

	ИмяКлассаФайла = ИндексФайлов[ИмяФайла];

	Если ИмяКлассаФайла = Неопределено Тогда
		ВызватьИсключение СтрШаблон("Не удалось найти двоичные данные для файла <%1>", ИмяФайла);
	КонецЕсли;

	ФайлРаспаковки = Новый Файл(ИмяФайла);

	КлассФайла = Новый (ИмяКлассаФайла);

	ПутьКФайлу = ВременныеФайлы.НовоеИмяФайла(ФайлРаспаковки.Расширение);
	
	РаспаковатьДанные(ПутьКФайлу, КлассФайла);

	Возврат ПутьКФайлу;

КонецФункции

Функция ПолучитьХешФайла(Знач ИмяФайла) Экспорт
	
	МенеджерЗапакованныхФайлов = Новый МенеджерЗапакованныхФайловgit2reposync;
	ИндексФайлов = МенеджерЗапакованныхФайлов.ПолучитьИндексФайлов();

	ИмяКлассаФайла = ИндексФайлов[ИмяФайла];

	Если ИмяКлассаФайла = Неопределено Тогда
		ВызватьИсключение СтрШаблон("Не удалось найти двоичные данные для файла <%1>", ИмяФайла);
	КонецЕсли;

	ФайлРаспаковки = Новый Файл(ИмяФайла);

	КлассФайла = Новый (ИмяКлассаФайла);

	Возврат КлассФайла.Хеш()

КонецФункции

#КонецОбласти

#Область Упакованные_файлы

Процедура РаспаковатьДанные(Знач ПутьКФайлу, КлассФайла)

	ДвоичныеДанные = Base64Значение(КлассФайла.ДвоичныеДанные());

	ОбеспечитьКаталог(ПутьКФайлу);

	ДвоичныеДанные.Записать(ПутьКФайлу);
	
КонецПроцедуры

Процедура ОбеспечитьКаталог(ПутьККаталогу)

	ВременныйКаталог = Новый Файл(ПутьККаталогу);

	Если ВременныйКаталог.Существует() Тогда
		Возврат;
	КонецЕсли;

	СоздатьКаталог(ВременныйКаталог.Путь);

КонецПроцедуры

#КонецОбласти
