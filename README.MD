
# BIBLIOTECA

Primera preentrega - Curso SQL. 

### Descripción del proyecto
Esta biblioteca enfrenta ineficiencias tanto en la gestión del inventario como en el control de usuarios, préstamos y sanciones, lo que afecta negativamente tanto la operación interna como la experiencia del usuario. Estos problemas limitan la capacidad de la biblioteca para ofrecer un servicio ágil, confiable y personalizado a sus usuarios, lo que justifica la implementación de un sistema automatizado basado en una base de datos para optimizar todos estos aspectos.

Por lo tanto este proyecto consta de la creación de una base de datos para una biblioteca pública con el objetivo de modernizar su operación, mejorar la eficiencia, optimizar el uso de los recursos y brindar un mejor servicio a los usuarios. Además, facilita la toma de decisiones informadas sobre la colección de libros y las necesidades de los usuarios, y contribuye a la organización y gestión general de la biblioteca.

### Base de datos

En referencia a lo mencionado anteriormente, esta base de datos se creará para poder agilizar algunos de sus procesos, lograr una mejor organización y mejorar la experiencia de usuario.

A continuación se detallan cada una de las tablas: 

    1. User
        Objetivo: almacenar información de cada uno de los usuarios que reservan libros. 
        Atributos:
            User_ID (PK)
            User_Name
            Address
            Phone
            Email
            User_type
    2. Book
        Objetivo: almacenar información de cada uno de los libros disponibles.
        Atributos: 
            Book_ID (PK)
            Title
            Year
            Amount_of_copies
            Cateogry_ID (FK)
            Editory_ID(FK)
            Shelf_ID (FK)
    3. Loan
        Objetivo: almacenar información sobre los prestamos realizados.
        Atributos:
            Loan_ID (PK)
            Loan_Date
            Return_Date
            Status
            User_ID (FK)
            Librarian_ID (FK)
    4. Librarian
        Objetivo: almacenar información de los trabajadores. 
        Atributos: 
            Librarian_ID (PK)
            Librarian_Name
            Shift
    5. Reservation
        Objetivo: almacenar información sobre las reservas de los libros.
        Atributos: 
            Reservation_ID (PK)
            Reservation_Date
            Reservation_Status
            User_ID (FK)
    6. Sanction
        Objetivo: almacenar información sobre las saciones aplicadas.
        Atributos: 
            Sanction_ID (PK)
            Sanction_Date
            Price
            Description
            Sanction_Status
            User_ID (FK)
            Loan_ID (FK)
    7. Fine
        Objetivo: almacenar información sobre las multas aplicadas.
        Atributos:
            Fine_ID (PK)
            Price
            Description
            Penalty_ID (FK)
    8. Category
        Objetivo: almacenar información sobre las categorías de libros disponibles.
        Atributos:
            Cateogry_ID (PK)
            Category_Name
            Description
    9. Editory
        Objetivo: almacenar información sobre las editoriales disponibles.
        Atributos:
            Editory_ID (PK)
            Editory_Name 
    10. Autor 
        Objetivo: almacenar información sobre los autores.
        Atributos: 
            Autor_ID (PK)
            Autor_Name
    11. Shelf
        Objetivo: almacenar información sobre los estantes.
        Atributos:
            Shelf_ID (PK)
            Shelf_number
            Section


### Diagrama ER 
![ER Biblioteca Pública](diagrama_erd.png)
![DER Biblioteca Pública](ERD_draw.png)





## Authors

- [@belenamiune](https://www.github.com/belenamiune)

