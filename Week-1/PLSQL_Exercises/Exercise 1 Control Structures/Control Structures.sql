CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Age INT,
    Balance DECIMAL(10,2),
    IsVIP BOOLEAN DEFAULT FALSE
);


CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    CustomerID INT,
    InterestRate DECIMAL(5,2),
    DueDate DATE,
    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
);

INSERT INTO Customers VALUES
(1,'Ravi',65,15000,FALSE),
(2,'Priya',45,8000,FALSE),
(3,'Kiran',70,12000,FALSE),
(4,'Anu',30,5000,FALSE);

INSERT INTO Loans VALUES
(101,1,8.5,'2026-07-15'),
(102,2,9.0,'2026-08-10'),
(103,3,7.5,'2026-07-20'),
(104,4,10.0,'2026-09-15');


DELIMITER //

CREATE PROCEDURE ApplyDiscount()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE c_id INT;
    DECLARE c_age INT;

    DECLARE cur CURSOR FOR
    SELECT CustomerID, Age
    FROM Customers;

    DECLARE CONTINUE HANDLER
    FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP

        FETCH cur INTO c_id, c_age;

        IF done THEN
            LEAVE read_loop;
        END IF;

        IF c_age > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE CustomerID = c_id;
        END IF;

    END LOOP;

    CLOSE cur;
END //

DELIMITER ;

CALL ApplyDiscount();

SELECT * FROM Loans;


DELIMITER //

CREATE PROCEDURE SetVIP()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE c_id INT;
    DECLARE c_balance DECIMAL(10,2);

    DECLARE cur CURSOR FOR
    SELECT CustomerID, Balance
    FROM Customers;

    DECLARE CONTINUE HANDLER
    FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    vip_loop: LOOP

        FETCH cur INTO c_id, c_balance;

        IF done THEN
            LEAVE vip_loop;
        END IF;

        IF c_balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = TRUE
            WHERE CustomerID = c_id;
        END IF;

    END LOOP;

    CLOSE cur;
END //

DELIMITER ;

SELECT * FROM Customers;


DELIMITER //

CREATE PROCEDURE LoanReminder()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE c_name VARCHAR(50);
    DECLARE due_date DATE;

    DECLARE cur CURSOR FOR
    SELECT CustomerName, DueDate
    FROM Customers c
    JOIN Loans l
    ON c.CustomerID = l.CustomerID
    WHERE DueDate BETWEEN CURDATE()
    AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);

    DECLARE CONTINUE HANDLER
    FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    reminder_loop: LOOP

        FETCH cur INTO c_name, due_date;

        IF done THEN
            LEAVE reminder_loop;
        END IF;

        SELECT CONCAT(
            'Reminder: ',
            c_name,
            ' loan due on ',
            due_date
        ) AS Message;

    END LOOP;

    CLOSE cur;
END //

DELIMITER ;

CALL LoanReminder();