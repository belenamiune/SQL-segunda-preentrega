-- Created by belenamiune (https://github.com/belenamiune)

DROP DATABASE IF EXISTS library;
CREATE DATABASE library;

USE library;

-- Table: USERTYPES
CREATE TABLE USERTYPES (
    User_Type INT PRIMARY KEY AUTO_INCREMENT NOT NULL, 
    User_Type_Name VARCHAR(50) NOT NULL, 
    Description VARCHAR(255)
);

-- Table: USER
CREATE TABLE USER (
    User_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    User_Name VARCHAR(100) NOT NULL,
    Address VARCHAR(150),
    Phone VARCHAR(15),
    Email VARCHAR(100) NOT NULL,
    User_Type INT(50) NOT NULL
);


-- Table: LIBRARIAN
CREATE TABLE LIBRARIAN (
    Librarian_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Librarian_Name VARCHAR(100) NOT NULL,
    Shift VARCHAR(50)
);

-- Table: CATEGORY
CREATE TABLE CATEGORY (
    Category_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Category_Name VARCHAR(100) NOT NULL,
    Description TEXT
);

-- Table: EDITORY
CREATE TABLE EDITORY (
    Editory_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Editory_Name VARCHAR(100) NOT NULL
);

-- Table: SHELF
CREATE TABLE SHELF (
    Shelf_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Shelf_Number INT NOT NULL,
    Section VARCHAR(50)
);

-- Table: AUTHOR
CREATE TABLE AUTHOR (
    Author_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Author_Name VARCHAR(100) NOT NULL
);


-- Table: BOOK
CREATE TABLE BOOK (
    Book_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Title VARCHAR(200) NOT NULL,
    Year YEAR,
    Amount_of_copies INT NOT NULL,
    Category_ID INT NOT NULL,
    Editory_ID INT NOT NULL,
    Shelf_ID INT NOT NULL,
    Available BOOLEAN DEFAULT TRUE
);

-- Table: BOOK_AUTHOR
CREATE TABLE BOOK_AUTHOR (
    Book_ID INT NOT NULL,                            
    Author_ID INt NOT NULL,   
    PRIMARY KEY (Book_ID, Author_ID)
);

-- Table: LOAN
CREATE TABLE LOAN (
    Loan_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Loan_Date DATE,
    Return_Date DATE,
    Status VARCHAR(50),
    User_ID INT,
	Librarian_ID INT NOT NULL,
	Book_ID INT NOT NULL
);

-- Table: RESERVATION
CREATE TABLE RESERVATION (
    Reservation_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Reservation_Date DATE NOT NULL,
    Reservation_Status VARCHAR(50),
    User_ID INT
);

-- Table: SANCTION
CREATE TABLE SANCTION (
    Sanction_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Sanction_Date DATE NOT NULL,
    Price DECIMAL(10, 2),
    Description TEXT,
    Sanction_Status VARCHAR(50),
    User_ID INT NOT NULL,
    Loan_ID INT
);

-- Table: FINE
CREATE TABLE FINE (
    Fine_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Price DECIMAL(10, 2) NOT NULL,
    Description TEXT,
    Sanction_ID INT NOT NULL
);

-- Definition of FK

-- USER
ALTER TABLE USER
ADD CONSTRAINT FK_User_Type
FOREIGN KEY (User_Type) REFERENCES USERTYPES(User_Type);

-- BOOK
ALTER TABLE BOOK
ADD CONSTRAINT FK_Book_Category
FOREIGN KEY (Category_ID) REFERENCES CATEGORY(Category_ID);
        
ALTER TABLE BOOK
ADD CONSTRAINT FK_Book_Editory
FOREIGN KEY (Editory_ID) REFERENCES EDITORY(Editory_ID);
        
ALTER TABLE BOOK
ADD CONSTRAINT FK_Book_Shelf
FOREIGN KEY (Shelf_ID) REFERENCES SHELF(Shelf_ID);

ALTER TABLE BOOK_AUTHOR
ADD CONSTRAINT FK_Book_ID_Author
FOREIGN KEY (Book_ID) REFERENCES BOOK(Book_ID) ON DELETE CASCADE;

ALTER TABLE BOOK_AUTHOR
ADD CONSTRAINT FK_Author_ID_Author
FOREIGN KEY (Author_ID) REFERENCES AUTHOR(Author_ID) ON DELETE CASCADE;

-- LOAN
ALTER TABLE LOAN
ADD CONSTRAINT FK_Loan_User
FOREIGN KEY (User_ID) REFERENCES USER(User_ID)
ON DELETE SET NULL;

ALTER TABLE LOAN
ADD CONSTRAINT FK_Loan_Librarian
FOREIGN KEY (Librarian_ID) REFERENCES LIBRARIAN(Librarian_ID);

ALTER TABLE LOAN
ADD CONSTRAINT FK_Loan_Book
FOREIGN KEY (Book_ID) REFERENCES BOOK(Book_ID);


-- RESERVATION
ALTER TABLE RESERVATION
ADD CONSTRAINT FK_Reservation_User
FOREIGN KEY (User_ID) REFERENCES USER(User_ID)
ON DELETE SET NULL;

-- SANCTION
ALTER TABLE SANCTION
ADD CONSTRAINT FK_Sanction_User
FOREIGN KEY (User_ID) REFERENCES USER(User_ID);

ALTER TABLE SANCTION
ADD CONSTRAINT FK_Sanction_Loan
FOREIGN KEY (Loan_ID) REFERENCES LOAN(Loan_ID);


-- FINE
ALTER TABLE FINE
ADD CONSTRAINT FK_Fine_Sanction
FOREIGN KEY (Sanction_ID) REFERENCES SANCTION(Sanction_ID);

-- End of file