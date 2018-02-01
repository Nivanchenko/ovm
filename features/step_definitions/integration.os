﻿// Реализация шагов BDD-фич/сценариев c помощью фреймворка https://github.com/artbear/1bdd

Перем БДД; //контекст фреймворка 1bdd

// Метод выдает список шагов, реализованных в данном файле-шагов
Функция ПолучитьСписокШагов(КонтекстФреймворкаBDD) Экспорт
	БДД = КонтекстФреймворкаBDD;

	ВсеШаги = Новый Массив;

	ВсеШаги.Добавить("ЯУстанавливаюПеременнойСредыЗначение");

	Возврат ВсеШаги;
КонецФункции

// Реализация шагов

// Процедура выполняется перед запуском каждого сценария
Процедура ПередЗапускомСценария(Знач Узел) Экспорт
	
КонецПроцедуры

// Процедура выполняется после завершения каждого сценария
Процедура ПослеЗапускаСценария(Знач Узел) Экспорт
	
КонецПроцедуры

//Я устанавливаю переменной среды "OVM_INSTALL_PATH" значение "./temp/ovm"
Процедура ЯУстанавливаюПеременнойСредыЗначение(Знач ИмяПеременной, Знач ЗначениеПеременной) Экспорт
	УстановитьПеременнуюСреды(ИмяПеременной, ЗначениеПеременной);
КонецПроцедуры