-- Create the library database
CREATE DATABASE library;

-- Switch to the library database
USE library;

-- Create the Branch table
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);

-- Create the Employee table
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(255),
    Position VARCHAR(255),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

-- Create the Customer table
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(255),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

-- Create the IssueStatus table
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(13),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);


-- Create the ReturnStatus table
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(13),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

-- Create the Books table
CREATE TABLE Books (
    ISBN VARCHAR(13) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(255),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(3),
    Author VARCHAR(255),
    Publisher VARCHAR(255)
);

-- Inserting more values into the Books table
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES 
('1111111111111', '1984', 'Dystopian', 11.99, 'yes', 'George Orwell', 'Secker & Warburg'),
('2222222222222', 'The Hobbit', 'Fantasy', 13.99, 'yes', 'J.R.R. Tolkien', 'Allen & Unwin'),
('3333333333333', 'Pride and Prejudice', 'Romance', 10.49, 'yes', 'Jane Austen', 'Thomas Egerton'),
('4444444444444', 'The Alchemist', 'Fantasy', 14.99, 'yes', 'Paulo Coelho', 'HarperCollins'),
('6666666666666', 'The Lord of the Rings', 'Fantasy', 15.99, 'yes', 'J.R.R. Tolkien', 'Allen & Unwin');


#1
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';


-- Inserting values into the Employee table
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES 
(1, 'John Doe', 'Manager', 50000.00, 1),
(2, 'Jane Smith', 'Assistant Manager', 40000.00, 2),
(3, 'Bob Johnson', 'Clerk', 30000.00, 3),
(4, 'Alice Brown', 'Clerk', 30000.00, 4);


-- Inserting values into the Branch table
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES 
(1, 101, '123 Main Street', '555-1234'),
(2, 102, '456 Oak Avenue', '555-5678'),
(3, 103, '789 Pine Lane', '555-9012'),
(4, 104, '321 Elm Street', '555-3456');


#2
SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

-- Inserting values into the Customer table
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES 
(1, 'Mary Johnson', '789 Oak Street', '2022-01-01'),
(2, 'David Smith', '456 Maple Avenue', '2022-02-15'),
(3, 'Emily Davis', '123 Pine Lane', '2022-03-20');


-- Inserting values into the IssueStatus table

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES 
(1, 1, 'The Great Gatsby', '2022-01-10', '1234567890123');
-- Inserting values into the ReturnStatus table
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES 
(1, 1, 'The Great Gatsby', '2022-02-05', '1234567890123'),
(2, 2, 'To Kill a Mockingbird', '2022-03-10', '9876543210987'),
(3, 3, 'The Hobbit', '2022-04-05', '2222222222222');
-- Add more INSERT statements for additional returned books as needed
-- Inserting a book into the Books table
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES 
('1234567890123', 'The Great Gatsby', 'Fiction', 10.99, 'yes', 'F. Scott Fitzgerald', 'Scribner');

-- Inserting a customer into the Customer table
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES 
(1, 'Mary Johnson', '789 Oak Street', '2022-01-01');

-- Inserting values into the IssueStatus table
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES 
(1, 1, 'The Great Gatsby', '2022-01-10', '1234567890123');


#3
SELECT Books.Book_title, Customer.Customer_name
FROM Books
JOIN IssueStatus ON Books.ISBN = IssueStatus.Isbn_book
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;

#4
SELECT Category, COUNT(*) AS TotalBooks
FROM Books
GROUP BY Category;

#5
SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES 
(5, 'John Doe', 'Manager', 80000.00, 1);

#6
SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01'
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);


-- Inserting values into the Customer table
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES 
(4, 'John Smith', '123 Main Street', '2021-12-15'),
(5, 'Emily Davis', '456 Oak Avenue', '2021-11-20'),
(6, 'Michael Johnson', '789 Pine Lane', '2021-10-05');

-- Inserting values into the IssueStatus table (to simulate not issuing any books)
-- No records are inserted since we want customers who have not issued any books 

#7
SELECT Branch_no, COUNT(*) AS TotalEmployees
FROM Employee
GROUP BY Branch_no;

-- Inserting values into the IssueStatus table for June 2023
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES 
(2, 2, 'Harry Potter', '2023-06-05', '1234567890123'),
(3, 3, 'Narnia', '2023-06-10', '9876543210987'),
(4, 4, 'Goosebumps', '2023-06-15', '2222222222222');
-- Add more INSERT statements for additional issued books in June 2023

select * from IssueStatus;

#8
SELECT DISTINCT Customer.Customer_name
FROM Customer
JOIN IssueStatus ON Customer.Customer_Id = IssueStatus.Issued_cust
WHERE MONTH(IssueStatus.Issue_date) = 6 AND YEAR(IssueStatus.Issue_date) = 2023;


#9
SELECT book_title
FROM Books
WHERE Category = 'History';
#10
SELECT Branch_no, COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;















