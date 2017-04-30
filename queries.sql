/*1. Выборка информации из таблиц

1. Выведите имя сотрудника колонкой "Emp First Name", фами-
лию колонкой "Emp Last Name", номер сотрудника колонкой
"Emp No.", зарплату этого сотрудника при увеличении ее на 10% и
затем все остальные столбы таблицы employees.*/
SELECT first_name AS "Emp First Name", last_name AS "Emp Last Name", employee_id AS "Emp No.", salary*1.1, email, phone_number, hire_date, job_id, commission_pct, manager_id, department_id FROM employees

/*2. Почему ошибочен запрос select employee_name "Full Employee Name in the company" from employees; ?
Поле alias должно содержать не более 30 символов.*/

/*3. Выведите столбцом summ сумму зарплаты и комиссионных сотруд-
ника, потом все строки таблицы employees. Результат должен быть
отсортирован по summ, потом по четвертому столбцу в итоговой вы-
борке.*/
SELECT salary*(1+commission_pct) AS "summ", employee_id, first_name, last_name,  email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id FROM employees ORDER BY "summ", last_name

SELECT salary*(1+commission_pct) AS "summ", employees.* FROM employees WHERE commission_pct IS NOT NULL ORDER BY "summ", last_name /*(не учитываются null значения для коммиссионных)*/

/*4. Выведите все записи таблицы employees, отсортированные сна-
чала по id отдела в порядке убывания, потом по году приема на рабо-
ту в порядке возрастания, потом по комиссионным (если есть пустые
значения, то они должны выводиться в начале).*/
SELECT * FROM employees ORDER BY department_id DESC, hire_date, commission_pct NULLS FIRST

/*5. По таблице employees в первом столбце person выведите имя,
фамилию сотрудника и id его должности в формате: [<имя> <фа-
милия> (<id должности>)]. Во втором столбце mgr соедините
строку: "Mgr's id: " и id менеджера этого сотрудника. Для двух этих
столбцов используйте различные способы конкатенирования строк.
Указание: конкатенация строк оператором || и функцией concat.*/
SELECT first_name || ' ' || last_name || ' (' || job_id || ')' AS "person", CONCAT('Mgr''s id: ',manager_id) AS "mgr" FROM employees

/*6. Выведите уникальный набор из id должностей сотрудников.
Предложите два варианта написания запроса.
Указание: использование ключевых слов distinct/unique.*/
SELECT DISTINCT job_id FROM employees
SELECT UNIQUE job_id FROM employees

/*7. По таблице employees выведите первым столбцом порядковый
номер извлеченной строки, вторым — фамилию сотрудника.
Указание: использование псевдостолбца rownum.*/
SELECT ROWNUM, last_name FROM employees

/*8. Выведите всех сотрудников из таблицы employees, у кого нет
комиссионных и есть менеджер.*/
SELECT * FROM employees WHERE commission_pct IS NULL AND manager_id IS NOT NULL

/*9. Выведите всех сотрудников с зарплатой не менее 3000, кроме со-
трудника с фамилией King.*/
SELECT * FROM employees WHERE salary >= 3000 AND last_name != 'King'

/*10. Выведите всех сотрудников, которые находятся в подчинении у
менеджеров со следующими id: 100, 101, 102.*/
SELECT * FROM employees WHERE manager_id IN(100,101,102)

/*11. Какие еще существуют операторы (назовите два), полностью эк-
вивалентные оператору IN?
OR
WHERE column = ANY()
WHERE column = SOME()*/

/*12. Выведите всех сотрудников, которые не находятся в подчинении у
менеджеров с id: 101, 102.*/
SELECT * FROM employees WHERE manager_id != SOME(101,102)
SELECT * FROM employees WHERE manager_id != 101 AND manager_id != 102

/*13. Решите предыдущую задачу с помощью оператора ALL.*/
SELECT * FROM employees WHERE manager_id != ALL(101,102)

/*14. Выведите всех сотрудников, зарплата которых не менее 4200 и не
более 6000.
Указание: использование оператора between.*/
SELECT * FROM employees WHERE salary BETWEEN 4200 AND 6000

/*15. Выведите всех сотрудников, фамилия которых записана в следую-
щем формате: [M<любой символ>R_<любая последовательность сим-
волов>].
Указание: использование оператора like.*/
SELECT * FROM employees WHERE last_name LIKE 'M_%'

