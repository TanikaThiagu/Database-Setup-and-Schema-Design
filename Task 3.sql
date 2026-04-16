SELECT * 
FROM Students;

SELECT name, age 
FROM Students;

SELECT * 
FROM Students
WHERE age > 18;

SELECT * 
FROM Students
WHERE age > 18 AND city = 'Madurai';

SELECT * 
FROM Students
WHERE age < 18 OR city = 'Chennai';

SELECT * 
FROM Students
WHERE name LIKE 'A%';   

SELECT * 
FROM Students
WHERE age BETWEEN 18 AND 22;

SELECT * 
FROM Students
ORDER BY age ASC;

SELECT * 
FROM Students
ORDER BY age DESC;