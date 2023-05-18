﻿
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	//{{__КОНСТРУКТОР_ВВОД_НА_ОСНОВАНИИ
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.Запись") Тогда
		// Заполнение шапки
		Клиент = ДанныеЗаполнения.Клиент;
		Комментарий = ДанныеЗаполнения.Комментарий;
		Салон = ДанныеЗаполнения.Салон;
		Сотрудник = ДанныеЗаполнения.Сотрудник;
		Запись = ДанныеЗаполнения.Ссылка;
		Сумма = ДанныеЗаполнения.Сумма;
		Услуга = ДанныеЗаполнения.Услуга;
	КонецЕсли;
	//}}__КОНСТРУКТОР_ВВОД_НА_ОСНОВАНИИ
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, Режим)
	// регистр Продажи 
	Движения.Продажи.Записывать = Истина;
	Движение = Движения.Продажи.Добавить();
	Движение.Период = Дата;
	Движение.Салон = Салон;
	Движение.Клиент = Клиент;
	Движение.Сотрудник = Сотрудник;
	Движение.Услуга = Услуга;
	Движение.Сумма = Сумма;
	
	// регистр Зарплата
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ПроцентыПоЗарплате.Процент КАК Процент
		|ИЗ
		|	РегистрСведений.ПроцентыПоЗарплате КАК ПроцентыПоЗарплате
		|ГДЕ
		|	ПроцентыПоЗарплате.Сотрудник = &Сотрудник";
	
	Запрос.УстановитьПараметр("Сотрудник", Сотрудник);
	
	Процент = 0;
	РезультатЗапроса = Запрос.Выполнить();
	Если НЕ РезультатЗапроса.Пустой() Тогда
		Выборка = РезультатЗапроса.Выбрать();
		Выборка.Следующий();
		Процент = Выборка.Процент;
	КонецЕсли;   
	
	Движения.Зарплата.Записывать = Истина;
	Движение = Движения.Зарплата.Добавить();
	Движение.Период = Дата;
	Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
	Движение.Сотрудник = Сотрудник;
	Движение.Салон = Салон;
	Движение.Месяц = НачалоМесяца(Дата);
	Движение.Сумма = Сумма*Процент / 100;
	
КонецПроцедуры
