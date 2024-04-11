create database BMS_DB2;

use BMS_DB2;

show databases;

-- Create table for customers
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(255),
    Customer_Address VARCHAR(255),
    Customer_Phone VARCHAR(20),
    Gender VARCHAR(10),
    Customer_email VARCHAR(100)
);

-- Create table for accounts
CREATE TABLE Accounts (
    Account_ID INT PRIMARY KEY,
    Customer_ID INT,
    AccountName_Type VARCHAR(50),
    Balance DECIMAL(10, 2),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- Create table for account types
CREATE TABLE Account_Types (
    AccountType_ID INT PRIMARY KEY,
    AccountType_Name VARCHAR(50)
);

-- Create table for interest rates
CREATE TABLE InterestRates (
    AccountType_ID INT,
    Interest_Rate DECIMAL(5, 2),
    FOREIGN KEY (AccountType_ID) REFERENCES Account_Types(AccountType_ID)
);

-- Create table for bank
CREATE TABLE Bank(
Bank_ID INT primary key,
Bank_Name varchar(20) not null,
Bank_Address varchar(20)
); 

-- Create table for bank branches
CREATE TABLE Branches (
    Bank_ID INT,
    Branch_ID INT PRIMARY KEY,
    Branch_Name VARCHAR(100) not null,
    Branch_Address VARCHAR(255),
    FOREIGN KEY(bank_ID) REFERENCES BANK
);

-- Create table for transactions
CREATE TABLE Transactions (
    Transaction_ID INT PRIMARY KEY,
    Account_ID INT,
    Amount DECIMAL(10, 2),
    Transaction_Date DATE,
    Transaction_Type VARCHAR(50),
    FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID)
);

-- Add status field to Accounts table
ALTER TABLE Accounts ADD COLUMN Status VARCHAR(20) DEFAULT 'Active';

-- Create table for account status changes
CREATE TABLE AccountStatus_Changes (
    Change_ID INT PRIMARY KEY, 
    Account_ID INT,
    Old_Status VARCHAR(20),
    New_Status VARCHAR(20),
    Change_Date  date,
    FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID)
);

-- Insert sample data into Customers table
INSERT INTO Customers (Customer_ID, Customer_Name, Customer_Address, Customer_Phone, Gender, Customer_email)
VALUES
    (1, 'Tanya Singh', '123 London St', '555-1234', 'Female', 'taniya55@gmail.com' ),
    (2, 'Shubh Dhingra', '456 New York St', '555-5678', 'Male', 'shubh45@gmail.com'),
	(3, 'Tarang Kumar', '762 France St', '555-7954', 'Male', 'tarang725@gmail.com'),
    (4, 'Muskan Saini', 'Milan Vihar St', '555-8967', 'Female', 'muskan98@gmail.com'),
    (5, 'Varun Saini', 'Kashiram St', '555-9988', 'Male', 'varun89755@gmail.com' );
    
-- Insert sample data into Accounts table
INSERT INTO Accounts (Account_ID, Customer_ID, AccountName_Type, Balance)
VALUES
    (101, 1, 'Savings', 500000.00),
    (102, 2, 'Checking', 800000.00),
    (103, 3, 'Savings', 400000.00),
	(104, 4, 'Checking', 500000.00),
    (105, 5, 'Savings', 200000.00);
    
-- Insert sample data into Account_Types table
INSERT INTO Account_Types (AccountType_ID, AccountType_Name)
VALUES
    (010, 'Savings'), 
    (020, 'Checking'),
    (030, 'Savings'),
    (040, 'Checking'),
    (050, 'Savings');

-- Insert sample data into InterestRates table    
    INSERT INTO  InterestRates (AccountType_ID,Interest_Rate)
    VALUES
    (010, '1.5'), -- Savings account with 1.5% interest rate
    (020, '2'),   --  Checking account with 2% interest rate
    (030, '2.5'), -- Savings account with 2.5% interest rate
    (040, '3'),   -- Checking account with 3% interest rate
    (050, '2.75'); -- Savings account with 2.75% interest rate

