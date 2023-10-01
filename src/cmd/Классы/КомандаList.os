#Использовать "../../core"

&ЛогOVM
Перем Лог;

&Пластилин("АппендерЛогOVM")
Перем Аппендер;

&Пластилин
Перем ВерсииOneScript;

&Опция(Имя = "remote r", Описание = "Вывести список доступных к установке версий")
&ВОкружении("OVM_LIST_REMOTE")
&ТБулево
&ПоУмолчанию(Ложь)
Перем ВыводитьСписокВерсийНаСайте;

&Опция(Имя = "all a", Описание = "Вывести список всех версий: установленных и доступных на сайте")
&ВОкружении("OVM_LIST_ALL")
&ТБулево
&ПоУмолчанию(Ложь)
Перем ВыводитьВсеВерсии;

&Опция(Имя = "quiet q", Описание = "Тихий режим, вывод только алиасов версий")
&ВОкружении("OVM_LIST_QUIET")
&ТБулево
&ПоУмолчанию(Ложь)
Перем ТихийРежим;

&КомандаПриложения(Имя = "list ls", Описание = "Вывести список установленных и/или доступных версий OneScript")
Процедура ПриСозданииОбъекта()
КонецПроцедуры

&ВыполнениеКоманды
Процедура ВыполнениеКоманды() Экспорт

	Если ВыводитьВсеВерсии Тогда
		ВывестиВсеВерсии();
	ИначеЕсли ВыводитьСписокВерсийНаСайте Тогда
		ВывестиСписокДоступныхКУстановкеВерсий();
	Иначе
		ВывестиСписокУстановленныхВерсий();
	КонецЕсли;

КонецПроцедуры

Процедура ВывестиВсеВерсии()

	ВсеВерсии = ВерсииOneScript.ПолучитьСписокВсехВерсий();
	
	Для Каждого СтрокаВерсия Из ВсеВерсии Цикл
		
		Если ТихийРежим И СтрокаВерсия.ЭтоСимлинк Тогда
			Продолжить;
		КонецЕсли;
		
		Если ТихийРежим Тогда
			Сообщение = СтрокаВерсия.Алиас;
		Иначе	
			Сообщение = СтрШаблон(
				"%1 -> %2 -> %3 -> %4",
				СтрокаВерсия.Алиас,
				?(СтрокаВерсия.Версия = "", "unknown", СтрокаВерсия.Версия),
				?(СтрокаВерсия.ПутьЛокальный = "", "not installed", СтрокаВерсия.ПутьЛокальный),
				?(СтрокаВерсия.ПутьСервер = "", "unknown", СтрокаВерсия.ПутьСервер)
			);
		КонецЕсли;
		
		УстанавливаемыйСтатусСообщения = ?(
			СтрокаВерсия.Алиас = "current",
			СтатусСообщения.Информация,
			СтатусСообщения.БезСтатуса
		);

		Аппендер.УстановитьСвойство("message-status", УстанавливаемыйСтатусСообщения);
		Лог.Информация(Сообщение);

	КонецЦикла;
	
КонецПроцедуры

Процедура ВывестиСписокУстановленныхВерсий()
	СписокУстановленныхВерсий = ВерсииOneScript.ПолучитьСписокУстановленныхВерсий();
	Для Каждого УстановленнаяВерсия Из СписокУстановленныхВерсий Цикл
		
		Если ТихийРежим И УстановленнаяВерсия.ЭтоСимлинк Тогда
			Продолжить;
		КонецЕсли;

		Если ТихийРежим Тогда
			Сообщение = УстановленнаяВерсия.Алиас;
		Иначе
			Сообщение = СтрШаблон(
				"%1 -> %2 (%3)",
				УстановленнаяВерсия.Алиас,
				УстановленнаяВерсия.Версия,
				УстановленнаяВерсия.Путь
			);
		КонецЕсли;
		
		УстанавливаемыйСтатусСообщения = ?(
			УстановленнаяВерсия.Алиас = "current",
			СтатусСообщения.Информация,
			СтатусСообщения.БезСтатуса
		);

		Аппендер.УстановитьСвойство("message-status", УстанавливаемыйСтатусСообщения);
		Лог.Информация(Сообщение);

	КонецЦикла;
КонецПроцедуры

Процедура ВывестиСписокДоступныхКУстановкеВерсий()
	
	СписокДоступныВерсий = ВерсииOneScript.ПолучитьСписокДоступныхКУстановкеВерсий();
	Для Каждого ДоступнаяВерсия Из СписокДоступныВерсий Цикл
		Если ТихийРежим Тогда
			Сообщение = ДоступнаяВерсия.Алиас;
		Иначе
			Сообщение = СтрШаблон("%1 (%2)", ДоступнаяВерсия.Алиас, ДоступнаяВерсия.Путь);
		КонецЕсли;	
		Лог.Информация(Сообщение);
	КонецЦикла;

КонецПроцедуры