/*16. Выведите всех сотрудников, у которых id должности либо
"IT_PROG", либо "FI_ACCOUNT", зарплата которых больше 4200.
Указание: запрос должен быть написан без использования скобок.*/
SELECT * FROM employees WHERE salary > 4200 AND job_id IN('IT_PROG', 'FI_ACCOUNT')

/*ПАМЯТКА(https://habrahabr.ru/post/256045/)
--Работа с JOIN
--традиционный синтаксис Oracle
SELECT e.FIRST_NAME, d.DEPARTMENT_NAME 
FROM HR.EMPLOYEES e, HR.DEPARTMENTS d
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID;

--Синтаксис ANSI/ISO
SELECT e.FIRST_NAME, d.DEPARTMENT_NAME 
FROM HR.EMPLOYEES e 
JOIN HR.DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

--NATURAL JOIN(довольно сомнительна) не требует указания столбца для сопоставления
SELECT e.FIRST_NAME, d.DEPARTMENT_NAME 
FROM HR.EMPLOYEES e 
NATURAL JOIN HR.DEPARTMENTS d;

--LEFT OUTER левое внешнее(все значения из левой)
SELECT e.FIRST_NAME, d.DEPARTMENT_NAME 
FROM HR.EMPLOYEES e 
LEFT OUTER JOIN HR.DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

--RIGHT OUTER правое внешнее(все значения из правой)
SELECT e.FIRST_NAME, d.DEPARTMENT_NAME 
FROM HR.EMPLOYEES e 
RIGHT OUTER JOIN HR.DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

--FULL полное(все значения из обоих таблиц в т.ч. не имеющие связь)
SELECT e.FIRST_NAME, d.DEPARTMENT_NAME 
FROM HR.EMPLOYEES e 
FULL OUTER JOIN HR.DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

--INNER внутреннее(все значения из обоих таблиц имеющие связь)
SELECT e.FIRST_NAME, d.DEPARTMENT_NAME 
FROM HR.EMPLOYEES e 
INNER JOIN HR.DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

--CROSS перекрестное соединение(все со всеми)
SELECT e.FIRST_NAME, d.DEPARTMENT_NAME 
FROM HR.EMPLOYEES e 
CROSS JOIN HR.DEPARTMENTS d;

--Соединение таблицы с собой
SELECT e1.FIRST_NAME||' работает для '||e2.FIRST_NAME 
FROM HR.EMPLOYEES e1, HR.EMPLOYEES e2
WHERE e1.MANAGER_ID = e2.EMPLOYEE_ID;*/

/*17. Выведите всевозможные комбинации id сотрудника и названия
отдела. Решите задачу также с использованием ANSI синтаксиса.*/

SELECT e.employee_id, d.department_name FROM employees e, departments d
SELECT e.employee_id, d.department_name FROM employees e CROSS JOIN departments d /*(синтаксис ANSI)*/

/*18. Выведите все id сотрудников и название отдела, в котором этот
сотрудник работает. Предложите вариант записи запроса с соедине-
нием в WHERE, а также два варианта синтаксиса ANSI. Какое слово
во внутренних соединениях ANSI является опциональным? - INNER
Указание: использование INNER JOIN.*/
SELECT e.employee_id, d.department_name FROM employees e, departments d WHERE e.department_id=d.department_id
SELECT e.employee_id, d.department_name FROM employees e INNER JOIN departments d ON (e.department_id = d.department_id)
SELECT e.employee_id, d.department_name FROM employees e INNER JOIN departments d USING(department_id)

/*19. Выведите все колонки из таблиц employees и departments,
соединяя таблицы внутренним образом по столбцам, имеющих одина-
ковое название.
Указание: использование NATURAL JOIN.*/
SELECT e.*, d.* FROM employees e NATURAL JOIN departments d

/*20. Выведите id всех отделов первой колонкой и сотрудников, в них
состоящих, второй колонкой. Если в отделе нет ни одного сотрудни-
ка, то вторая колонка должна содержать NULL для такого отдела.
Предложите решение, используя синтаксис Oracle, а также два вари-
анта синтаксиса ANSI. Какое слово в записи ANSI является необяза-
тельным? - OUTER*/
SELECT d.department_id, e.employee_id FROM departments d LEFT OUTER JOIN employees e ON (d.department_id=e.department_id)
SELECT d.department_id, e.employee_id FROM departments d LEFT OUTER JOIN employees e USING(department_id)
SELECT d.department_id, e.employee_id FROM departments d, employees e WHERE d.department_id=e.department_id(+)

