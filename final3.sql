-- 1. Create a database named banks_portal.
CREATE DATABASE banks_portal;

-- 2. Use the previously created database.
USE banks_portal;

-- 3. Create a table named accounts.
CREATE TABLE accounts (
    accountId INT NOT NULL AUTO_INCREMENT,
    ownerName VARCHAR(45) NOT NULL,
    owner_ssn INT NOT NULL,
    balance DECIMAL(10,2) DEFAULT 0.00,
    account_status VARCHAR(45),
    PRIMARY KEY (accountId)
);

-- 4. Create a table named Transactions if it does not exist.
CREATE TABLE IF NOT EXISTS Transactions (
    transactionId INT NOT NULL AUTO_INCREMENT,
    accountID INT NOT NULL,
    transactionType VARCHAR(45) NOT NULL,
    transactionAmount DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (transactionId)
);

-- 5. Populate the table accounts with the given values.
INSERT INTO accounts (ownerName, owner_ssn, balance, account_status)
VALUES
    ("Maria Jozef", 123456789, 10000.00, "active"),
    ("Linda Jones", 987654321, 2600.00, "inactive"),
    ("John McGrail", 222222222, 100.50, "active"),
    ("Patty Luna", 111111111, 509.75, "inactive");

-- 6. Populate the table Transactions with the given values.
INSERT INTO Transactions (accountID, transactionType, transactionAmount)
VALUES
    (1, "deposit", 650.98),
    (3, "withdraw", 899.87),
    (3, "deposit", 350.00);

-- 7. Create a stored Procedure named accountTransactions.
DELIMITER //
CREATE PROCEDURE accountTransactions(IN accountID INT)
BEGIN
    SELECT * FROM Transactions WHERE accountID = accountID;
END //
DELIMITER ;

-- 8. Create a stored Procedure named deposit.
DELIMITER //
CREATE PROCEDURE deposit(IN accountID INT, IN amount DECIMAL(10,2))
BEGIN
    INSERT INTO Transactions (accountID, transactionType, transactionAmount)
    VALUES (accountID, "deposit", amount);
    
    UPDATE accounts
    SET balance = balance + amount
    WHERE accountId = accountID;
END //
DELIMITER ;

-- 9. Create a stored Procedure named withdraw.
DELIMITER //
CREATE PROCEDURE withdraw(IN accountID INT, IN amount DECIMAL(10,2))
BEGIN
    INSERT INTO Transactions (accountID, transactionType, transactionAmount)
    VALUES (accountID, "withdraw", amount);
    
    UPDATE accounts
    SET balance = balance - amount
    WHERE accountId = accountID;
END //
DELIMITER ;
