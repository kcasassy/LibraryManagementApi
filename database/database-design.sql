CREATE DATABASE LibraryManagementDb;
GO

USE LibraryManagementDb;
GO

CREATE TABLE Books
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Author NVARCHAR(150) NOT NULL,
    ISBN NVARCHAR(50) NOT NULL,
    Category NVARCHAR(100) NOT NULL,
    TotalCopies INT NOT NULL,
    AvailableCopies INT NOT NULL,

    CONSTRAINT CK_Books_TotalCopies
        CHECK (TotalCopies >= 0),

    CONSTRAINT CK_Books_AvailableCopies
        CHECK (AvailableCopies >= 0),

    CONSTRAINT CK_Books_AvailableCopies_TotalCopies
        CHECK (AvailableCopies <= TotalCopies)
);
GO

CREATE TABLE Members
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(150) NOT NULL,
    Email NVARCHAR(150) NOT NULL,
    MembershipType NVARCHAR(20) NOT NULL,
    DateJoined DATETIME2 NOT NULL,
    IsActive BIT NOT NULL,

    CONSTRAINT CK_Members_MembershipType
        CHECK (MembershipType IN ('Student', 'Faculty'))
);
GO

CREATE TABLE Loans
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    BookId INT NOT NULL,
    MemberId INT NOT NULL,
    BorrowedDate DATETIME2 NOT NULL,
    DueDate DATETIME2 NOT NULL,
    ReturnedDate DATETIME2 NULL,
    Status NVARCHAR(20) NOT NULL,

    CONSTRAINT CK_Loans_Status
        CHECK (Status IN ('Borrowed', 'Returned', 'Overdue')),

    CONSTRAINT FK_Loans_Books
        FOREIGN KEY (BookId)
        REFERENCES Books(Id),

    CONSTRAINT FK_Loans_Members
        FOREIGN KEY (MemberId)
        REFERENCES Members(Id)
);
GO