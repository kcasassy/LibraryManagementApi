\# Community Library Management API

\#\# Project Description

The Community Library Management API is a RESTful Web API built with .NET 9 and C\#. It manages books, library members, and book loans.

The project demonstrates the concepts covered in Modules 1–5, including RESTful API design, Entity Framework Core, SQL Server database integration, CRUD operations, layered architecture, repository and service patterns, and dependency injection.

The API uses SQL Server for persistent data storage and provides an interactive Swagger/OpenAPI interface for testing the endpoints.

\---

\#\# Technologies Used

\- .NET 9 Web API  
\- C\#  
\- Entity Framework Core  
\- SQL Server  
\- Swagger / OpenAPI  
\- Visual Studio  
\- Git and GitHub

\---

\#\# Resources

The API contains three related resources:

\#\#\# Book

A book contains:

\- \`Id\`  
\- \`Title\`  
\- \`Author\`  
\- \`ISBN\`  
\- \`Category\`  
\- \`TotalCopies\`  
\- \`AvailableCopies\`

\#\#\# Member

A member contains:

\- \`Id\`  
\- \`FullName\`  
\- \`Email\`  
\- \`MembershipType\`  
\- \`DateJoined\`  
\- \`IsActive\`

\`MembershipType\` can be:

\- Student  
\- Faculty

\#\#\# Loan

A loan contains:

\- \`Id\`  
\- \`BookId\`  
\- \`MemberId\`  
\- \`BorrowedDate\`  
\- \`DueDate\`  
\- \`ReturnedDate\`  
\- \`Status\`

\`Status\` can be:

\- Borrowed  
\- Returned  
\- Overdue

\#\#\# Relationships

The resources have the following relationships:

\- A Book can have many Loans.  
\- A Member can have many Loans.  
\- Each Loan references exactly one Book.  
\- Each Loan references exactly one Member.

\---

\#\# API Endpoints

\#\#\# Books

| Method | Endpoint | Description |  
|---|---|---|  
| GET | \`/api/books\` | Get all books |  
| GET | \`/api/books/{id}\` | Get a specific book |  
| POST | \`/api/books\` | Add a new book |  
| PUT | \`/api/books/{id}\` | Update an existing book |  
| DELETE | \`/api/books/{id}\` | Delete a book |

\#\#\# Members

| Method | Endpoint | Description |  
|---|---|---|  
| GET | \`/api/members\` | Get all members |  
| GET | \`/api/members/{id}\` | Get a specific member |  
| POST | \`/api/members\` | Register a new member |  
| PUT | \`/api/members/{id}\` | Update an existing member |  
| DELETE | \`/api/members/{id}\` | Delete or deactivate a member |

\#\#\# Loans

| Method | Endpoint | Description |  
|---|---|---|  
| GET | \`/api/loans\` | Get all loans |  
| GET | \`/api/loans/{id}\` | Get a specific loan |  
| POST | \`/api/loans\` | Borrow a book |  
| POST | \`/api/loans/{id}/return\` | Return a borrowed book |  
| GET | \`/api/members/{id}/loans\` | Get all loans of a member |

\---

\#\# Loan Business Rules

The API implements the following business rules:

1\. A book can only be borrowed when \`AvailableCopies \> 0\`.  
2\. Borrowing a book decreases \`AvailableCopies\` by 1\.  
3\. Returning a book increases \`AvailableCopies\` by 1\.  
4\. An inactive member cannot borrow a book.  
5\. A member can have a maximum of 3 active loans at the same time.  
6\. The \`DueDate\` is set to 7 days after the \`BorrowedDate\`.  
7\. Borrowing a non-existent book or member returns \`404 Not Found\`.  
8\. Borrowing a book with no available copies returns \`409 Conflict\`.  
9\. An inactive member attempting to borrow returns \`409 Conflict\`.  
10\. A member who already has 3 active loans cannot borrow another book and receives \`409 Conflict\`.  
11\. A loan that has already been returned cannot be returned again.  
12\. Returning a loan updates its status and increases the book's available copies.

\---

\#\# Project Structure

The project follows a layered architecture:

\`\`\`text  
Controllers  
     ↓  
Services  
     ↓  
Repositories  
     ↓  
DbContext  
     ↓  
SQL Server

### **Controllers**

The Controllers layer handles HTTP requests and responses. Controllers are kept thin and communicate with the service layer instead of directly accessing the database.

DTOs are used at the API boundary instead of exposing database entities directly.

### **Services**

The Services layer contains the application's business logic and rules.

For example, the Loan service handles:

* Checking book availability  
* Checking member status  
* Checking the maximum number of active loans  
* Calculating the due date  
* Updating available book copies  
* Processing book returns

### **Repositories**

The Repositories layer handles data access using Entity Framework Core.

Each resource has its own repository and repository interface:

IBookRepository  
IMemberRepository  
ILoanRepository

The `LibraryDbContext` is used inside the repositories for database operations.

### **Models and DTOs**

Models represent the database entities.

DTOs are used to control the data exposed through the API and prevent database entities from being directly exposed to API clients.

---

## **Entity Framework Core**

The project uses Entity Framework Core with SQL Server for persistence.

The application contains one `LibraryDbContext` with:

DbSet\<Book\>  
DbSet\<Member\>  
DbSet\<Loan\>

The Entity Framework relationships match the database schema:

Book 1 ─────── \* Loan  
Member 1 ───── \* Loan

The application uses asynchronous EF Core operations, including:

* `ToListAsync()`  
* `FirstOrDefaultAsync()`  
* `FindAsync()`  
* `SaveChangesAsync()`

Read-only queries use `AsNoTracking()` where appropriate.

The `DbContext` is used only in the repository layer.

---

## **Dependency Injection**

Dependency injection is configured in `Program.cs`.

The project uses the **Scoped** lifetime for the `DbContext`, repositories, and services.

The following dependencies are registered:

IBookRepository → BookRepository  
IMemberRepository → MemberRepository  
ILoanRepository → LoanRepository

IBookService → BookService  
IMemberService → MemberService  
ILoanService → LoanService

`AddDbContext` is used for the `LibraryDbContext`.

The Scoped lifetime is used because repositories and services depend on the request-scoped `DbContext`. This keeps the database context and related services within the same HTTP request scope.

---

## **Database Setup**

The project uses SQL Server for persistent storage.

The SQL scripts are located in the `/database` folder:

database/  
├── database-design.sql  
└── database-content.sql

No EF Core migrations are required. The database is created using the provided SQL scripts.

### **Step 1: Create the Database**

Open **SQL Server Management Studio (SSMS)** and connect to your SQL Server instance.

Open:

database/database-design.sql

Execute the entire script.

This creates the:

LibraryManagementDb

database together with the required tables, primary keys, foreign keys, and constraints.

### **Step 2: Insert Sample Data**

After successfully executing `database-design.sql`, open:

database/database-content.sql

Execute the entire script.

This inserts sample:

* Books  
* Members  
* Loans

into the database.

### **Important**

Run the scripts in this order:

1\. database-design.sql  
2\. database-content.sql

The content script should only be executed after the database and tables have been created.

---

## **Connection String Configuration**

The database connection string is stored in:

appsettings.json

Example:

{  
  "ConnectionStrings": {  
    "DefaultConnection": "Server=YOUR\_SERVER\_NAME;Database=LibraryManagementDb;Trusted\_Connection=True;TrustServerCertificate=True;"  
  }  
}

Replace `YOUR_SERVER_NAME` with the SQL Server instance installed on your computer.

For example, depending on the SQL Server installation, the server name may be similar to:

.\\SQLEXPRESS

or another SQL Server instance name.

The connection string should point to:

LibraryManagementDb

Do not commit passwords or other sensitive database credentials to the repository.

---

## **Running the Project**

### **Using Visual Studio**

1. Clone or download the repository.  
2. Open the `.sln` solution in Visual Studio.  
3. Make sure SQL Server is running.  
4. Create the database by executing `database-design.sql`.  
5. Execute `database-content.sql`.  
6. Check the `DefaultConnection` value in `appsettings.json`.  
7. Build the solution.  
8. Run the API.

### **Using the .NET CLI**

Open a terminal in the project folder and run:

dotnet restore

Then:

dotnet build

Then:

dotnet run

The application will display the local HTTP and HTTPS addresses in the terminal.

---

## **Swagger / OpenAPI**

The project includes Swagger/OpenAPI for interactive API documentation and testing.

After running the application, open the Swagger UI using the URL provided by the application.

Example:

https\://localhost:PORT/swagger

Swagger allows the user or grader to test the Books, Members, and Loans endpoints directly.

---

## **HTTP Status Codes**

The API uses appropriate HTTP status codes for its operations.

Common responses include:

| Status Code | Meaning |
| ----- | ----- |
| `200 OK` | Request completed successfully |
| `201 Created` | A new resource was created |
| `204 No Content` | Update or delete completed successfully |
| `404 Not Found` | Requested resource does not exist |
| `409 Conflict` | Business rule prevents the requested operation |

When a new Book or Member is created, the API returns `201 Created`.

---

## **GitHub Collaboration**

The project is maintained in a single GitHub repository.

The team uses:

* Feature branches  
* Pull requests  
* Code integration through the main branch  
* Individual commits from each team member

Each team member contributes under their own GitHub account.

---

## **Team & Contributions**

### **Carlos Branch ( Books)**

Responsible for the Books resource:

* Book entity  
* Book DTOs  
* Book repository  
* Book service  
* Books controller  
* Book CRUD endpoints  
* README and endpoint documentation

### **Santos, Kim Branch (Members)**

Responsible for the Members resource:

* Member entity  
* Member DTOs  
* Member repository  
* Member service  
* Members controller  
* Member CRUD endpoints  
* Member validation

### 

### **Rabino Branch (Loans)**

Responsible for the Loans resource and shared database configuration:

* Loan entity  
* Loan DTOs  
* Loan repository  
* Loan service  
* Loans controller  
* Loan business rules  
* `LibraryDbContext`  
* Database design script  
* Database content script  
* Dependency injection configuration  
* Swagger configuration

The team also collaborated during integration, testing, code review, and implementation of the cross-resource Loan functionality.

---

## **Goal of the Project**

The goal of this project is to demonstrate the concepts covered in Modules 1–5:

* .NET 9 Web API development  
* RESTful API design  
* Entity Framework Core  
* SQL Server database integration  
* CRUD operations  
* Async database operations  
* DTOs  
* Repository pattern  
* Service layer  
* Dependency injection  
* Layered architecture  
* Swagger/OpenAPI documentation  
* Git and GitHub collaboration