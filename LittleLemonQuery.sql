USE littlelemondb;

-- ======================================================
-- VIEWS & QUERIES
-- ======================================================

-- Task 1: Create OrdersView for orders with quantity > 2
CREATE OR REPLACE VIEW OrdersView AS
SELECT idOrders, quantity, total_cost
FROM Orders
WHERE quantity > 2;

SELECT * FROM OrdersView;

-- Task 2: Customers with orders costing more than $150
SELECT 
    c.idcustomer, 
    c.customer_names, 
    o.idOrders, 
    o.total_cost, 
    m.Menu_name, 
    mi.courses
FROM Customer c
JOIN Orders o ON c.idcustomer = o.Customer_idcustomer
JOIN Menu m ON o.Menu_idMenu = m.idMenu
JOIN Menu_Items mi ON mi.Menu_idMenu = m.idMenu
WHERE o.total_cost > 150
ORDER BY o.total_cost ASC;

-- Task 3: Menu items with more than 2 orders
SELECT m.Menu_name
FROM Menu m
WHERE m.idMenu IN (
    SELECT o.Menu_idMenu
    FROM Orders o
    WHERE o.quantity > 2
);


-- ======================================================
-- PROCEDURES & PREPARED STATEMENTS
-- ======================================================

-- Task 1: Procedure to get max ordered quantity
DELIMITER //
CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(quantity) AS 'Max Quantity in Order'
    FROM Orders;
END //
DELIMITER ;

CALL GetMaxQuantity();

-- Task 2: Prepared statement for order details by customer
PREPARE GetOrderDetail FROM 
'SELECT idOrders, quantity, total_cost
 FROM Orders
 WHERE Customer_idcustomer = ?';

SET @idCustomer = 1;
EXECUTE GetOrderDetail USING @idCustomer;
DEALLOCATE PREPARE GetOrderDetail;

-- Task 3: Cancel order procedure
DELIMITER //
CREATE PROCEDURE CancelOrder(IN in_idOrders INT)
BEGIN
    DELETE FROM Orders
    WHERE idOrders = in_idOrders;
    
    SELECT CONCAT('Order ', in_idOrders, ' cancelled') AS Status;
END //
DELIMITER ;

CALL CancelOrder(5);


-- ======================================================
-- BOOKINGS INSERTS
-- ======================================================
INSERT INTO Customer (idcustomer, customer_names, contact_details)
VALUES
(1, 'Alice Smith', 'alice@example.com'),
(2, 'Bob Johnson', 'bob@example.com'),
(3, 'Charlie Lee', 'charlie@example.com');


INSERT INTO Bookings (idBookings, booking_date, table_number, Customer_idcustomer)
VALUES
(1, '2022-10-10', 5, 1),
(2, '2022-11-12', 3, 3),
(3, '2022-10-11', 2, 2),
(4, '2022-10-13', 2, 1);


-- ======================================================
-- BOOKING PROCEDURES
-- ======================================================

-- Task 1: CheckBooking
DELIMITER //
CREATE PROCEDURE CheckBooking(IN in_booking_date DATE, IN in_table_number INT)
BEGIN
    DECLARE bookingExists INT;
    
    SELECT COUNT(*) INTO bookingExists
    FROM Bookings
    WHERE booking_date = in_booking_date 
      AND table_number = in_table_number;
    
    IF bookingExists > 0 THEN
        SELECT CONCAT('Table ', in_table_number, ' is already booked on ', in_booking_date) AS Message;
    ELSE
        SELECT CONCAT('Table ', in_table_number, ' is available on ', in_booking_date) AS Message;
    END IF;
END //
DELIMITER ;

CALL CheckBooking('2022-11-12', 3);


-- Task 2: AddValidBooking
DELIMITER //
CREATE PROCEDURE AddValidBooking(
    IN inBookingDate DATE,
    IN inTableNumber INT,
    IN inCustomerId INT
)
BEGIN
    DECLARE bookingExists INT;

    START TRANSACTION;

    SELECT COUNT(*) INTO bookingExists
    FROM Bookings
    WHERE booking_date = inBookingDate AND table_number = inTableNumber;

    IF bookingExists > 0 THEN
        ROLLBACK;
        SELECT CONCAT('Booking failed: Table ', inTableNumber, 
                      ' is already booked on ', inBookingDate) AS Status;
    ELSE
        INSERT INTO Bookings (booking_date, table_number, Customer_idcustomer)
        VALUES (inBookingDate, inTableNumber, inCustomerId);

        COMMIT;
        SELECT CONCAT('Booking confirmed: Table ', inTableNumber, 
                      ' booked on ', inBookingDate) AS Status;
    END IF;
END //
DELIMITER ;


-- ======================================================
-- BOOKING MANAGEMENT PROCEDURES
-- ======================================================

-- Task 1: AddBooking
DELIMITER //
CREATE PROCEDURE AddBooking(
    IN in_idBookings INT,
    IN in_booking_date DATE,
    IN in_table_number INT,
    IN in_idCustomer INT
)
BEGIN
    INSERT INTO Bookings (idBookings, booking_date, table_number, Customer_idcustomer)
    VALUES (in_idBookings, in_booking_date, in_table_number, in_idCustomer);
END //
DELIMITER ;

CALL AddBooking(5, '2022-12-01', 4, 2);


-- Task 2: UpdateBooking
DELIMITER //
CREATE PROCEDURE UpdateBooking(
    IN in_idBookings INT,
    IN in_booking_date DATE
)
BEGIN
    UPDATE Bookings
    SET booking_date = in_booking_date
    WHERE idBookings = in_idBookings;
END //
DELIMITER ;

CALL UpdateBooking(2, '2022-12-15');


-- Task 3: CancelBooking
DELIMITER //
CREATE PROCEDURE CancelBooking(IN in_idBookings INT)
BEGIN     
    DELETE FROM Bookings
    WHERE idBookings = in_idBookings;
    
    SELECT CONCAT('Booking ', in_idBookings, ' cancelled') AS Status; 
END //
DELIMITER ;

CALL CancelBooking(3);
