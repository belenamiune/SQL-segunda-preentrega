-- Created by belenamiune (https://github.com/belenamiune)

USE library;

DROP PROCEDURE IF EXISTS AddNewBook;
DROP PROCEDURE IF EXISTS LoanBook;
DROP PROCEDURE IF EXISTS ReturnBook;
DROP PROCEDURE IF EXISTS GetUserLoans;
DROP PROCEDURE IF EXISTS GetPopularBooks;

USE library;


-- Store procedures:

DELIMITER //

-- Stored Procedure: AddNewBook
-- Objetivo: Agregar un nuevo libro a la base de datos, asegurando que se proporciona toda la información necesaria.
CREATE PROCEDURE AddNewBook(
    IN bookTitle VARCHAR(255),
    IN categoryID INT,
    IN editoryID INT,
    IN available TINYINT(1)
)
BEGIN
    INSERT INTO BOOK (Title, Category_ID, Editory_ID, Available)
    VALUES (bookTitle, categoryID, editoryID, available);
END//

DELIMITER ;

DELIMITER //


-- Stored Procedure: LoanBook
-- Objetivo: Procesar un nuevo préstamo de libro, verificando la disponibilidad y registrando la fecha de préstamo.
CREATE PROCEDURE LoanBook(
    IN userID INT,
    IN bookID INT
)
BEGIN
    DECLARE loanDate DATE;
    -- Verificar disponibilidad
    IF IsBookAvailable(bookID) THEN
        SET loanDate = CURDATE();
        INSERT INTO LOAN (User_ID, Book_ID, Loan_Date, Return_Date)
        VALUES (userID, bookID, loanDate, NULL);
    ELSE
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El libro no está disponible para préstamo';
    END IF;
END//

DELIMITER ;

DELIMITER //



-- Stored Procedure: ReturnBook
-- Objetivo: Procesar la devolución de un libro, actualizando la fecha de devolución en la tabla de préstamos.
CREATE PROCEDURE ReturnBook(
    IN loanID INT
)
BEGIN
    UPDATE LOAN
    SET Return_Date = CURDATE()
    WHERE Loan_ID = loanID AND Return_Date IS NULL;
END//

DELIMITER ;


DELIMITER //
-- Stored Procedure: GetUserLoans
-- Objetivo: Obtener todos los préstamos de un usuario específico, devolviendo resultados en un conjunto de resultados.
CREATE PROCEDURE GetUserLoans(
    IN userID INT
)
BEGIN
    SELECT 
        u.User_Name, 
        b.Title, 
        l.Loan_Date, 
        l.Return_Date
    FROM 
        LOAN l
    JOIN 
        USER u ON l.User_ID = u.User_ID
    JOIN 
        BOOK b ON l.Book_ID = b.Book_ID
    WHERE 
        u.User_ID = userID;
END//

DELIMITER ;



-- Stored Procedure: GetPopularBooks
-- Objetivo: Obtener los libros más prestados, utilizando un parámetro para limitar la cantidad de resultados.
DELIMITER //

CREATE PROCEDURE GetPopularBooks(
    IN resultLimit INT
)
BEGIN
    SELECT 
        b.Title, 
        COUNT(l.Loan_ID) AS Times_Loaned
    FROM 
        BOOK b
    LEFT JOIN 
        LOAN l ON b.Book_ID = l.Book_ID
    GROUP BY 
        b.Book_ID
    ORDER BY 
        Times_Loaned DESC
    LIMIT resultLimit;
END//

DELIMITER ;
