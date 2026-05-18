CREATE DATABASE AirlineReservationSystem;
USE AirlineReservationSystem;

CREATE TABLE Flights (
    flight_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_number VARCHAR(10) UNIQUE NOT NULL,
    source VARCHAR(50) NOT NULL,
    destination VARCHAR(50) NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    total_seats INT NOT NULL,
    available_seats INT NOT NULL,
    ticket_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE
);

CREATE TABLE Seats (
    seat_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_id INT,
    seat_number VARCHAR(10),
    seat_class VARCHAR(20),
    seat_status VARCHAR(20) DEFAULT 'Available',

    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    flight_id INT,
    seat_id INT,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    booking_status VARCHAR(20) DEFAULT 'Confirmed',

    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id),
    FOREIGN KEY (seat_id) REFERENCES Seats(seat_id)
);












INSERT INTO Flights
(flight_number, source, destination, departure_time, arrival_time,
 total_seats, available_seats, ticket_price)
VALUES
('AI101', 'Chennai', 'Delhi',
 '2026-06-01 08:00:00',
 '2026-06-01 11:00:00',
 180, 180, 5500),

('AI202', 'Mumbai', 'Bangalore',
 '2026-06-02 09:30:00',
 '2026-06-02 11:15:00',
 150, 150, 4200);
 
 INSERT INTO Customers
(first_name, last_name, email, phone)
VALUES
('Rahul', 'Sharma', 'rahul@gmail.com', '9876543210'),

('Priya', 'Kumar', 'priya@gmail.com', '9876501234');

INSERT INTO Seats
(flight_id, seat_number, seat_class)
VALUES
(1, 'A1', 'Business'),
(1, 'A2', 'Business'),
(1, 'B1', 'Economy'),
(2, 'C1', 'Economy');

INSERT INTO Bookings
(customer_id, flight_id, seat_id)
VALUES
(1, 1, 1),
(2, 1, 2);

SELECT *
FROM Flights
WHERE source = 'Chennai'
AND destination = 'Delhi';

SELECT flight_number, available_seats
FROM Flights;

SELECT b.booking_id,
       c.first_name,
       f.flight_number,
       s.seat_number,
       b.booking_status
FROM Bookings b
JOIN Customers c
ON b.customer_id = c.customer_id
JOIN Flights f
ON b.flight_id = f.flight_id
JOIN Seats s
ON b.seat_id = s.seat_id;

DELIMITER $$

CREATE TRIGGER after_booking_insert
AFTER INSERT ON Bookings
FOR EACH ROW
BEGIN

    UPDATE Flights
    SET available_seats = available_seats - 1
    WHERE flight_id = NEW.flight_id;

    UPDATE Seats
    SET seat_status = 'Booked'
    WHERE seat_id = NEW.seat_id;

END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER after_booking_cancel
AFTER UPDATE ON Bookings
FOR EACH ROW
BEGIN

    IF NEW.booking_status = 'Cancelled' THEN

        UPDATE Flights
        SET available_seats = available_seats + 1
        WHERE flight_id = NEW.flight_id;

        UPDATE Seats
        SET seat_status = 'Available'
        WHERE seat_id = NEW.seat_id;

    END IF;

END$$

DELIMITER ;

CREATE VIEW FlightAvailability AS
SELECT flight_number,
       source,
       destination,
       departure_time,
       available_seats
FROM Flights;

SELECT b.booking_id,
       CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       f.flight_number,
       f.source,
       f.destination,
       s.seat_number,
       b.booking_status,
       b.booking_date
FROM Bookings b
JOIN Customers c
ON b.customer_id = c.customer_id
JOIN Flights f
ON b.flight_id = f.flight_id
JOIN Seats s
ON b.seat_id = s.seat_id
ORDER BY b.booking_date DESC;