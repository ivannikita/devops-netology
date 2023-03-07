Задача 1  
Архитектор ПО решил проконсультироваться у вас, какой тип БД лучше выбрать для хранения определённых данных.

Он вам предоставил следующие типы сущностей, которые нужно будет хранить в БД:

электронные чеки в json-виде mongodb так как данные в могут быть разные  
склады и автомобильные дороги для логистической компании postgresql так как понятно как связывать данные в базе между таблицами   
генеалогические деревья orientdb так как это дерево то резонно ипользовать графовую базу данных  
кэш идентификаторов клиентов с ограниченным временем жизни для движка аутенфикации redis    
отношения клиент-покупка для интернет-магазина orientdb   
Выберите подходящие типы СУБД для каждой сущности и объясните свой выбор.  


Задача 2  
Вы создали распределённое высоконагруженное приложение и хотите классифицировать его согласно CAP-теореме. Какой классификации по CAP-теореме соответствует ваша система, если (каждый пункт — это отдельная реализация вашей системы и для каждого пункта нужно привести классификацию):

данные записываются на все узлы с задержкой до часа (асинхронная запись); AP | PA/EL    
при сетевых сбоях система может разделиться на 2 раздельных кластера; CA | PA/EC
система может не прислать корректный ответ или сбросить соединение.  CP | PC/EL
Согласно PACELC-теореме как бы вы классифицировали эти реализации?



Задача 3  
Могут ли в одной системе сочетаться принципы BASE и ACID? Почему?
Могут, частично зависит от построения системы и типы базы данных. 
Задача 4  
Вам дали задачу написать системное решение, основой которого бы послужили:

фиксация некоторых значений с временем жизни,
реакция на истечение таймаута.
Вы слышали о key-value-хранилище, которое имеет механизм Pub/Sub. Что это за система? Какие минусы выбора этой системы?  
Скорее всего речь идет о redis она умеет переодически сбрасывать данные на жесткий диск, при сбое в системы потеряется только часть данных, зато сохраненные данные можно подгрузить в память тем самым ускорить "разогрев" кеша после сбоя.