/*21. Решите предыдущую задачу, используя RIGHT OUTER JOIN.*/
SELECT d.department_id, e.employee_id FROM employees e RIGHT OUTER JOIN departments d ON (d.department_id=e.department_id)
SELECT d.department_id, e.employee_id FROM employees e RIGHT OUTER JOIN departments d USING(department_id)
SELECT d.department_id, e.employee_id FROM departments d, employees e WHERE d.department_id(+)=e.department_id

/*22. Приведите пример запроса, когда Oracle возбуждает исключение о
том, что таблица не может быть дополнительной сразу к нескольким
основным (ORA-01417: a table may be outer joined to at most one other
table).
...a.b (+) = b.b and a.c (+) = c.c...*/

/*23. Приведите пример запроса, когда Oracle возбуждает исключение о
том, что таблицы не могут быть дополнительными друг к другу; дру-
гими словами, таблицы не образуют «циклов» по средствам внешних
соединений (ORA-01416: two tables cannot be outer-joined to each
other).*/
SELECT s.student_id, s.first_name, s.last_name FROM students s, orders o WHERE s.student_id = s.student_id(+) ORDER BY s.student_id;

/*2. Использование однострочных функций,
хранение и обработка дат и времени,
неявное преобразование данных*/

/*
2-09???????????*/
SELECT first_name, last_name, FLOOR(salary*0.87) AS "LOW", CEIL(salary*0.87) AS "UP", TO_CHAR(ROUND(salary*0.87, -2),'00099.999') AS "ROUND_K", TRUNC(salary*0.87, -2) AS "TRUNK_K" FROM employees
/*???????????*/

/*1. Выведите числовое значение (в коде ASCII) символа 'a', символа
'A' и третьей колонкой символ ASCII, код которого равен 42.
Указание: использование ASCII и CHR.*/
SELECT ASCII('a') AS "a", ASCII('A') AS "A", CHR(42) FROM DUAL 

/*2. Выведите по таблице locations первым столбцом уникальный
идентификатор местоположения, вторым столбцом street — адрес,
образованный усечением слева цифр и пробелов у колонки
street_address.
Указание: использование LTRIM.*/
SELECT location_id, LTRIM(street_address, '0123456789 ') FROM locations

/*3. По таблице locations первой колонкой выведите адрес, второй
— вывести тот же адрес, предварительно конвертировав каждую
первую букву нового слова в верхний регистр.
Указание: использование INITCAP.*/
SELECT street_address, INITCAP(street_address) FROM locations

/*4. По таблице jobs выведите должность и второй колонкой
последнее слово в названии этой должности.
Указание: использование SUBSTR, INSTR.*/
SELECT job_title, SUBSTR(job_title, INSTR(SUBSTR(job_title, 1+INSTR(job_title, ' ')), ' ')+1+INSTR(job_title, ' ')) FROM jobs

