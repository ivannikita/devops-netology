## Знакомоство с SonarQube

### Основная часть

1. Создайте новый проект, название произвольное.
<img src="images/0903_1.png"/>
2. Скачайте пакет sonar-scanner, который вам предлагает скачать SonarQube.
3. Сделайте так, чтобы binary был доступен через вызов в shell (или поменяйте переменную PATH, или любой другой, удобный вам способ).
4. Проверьте `sonar-scanner --version`.
<img src="images/0903_2.png"/>
5. Запустите анализатор против кода из директории [example](./example) с дополнительным ключом `-Dsonar.coverage.exclusions=fail.py`.
<img src="images/0903_3.png"/>
6. Посмотрите результат в интерфейсе.
<img src="images/0903_4.png"/>
7. Исправьте ошибки, которые он выявил, включая warnings.
8. Запустите анализатор повторно — проверьте, что QG пройдены успешно.
9. Сделайте скриншот успешного прохождения анализа, приложите к решению ДЗ.
<img src="images/0903_5.png"/>
## Знакомство с Nexus

### Основная часть

1. В репозиторий `maven-public` загрузите артефакт с GAV-параметрами:

 *    groupId: netology;
 *    artifactId: java;
 *    version: 8_282;
 *    classifier: distrib;
 *    type: tar.gz.
 <img src="images/0903_6.png"/>  
2. В него же загрузите такой же артефакт, но с version: 8_102.
<img src="images/0903_7.png"/>  
3. Проверьте, что все файлы загрузились успешно.
<img src="images/0903_8.png"/>  
4. В ответе пришлите файл `maven-metadata.xml` для этого артефекта.

### Знакомство с Maven

### Основная часть

1. Поменяйте в `pom.xml` блок с зависимостями под ваш артефакт из первого пункта задания для Nexus (java с версией 8_282).
<img src="images/0903_9.png"/> 
2. Запустите команду `mvn package` в директории с `pom.xml`, ожидайте успешного окончания.
<img src="images/0903_10.png"/> 
3. Проверьте директорию `~/.m2/repository/`, найдите ваш артефакт.
<img src="images/0903_11.png"/> 
4. В ответе пришлите исправленный файл `pom.xml`.