\c skypro;

/*Задание 1
1. Создайте таблицу city с колонками city_id и city_name.*/
CREATE TABLE city(
    city_id BIGSERIAL NOT NULL PRIMARY KEY,
    city_name VARCHAR(50)
);
/* Добавьте в таблицу employee колонку city_id. */
ALTER TABLE employee ADD COLUMN city_id INT;
/* Назначьте эту колонку внешним ключом. Свяжите таблицу employee с таблицей city. */
ALTER TABLE employee ADD FOREIGN KEY (city_id) REFERENCES city(city_id);
/* Заполните таблицу city и назначьте работникам соответствующие города. */
INSERT INTO city(city_name) VALUES ('Москва'), ('Санкт-Петербург'), ('Казань'), ('Нижний Новгород'), ('Екатеринбург');
UPDATE employee SET city_id = 1 WHERE id=1;
UPDATE employee SET city_id = 2 WHERE id=2;
UPDATE employee SET city_id = 3 WHERE id=3;
UPDATE employee SET city_id = 4 WHERE id=4;
UPDATE employee SET city_id = 5 WHERE id=5;

/*Задание 2
Получите имена и фамилии сотрудников, а также города, в которых они проживают.*/
/* вариант_1 - без оператора JOIN */
SELECT first_name, last_name, city_name FROM  city, employee WHERE employee.id = city.city_id;
/* вариант_2 - с использованием JOIN */
SELECT first_name, last_name, city_name FROM city JOIN employee e ON city.city_id = e.city_id;
/* Получите города, а также имена и фамилии сотрудников, которые в них проживают.
   Если в городе никто из сотрудников не живет, то вместо имени должен стоять null.*/
INSERT INTO city(city_name) VALUES ('Новосибирск');
SELECT city_name, first_name, last_name FROM city c LEFT JOIN employee e ON c.city_id = e.city_id;
/*Получите имена всех сотрудников и названия всех городов.
  Если в городе не живет никто из сотрудников, то вместо имени должен стоять null.
  Аналогично, если города для какого-то из сотрудников нет в списке, должен быть получен null.*/
INSERT INTO employee(first_name, last_name, gender, age, city_id) VALUES ('Михаил', 'Медведев', 'муж', 45, NULL);
SELECT city_name, first_name, last_name FROM city c FULL OUTER JOIN employee e ON c.city_id = e.city_id;
/* Получите таблицу, в которой каждому имени должен соответствовать каждый город. */
/* вариант_1 */
SELECT first_name, last_name, city_name FROM employee CROSS JOIN city ORDER BY first_name;
/* вариант_2 */
SELECT first_name, last_name, city_name FROM employee, city ORDER BY first_name;
/*Получите имена городов, в которых никто не живет.*/
SELECT city_name, first_name, last_name FROM city LEFT JOIN employee ON city.city_id = employee.city_id WHERE employee.city_id IS NULL;
/* ИЛИ */
SELECT city.* FROM city LEFT JOIN employee ON city.city_id = employee.city_id WHERE employee.city_id IS NULL ;