/*5. По таблице employees выведите строку следующего типа "<Имя
сотрудника>'s email is <Электронная почта сотрудника, приведенная к
нижнему
регистру>@myCompany.com"
(получившийся
адрес
электронной почты обернуть в угловые скобки); пример правильного
синтаксиса строки для сотрудника Yaroslav: Yaroslav's email is
<khodakovskiy@myCompany.com>.
Указание: использование LOWER.*/
select email, first_name || '''s email is ' || CONCAT(LOWER(email), '@myCompany.com') from employees КАК ДОБАВИТЬ СКОБОЧКИ <> ???

/*6. Выведите зарплату сотрудников как строку длины 5 символов; в
случае необходимости дополнить строку слева нулями до требуемой
длины.
Указание: использование LPAD.*/
SELECT LPAD(salary, 5, '0') FROM employees

/*7. Выведите имя, фамилию сотрудника и третьей колонкой
должность, заменив в ней встречающиеся символы '_' на '-'.
Отсортировать полученные результаты по суммарной длине имени и
фамилии, затем по первому и второму столбцам выборки.
Указание: использование LENGTH, REPLACE.*/
SELECT first_name, last_name, REPLACE(job_id, '_', '-') FROM employees ORDER BY LENGTH(first_name || last_name), first_name, last_name

/*8. Выведите имя, фамилию сотрудника, его email и четвертой
колонкой — email сотрудника, заменив в нем символы по
следующему соответствию: A-a, E-e, I-i, O-o, U-u, Y-y.
Указание: использование TRANSLATE.*/
SELECT first_name, last_name, email, TRANSLATE(email, 'AEIOUY', 'aeiouy') FROM employees

/*9. Выведите зарплату сотрудников компании в предположении, что из
нее вычли налог 12.5% в следующих колонках:
• low: округленная до целого снизу,
• up: округленная до целого сверху,
• round_k: округленная до сотен, в тысячах,
• trunk_k: усеченная до сотен, в тысячах.
Указание: использование ROUND, TRUNC, CEIL, FLOOR.*/
SELECT first_name, last_name, FLOOR(salary*0.87) AS "LOW", CEIL(salary*0.87) AS "UP", TO_NUMBER(ROUND(salary*0.87, -2)/1000) AS "ROUND_K", TO_NUMBER(TRUNC(salary*0.87, -2)/1000) AS "TRUNK_K" FROM employees

/*10. Выведите 'Yes', если в разложении числа 123456789 по степеням
двойки существует двойка в степени 10, и 'No' – иначе.
Указание: использование BITAND, POWER.*/
SELECT CASE BITAND(123456789, POWER(2,10)) WHEN POWER(2,10) THEN 'Yes' ELSE 'No' END  FROM dual

/*11. Выведите 'Yes', если число 3607 является делителем числа
123456789, и 'No' – иначе.
Указание: использование MOD.*/
SELECT CASE MOD(123456789,3607) WHEN 0 THEN 'Yes' ELSE 'No' END FROM dual

/*12. По таблице regions выведите первой колонкой с названием num
значение 'First', если идентификатор региона 1, 'Second', если 2, и
'Other' – во всех остальных случаях; далее вывести остальные столбцы
таблицы.*/
SELECT DECODE(region_id, 1, 'First', 2, 'Second', 'Other') AS "num", region_name FROM regions

/*13. Напишите запрос, выводящий все простые числа до N = 1000,
сложность алгоритма должна быть не больше, чем O(N∙sqrt (N)).*/

/*14. Предположим, что строка '$0,125' определяет одну единицу(здесь число в американском формате - запятая отделяет тысячи, а не дробную часть)
зарплаты в долларах. Выведите зарплату в упомянутых единицах,
комиссионные (например, как '0.12'),
зарплату (например, как
'$3,456'). Ведущих и хвостовых пробелов быть не должно. Для каждой
колонки используйте только функцию преобразования типов.*/
SELECT TO_NUMBER(salary/125), TRIM(TO_CHAR(salary*commission_pct, '$9999,999')), TRIM(TO_CHAR(commission_pct, '0D99'))  FROM employees WHERE commission_pct IS NOT NULL

/*15. Выведите сотрудников, фамилии которых начинаются с H или K,
содержат 2 одинаковые буквы подряд, оставшаяся после
повторяющихся букв часть слова не заканчивается на букву s.
Указание: использование REGEXP_LIKE.*/
SELECT * FROM employees WHERE last_name LIKE ('K%' OR last_name LIKE 'H%') AND REGEXP_LIKE() /*?????????? доделать*/

/*16. Выведите адрес и позицию второго буквенного символа,
входящего в эту строку.
Указание: использование REGEXP_INSTR.*/
SELECT street_address, REGEXP_INSTR(street_address, '[A-Za-z]', 1, 2) FROM locations

/*17. Выведите страну и вторым столбцом ту же строку с
исключенными гласными буквами, кроме первой.*/
SELECT country_name, REGEXP_REPLACE(country_name, '[AEIOUYaeiouy]', '', 2) FROM countries

/*18. Выведите адрес и подстроку из этого адреса, начинающуюся и
заканчивающуюся цифрой.
Решение: использование REGEXP_SUBSTR.*/
SELECT street_address, NVL2(REGEXP_SUBSTR(TRIM(TO_CHAR(street_address)), '^\d*'),REGEXP_SUBSTR(TRIM(TO_CHAR(street_address)), '^\d*'), REGEXP_SUBSTR(TRIM(TO_CHAR(street_address)), '\d*$')) FROM locations

/*19. Выведите текущую дату, время и часовой пояс в формате:
<ГОД-МЕС-ДЕНЬ ЧАС24:МИН:СЕК.милиСЕК(3 разряда) ПОЯС>.
Указание: использование SYSTIMESTAMP.*/
SELECT TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS.') || SUBSTR(TO_CHAR(SYSTIMESTAMP, 'FF'), 1, 3) || TO_CHAR(SYSTIMESTAMP, ' TZH:TZM') FROM dual 

/*21. Выведите дату приема на работу сотрудника, его имя, фамилию и
текущий стаж. Пример вывода стажа: 3 Years, 10 Months, 18 Days.
Указание: использование EXTRACT*/
SELECT hire_date, first_name, last_name, TRUNC((TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date))-MOD(TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)),12))/12) || ' Years, ' || MOD(TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)),12) || ' Months' FROM employees

/*22. Предположим, что в компании зарплата начисляется пятого числа
каждого месяца, зарплату сотрудник начинает получать, начиная со
следующего месяца после месяца приема на работу. Выведите дату
приема на работу и дату, когда сотруднику была выплачена первая
зарплата.*/
SELECT hire_date, TO_DATE(ADD_MONTHS(TRUNC(hire_date, 'MONTH'),1)+4) FROM employees

/*24. Почему при исполнении запроса SELECT * FROM locations
WHERE postal_code = 10934; могла возникнуть ошибка ORA-
01722: invalid number?
postal_code промимо цифровых символов содержит и другие символы*/

/*28. Выведите сотрудников, у которых комиссионные меньше 20% или
не указаны. Задачу решите с применением только одного предиката.
Указание: использование LNNVL.*/
SELECT * FROM employees WHERE LNNVL(0.2<=commission_pct) 

/*29. Выведите размер комиссионных (commission_pct * salary) и
0, если они отсутствуют с помощью функций NVL, COALESCE, NVL2,
DECODE, CASE.*/
SELECT first_name, last_name, NVL(commission_pct*salary, 0), COALESCE(commission_pct*salary, 0), NVL2(commission_pct*salary, commission_pct*salary, 0), DECODE(commission_pct*salary, null, 0, commission_pct*salary), CASE WHEN commission_pct*salary IS NULL THEN 0 ELSE commission_pct*salary END FROM employees

/*30*. Какое максимальное количество компонентов или аргументов
возможно в функциях DECODE, CASE, COALESCE?
максимальное количество компонентов, которые вы можете иметь в функции DECODE 255. Это включая expression, search и result аргументы.*/

/*
NW2-4*/
SELECT DISTINCT productname, NVL2(SUBSTR(TRIM(productname), 0, INSTR(TRIM(productname), ' ')), SUBSTR(TRIM(productname), 0, INSTR(TRIM(productname), ' ')), TRIM(productname)) FROM products ???? требуется меньше строк


/*3. Группировка данных*/

/*1. Выведите по всем сотрудникам максимальную, среднюю и
минимальную зарплату, суммарную зарплату всех сотрудников,
количество сотрудников и количество отделов, в которых состоят
сотрудники.*/
SELECT MAX(salary), AVG(salary), MIN(salary), SUM(salary), COUNT(employee_id), COUNT(DISTINCT department_id) FROM employees

/*2. Посчитайте количество сотрудников, у кого есть комиссионные,
средние комиссионные среди всех сотрудников и средние
комиссионные среди получающих их сотрудников.*/
SELECT COUNT(commission_pct), SUM(commission_pct)/COUNT(*), AVG(commission_pct) FROM employees

/*4. Выведите все номера отделов, в которых состоят сотрудники, и
максимальную зарплату по каждому и них.*/
SELECT department_id, MAX(salary) FROM employees GROUP BY department_id

/*5. Выведите номер отдела, должность и максимальную зарплату для
этой должности для отдела с id = 50. Выборку отсортировать по
максимальной зарплате для этой должности.*/
SELECT job_id, MAX(salary) FROM employees WHERE department_id=50 GROUP BY job_id ORDER BY MAX(salary)

/*6. Выведите номер отдела, должность, максимальную и минимальную
зарплату для этой должности в отделах с номером, не большим 50. В
выборку включить только те отделы, где минимальная зарплата по
должности больше 5000. Результат отсортировать по максимальной
зарплате.*/
SELECT department_id, job_id, MAX(salary), MIN(salary) FROM employees WHERE department_id<=50 GROUP BY job_id, department_id HAVING MIN(salary)>5000 ORDER BY MAX(salary)

/*7. Выведите максимальное значение средней зарплаты по отделам.
Результат округлите до ближайшего целого.*/
SELECT ROUND(MAX(AVG(salary))) FROM employees GROUP BY department_id

/*4. Подзапросы*/

/*1. Выведите информацию о сотрудниках с максимальной зарплатой
внутри компании.*/
SELECT * FROM employees WHERE salary=(SELECT MAX(salary) FROM employees) 

/*2. Выведите информацию о сотрудниках с максимальной зарплатой
внутри своего отдела.
Указание: решите задачу с использованием коррелированного
подзапроса.*/
SELECT * FROM employees e WHERE salary =(SELECT MAX(salary) FROM employees WHERE department_id=e.department_id)

/*3. Выведите информацию о сотрудниках с максимальной зарплатой
внутри своего отдела.
Указание: решите задачу с использованием некоррелированного
подзапроса во FROM.*/
SELECT e.* FROM employees e, (SELECT MAX(salary) AS max, department_id AS dep FROM employees GROUP BY department_id) d WHERE e.salary=d.max AND e.department_id=d.dep

/*4. Выведите информацию о сотрудниках с максимальной зарплатой
внутри своего отдела.
Указание: решите задачу с использованием некоррелированного
подзапроса и оператора IN.*/
SELECT * FROM employees WHERE (salary, department_id) IN(SELECT MAX(salary), department_id FROM employees GROUP BY department_id) 

/*5. Рассмотрите запрос:*/
SELECT e.* FROM employees e WHERE e.salary =
(SELECT MAX(salary) m FROM employees n
WHERE n.department_id = e.department_id);
/*Перепишите запрос, исключив алиасы там, где это возможно.*/
SELECT * FROM employees e WHERE salary=(SELECT MAX(salary) FROM employees
WHERE department_id = e.department_id)

/*6. Выведите информацию о тех сотрудниках, которые являются
менеджерами для других сотрудников.*/
SELECT * FROM employees WHERE employee_id IN(SELECT DISTINCT manager_id FROM employees)

/*7. Выведите информацию о тех сотрудниках, которые не являются
менеджерами для других сотрудников.
Указание: использование конструкции NOT IN.*/
SELECT * FROM employees WHERE employee_id NOT IN(SELECT DISTINCT manager_id FROM employees WHERE manager_id IS NOT NULL)

/*8. Выведите информацию о тех сотрудниках, зарплаты которых
больше, чем средняя зарплата в каждом из отделов.
Указание: использование оператора сравнения с оператором ALL.*/
SELECT * FROM employees WHERE salary > ALL(SELECT AVG(salary) FROM employees GROUP BY department_id)

/*9. Выведите информацию о тех сотрудниках, зарплаты которых
больше, чем средняя зарплата хотя бы в одном из отделов.
Указание: использование операторов сравнения с операторами
SOME/ANY.*/
SELECT * FROM employees WHERE salary > ANY(SELECT AVG(salary) FROM employees GROUP BY department_id)

/*10. Выведите тех сотрудников, у которых в трудовой истории
(таблица job_history) есть запись о работе в должности
ST_CLERK.
Указание: использование оператора EXISTS.*/
SELECT e.* FROM employees e WHERE EXISTS(SELECT NULL FROM job_history WHERE e.employee_id=employee_id AND job_id='ST_CLERK')

/*11*. С помощью EXPLAIN PLAN и DBMS_XPLAN покажите, что
предикат в запросе*/
SELECT * FROM dual WHERE dummy NOT IN ('X', NULL);
/*преобразуется к виду dummy <> 'X' AND dummy <> NULL.*/

/*5. Операторы DML*/
/*1. В таблицу employees добавьте следующего сотрудника: Alexey
Vasiliev, с электронной почтой: AVASILIEV, на должность IT_PROG,
id сотрудника — 42, id менеджера — 100, принят на работу в 00:00
часов текущей даты.*/
INSERY INTO employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) VALUES ('Alexey', 'Vasiliev', 'AVASILIEV', null, SYSDATE????)

/*6. Операторы работы с множествами*/




SELECT LTRIM(SYS_CONNECT_PATH(t.name, ','),',') FROM (SELECT name FROM staff WHERE 
unit_id=(SELECT unit_id FROM military_units WHERE name='	
Squad #1')) t CONNECT BY level< (SELECT COUNT(*) FROM staff WHERE unit_id=(SELECT unit_id FROM military_units WHERE name='	
Squad #1'))+1

