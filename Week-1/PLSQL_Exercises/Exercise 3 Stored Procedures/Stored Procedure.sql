use bankdb

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    AccountType VARCHAR(20),
    Balance DECIMAL(12,2)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Accounts VALUES
(101,'Ravi','Savings',50000),
(102,'Priya','Savings',30000),
(103,'Kiran','Current',70000),
(104,'Anu','Savings',40000);

INSERT INTO Employees VALUES
(1,'John','IT',50000),
(2,'David','IT',60000),
(3,'Mary','HR',45000),
(4,'Smith','HR',55000);


DELIMITER //

CREATE PROCEDURE ProcessMonthlyInterest()
BEGIN

    UPDATE Accounts
    SET Balance = Balance + (Balance * 0.01)
    WHERE AccountType = 'Savings';

END //

DELIMITER ;


CALL ProcessMonthlyInterest();

SELECT * FROM Accounts;



DELIMITER //

CREATE PROCEDURE UpdateEmployeeBonus(
    IN dept VARCHAR(50),
    IN bonusPercent DECIMAL(5,2)
)
BEGIN

    UPDATE Employees
    SET Salary = Salary +
                 (Salary * bonusPercent / 100)
    WHERE Department = dept;

END //

DELIMITER ;



SELECT * FROM Employees;


DELIMITER //

CREATE PROCEDURE TransferFunds(
    IN fromAccount INT,
    IN toAccount INT,
    IN amount DECIMAL(10,2)
)
BEGIN

    DECLARE sourceBalance DECIMAL(10,2);

    SELECT Balance
    INTO sourceBalance
    FROM Accounts
    WHERE AccountID = fromAccount;

    IF sourceBalance >= amount THEN

        UPDATE Accounts
        SET Balance = Balance - amount
        WHERE AccountID = fromAccount;

        UPDATE Accounts
        SET Balance = Balance + amount
        WHERE AccountID = toAccount;

        SELECT 'Transfer Successful' AS Message;

    ELSE

        SELECT 'Insufficient Balance' AS Message;

    END IF;

END //

DELIMITER ;

CALL TransferFunds(101,102,5000);