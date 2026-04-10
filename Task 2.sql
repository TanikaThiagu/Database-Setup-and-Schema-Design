use library_db;

CREATE TABLE Students (
    id INTEGER PRIMARY KEY,
    name TEXT,
    age INTEGER,
    email TEXT
);

INSERT INTO Students (id, name, age, email)
VALUES (1, 'Alice', 20, 'alice@email.com');

INSERT INTO Students (id, name, age, email)
VALUES (2, 'Bob', NULL, NULL);

INSERT INTO Students (id, name)
VALUES (3, 'Charlie');

SELECT * FROM Students;

SELECT * FROM Students
WHERE age IS NULL;

SET SQL_SAFE_UPDATES = 0;

UPDATE Students
SET age = 18
WHERE age IS NULL;

UPDATE Students
SET email = 'bob@email.com'
WHERE id = 2;

DELETE FROM Students
WHERE id = 3;

DELETE FROM Students
WHERE age < 18;

SELECT * FROM Students;