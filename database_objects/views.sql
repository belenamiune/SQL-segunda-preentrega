-- Created by belenamiune (https://github.com/belenamiune)
USE library;

-- Views: 

-- View: UserDetails
-- Objetivo: Obtener detalles de los usuarios junto con su tipo
CREATE VIEW UserDetails AS
SELECT 
    u.User_ID, 
    u.User_Name, 
    u.Address, 
    u.Phone, 
    u.Email, 
    ut.User_Type_Name
FROM 
    USER u
JOIN 
    USERTYPES ut ON u.User_Type = ut.User_Type;

-- View: AvailableBooks
-- Objetivo: Mostrar todos los libros disponibles para préstamo, junto con su categoría y la editorial.
CREATE VIEW AvailableBooks AS
SELECT 
    b.Book_ID, 
    b.Title, 
    c.Category_Name, 
    e.Editory_Name
FROM 
    BOOK b
JOIN 
    CATEGORY c ON b.Category_ID = c.Category_ID
JOIN 
    EDITORY e ON b.Editory_ID = e.Editory_ID
WHERE 
    b.Available = TRUE;


-- View: UserLoans
-- Objetivo: Listar todos los préstamos de libros realizados por los usuarios, junto con detalles sobre el usuario y el libro.
CREATE VIEW UserLoans AS
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
    BOOK b ON l.Book_ID = b.Book_ID;
    
-- View: LibrarianStats
-- Objetivo: Proporcionar estadísticas sobre los bibliotecarios, como el número de libros prestados por cada uno.
CREATE VIEW LibrarianStats AS
SELECT 
    l.Librarian_Name, 
    COUNT(lo.Book_ID) AS Total_Loans
FROM 
    LIBRARIAN l
LEFT JOIN 
    LOAN lo ON l.Librarian_ID = lo.Librarian_ID 
GROUP BY 
    l.Librarian_Name;
    
-- View: UserTypeSummary
-- Objetivo: Mostrar un resumen del número de usuarios por tipo de usuario.
CREATE VIEW UserTypeSummary AS
SELECT 
    ut.User_Type_Name, 
    COUNT(u.User_ID) AS Total_Users
FROM 
    USERTYPES ut
LEFT JOIN 
    USER u ON u.User_Type = ut.User_Type
GROUP BY 
    ut.User_Type_Name;
    
-- View: CategoryBookCount
-- Objetivo: Listar las categorías de libros junto con el número total de libros en cada categoría.
CREATE VIEW CategoryBookCount AS
SELECT 
    c.Category_Name, 
    COUNT(b.Book_ID) AS Total_Books
FROM 
    CATEGORY c
LEFT JOIN 
    BOOK b ON b.Category_ID = c.Category_ID
GROUP BY 
    c.Category_Name;
    
-- View: BookCategorySummary
-- Objetivo: Proporcionar un resumen del número de libros por categoría, junto con la cantidad de préstamos realizados.
CREATE VIEW BookCategorySummary AS
SELECT 
    c.Category_Name, 
    COUNT(b.Book_ID) AS Total_Books,
    COUNT(l.Loan_ID) AS Total_Loans
FROM 
    CATEGORY c
LEFT JOIN 
    BOOK b ON c.Category_ID = b.Category_ID
LEFT JOIN 
    LOAN l ON b.Book_ID = l.Book_ID
GROUP BY 
    c.Category_Name;
    

-- View: PopularBooks
-- Objetivo: Listar los libros más prestados, mostrando la cantidad de veces que se han prestado.
CREATE VIEW PopularBooks AS
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
    Times_Loaned DESC;
    

-- View: OverdueLoans
-- Objetivo: Mostrar los préstamos que están atrasados, junto con la información del usuario y del libro.
CREATE VIEW OverdueLoans AS
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
    l.Return_Date < CURDATE();