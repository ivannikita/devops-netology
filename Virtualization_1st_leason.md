1. Опишите кратко, как вы поняли: в чем основное отличие полной (аппаратной) виртуализации, паравиртуализации и виртуализации на основе ОС.
    1) Аппаратная виртуализация устанавливается непосредственно на оборудование и использует прямые доступы до вычеслительных ресурсов и доп систем.
    2) паравиртуализация устанавливается поверх ОС установленной на железо, и использует доступы до оборудование через средства той ОС на которой она установлена.
    3) Виртуализации на основе ОС использует механизмы разделения ресурсов внутри ОС может быть установлена только на LInux like системах, так как для запуска дочерней системы используется ядро хостовой системы.   
2. Выберите один из вариантов использования организации физических серверов, в зависимости от условий использования.

Организация серверов:

физические сервера,   
паравиртуализация,   
виртуализация уровня ОС.    

Условия использования:

Высоконагруженная база данных, чувствительная к отказу.   
Различные web-приложения.   
Windows системы для использования бухгалтерским отделом.  
Системы, выполняющие высокопроизводительные расчеты на GPU.  
Опишите, почему вы выбрали к каждому целевому использованию такую организацию.  

Высоконагруженная база данных, чувствительная к отказу. ->  виртуализация уровня ОС 
Выбрал виртуализацию уровня ОС так как необходима отказа устойчевость а с помощью данной виртуализации можно поднять несколько отдельных серверов и использовать отказоустойчевый кластер.
Различные web-приложения.   ->  виртуализация уровня ОС 
Данный тип виртуализации позволяет динамически увеличивать вычислительную мощность необходимую для работы продукта, что даст возможность наращивать мощность в пикомые моменты, и освобождать ресурсы при простое системы  
Windows системы для использования бухгалтерским отделом.  -> паравиртуализация
Так как это windows системы будем использовать паравиртуализацию, так как это позволит создать более гибкую и отказаустойчевую систему.
Системы, выполняющие высокопроизводительные расчеты на GPU -> физические сервера
Так как необходим доступ к расчетам на GPU будем использовать физ. сервера так как они позволят выжать максимальную производительность, из за прямого доступа к физическому устройству. Паравиртуализация тоже это позволит сделать но с некоторой просадкой по производительности.


3. Выберите подходящую систему управления виртуализацией для предложенного сценария. Детально опишите ваш выбор.

Сценарии:

100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий.
vmware так как оно в наибольшей степени поддерживает все указаные технологии.
Требуется наиболее производительное бесплатное open source решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин.  
xen как хорошо зарекомендовавшее и проверенное временем.  
Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows инфраструктуры.   
xen как наиболее совместимое ПО.
Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux. k8s так как его тестовую среду можно будет быстро развернуть и пересорать заново.

4. Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор, то создавали бы вы гетерогенную среду или нет? Мотивируйте ваш ответ примерами.  
В гетерогенной среде невозможна миграция виртуальных машин между гипервизорами, необходимо содержать штат сотрудников знающих разные системы. 