-- Created by belenamiune (https://github.com/belenamiune)

USE library;

DROP FUNCTION IF EXISTS GetUserLoanCount;
DROP FUNCTION IF EXISTS IsBookAvailable;
DROP FUNCTION IF EXISTS GetLateFees;
DROP FUNCTION IF EXISTS GetTotalBooksInCategory;
DROP FUNCTION IF EXISTS GetPopularBooks;

-- Functions:

DELIMITER //

-- Function: GetUserLoanCount
CREATE FUNCTION GetUserLoanCount(userID INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE loanCount INT;
    SELECT COUNT(*) INTO loanCount
    FROM LOAN
    WHERE User_ID = userID;
    RETURN loanCount;
END//

DELIMITER ;

DELIMITER //

-- Function: IsBookAvailable
-- Objetivo: Devuelve un valor booleano indicando si un libro específico está disponible para préstamo.
CREATE FUNCTION IsBookAvailable(bookID INT)
RETURNS TINYINT(1)  -- Cambiado BOOLEAN a TINYINT(1)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE available TINYINT(1);  -- Cambiado BOOLEAN a TINYINT(1)
    SELECT COUNT(*) = 0 INTO available
    FROM LOAN
    WHERE Book_ID = bookID AND Return_Date IS NULL; 
    RETURN available;
END//

DELIMITER ;

DELIMITER //

-- Function: GetLateFees
-- Objetivo: Calcula y devuelve las tarifas por atraso para un préstamo específico.
CREATE FUNCTION GetLateFees(loanID INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE lateFee DECIMAL(10,2) DEFAULT 0;  -- Inicializa lateFee
    DECLARE daysLate INT DEFAULT 0;  -- Inicializa daysLate
    DECLARE returnDate DATE;

    SELECT Return_Date INTO returnDate
    FROM LOAN
    WHERE Loan_ID = loanID;

    -- Verifica que Return_Date no sea nulo
    IF returnDate IS NOT NULL THEN
        SET daysLate = DATEDIFF(CURDATE(), returnDate);
        IF daysLate > 0 THEN
            SET lateFee = daysLate * 0.50; 
        END IF;
    END IF;

    RETURN lateFee;
END//

DELIMITER ;

DELIMITER //
-- Function: GetTotalBooksInCategory
-- Objetivo: Devuelve el total de libros en una categoría específica.
CREATE FUNCTION GetTotalBooksInCategory(categoryID INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE totalBooks INT;
    SELECT COUNT(*) INTO totalBooks
    FROM BOOK
    WHERE Category_ID = categoryID;
    RETURN totalBooks;
END//
DELIMITER ; 


DELIMITER //
-- Function: GetPopularBooks
-- Objetivo: Devuelve los libros más prestados hasta la fecha, limitados a un número específico de resultados.
CREATE FUNCTION GetPopularBooks(categoryID INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE totalBooks INT;
    SELECT COUNT(*) INTO totalBooks
    FROM BOOK
    WHERE Category_ID = categoryID;
    RETURN totalBooks;
END//
DELIMITER ; 