-- Insert sample data into Bank table
INSERT INTO Bank (Bank_ID, Bank_Name, Bank_Address)
VALUES
(201,'SBI','Godha colony'),
(202,'PNB','Rajwada'),
(203,'MET','Geeta colony'),
(204,'SWISS','Baker street'),
(205,'NXI','Putin Hall');

 -- Insert sample data into branch table
 INSERT INTO Branches (Bank_ID,Branch_ID,Branch_Name, Branch_Address)
 VALUES
(100,101,'Delhi','Gandhi Nagar'),
(200,102,'Punjab','Chandigarh'),
(300,103,'M.P','Vijay Nagar'),
(400,104,'Bangalore','Lalbagh'),
(500,105,'Assam','Kaziranga');
 
-- Insert sample data into Transactions table
INSERT INTO Transactions (Transaction_ID, Account_ID, Amount, Transaction_Date, Transaction_Type)
VALUES
    (1001, 101, 10000.00, '2024-04-10', 'Deposit'),
    (1002, 102, 50000.00, '2024-04-11', 'Withdrawal'),
	(1003, 103, 20000.00, '2024-04-12', 'Deposit'),
    (1004, 104, 30000.00, '2024-04-13', 'Withdrawal'),
    (1005, 105, 40000.00, '2024-04-14', 'Deposit');
  
 -- Insert sample data into AccountStatus_Changes table
 INSERT INTO AccountStatus_Changes (Change_ID, Account_ID, Old_Status, New_Status, Change_Date)
 VALUES
    (2001, 101, 'Inactive', 'Active', '2024-03-13'),
    (2002, 102, 'Active', 'Inactive', '2024-03-15'),
    (2003, 103, 'Inactive', 'Active', '2024-03-18'),
    (2004, 104, 'Active', 'Inactive', '2024-03-24'),
    (2005, 105,'Active' ,'Inactive', '2024-03-28');
    
-- Query to retrieve customer information and their account balances
SELECT c.Customer_Name, c.Customer_Address, c.Gender, a.AccountName_Type, a.Balance
FROM Customers c
JOIN Accounts a ON c.Customer_ID = a.Customer_ID;

-- Query to retrieve information from Bank table
SELECT * FROM Bank;

-- Query to retrieve information from Branch table
SELECT * FROM Branches;

-- Query to retrieve information from Account_Types table and their interest rates
SELECT aType.AccountType_ID, aType.AccountType_Name, iR.Interest_Rate
FROM Account_Types aType
JOIN InterestRates iR ON aType.AccountType_ID = iR.AccountType_ID;

-- Query to retrieve transaction history for all accounts
SELECT t.Transaction_ID, t.Transaction_Date, t.Amount, t.Transaction_Type
FROM Transactions t
JOIN Accounts a ON t.Account_ID = a.Account_ID;

-- Query to retrieve transaction history for an account
SELECT t.Transaction_ID, t.Transaction_Date, t.Amount, t.Transaction_Type
FROM Transactions t
JOIN Accounts a ON t.Account_ID = a.Account_ID
WHERE a.Account_ID = 101;  -- Replace 101 with the desired account ID

-- Query to retrieve information about account status before change and after change
SELECT s.Change_ID, a.Account_ID, s.Old_Status, s.New_Status, s.Change_Date
FROM AccountStatus_Changes s
JOIN Accounts a ON s.Account_ID = a.Account_ID;

-- Query to retrieve information for an account status before change and after change
SELECT s.Change_ID, a.Account_ID, s.Old_Status, s.New_Status, s.Change_Date
FROM AccountStatus_Changes s
JOIN Accounts a ON s.Account_ID = a.Account_ID
WHERE a.Account_ID = 104;  -- Replace 104 with the desired account ID


-- To calculate total balance across all accounts
SELECT SUM(Balance) AS Total_Balance
FROM Accounts;


     
    
    
    
    
    
    
    
    
    
    
    



