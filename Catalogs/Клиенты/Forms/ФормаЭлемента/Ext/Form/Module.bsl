﻿
&НаКлиенте
Процедура ИсторияЗаписей(Команда)
	
	Если Объект.Ссылка.Пустая() Тогда
		Возврат;	
	КонецЕсли;  
	
	ИмяОткрываемойФормы = "РегистрСведений.ИсторияЗаписей.ФормаСписка";
	СтруктураОтбора = Новый Структура("Клиент", Объект.Ссылка);
	СтруктураПараметров = Новый Структура("Отбор", СтруктураОтбора);
	ОткрытьФорму(ИмяОткрываемойФормы, СтруктураПараметров, ЭтотОбъект,,,,,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца)
	
КонецПроцедуры
