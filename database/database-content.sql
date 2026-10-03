USE LibraryManagementDb;
GO

INSERT INTO Books
    (Title, Author, ISBN, Category, TotalCopies, AvailableCopies)
VALUES
    ('The 48 Laws of Power', ' Robert Greene', '9780143039693', 'Self-help', 5, 5),
    ('The Art of Seduction', ' Robert Greene', '9780143039556', 'Psychology', 4, 4),
    ('Mastery', ' Robert Greene', '9780156012195', 'Strategy', 3, 3),
    ('The Laws of Human Nature', ' Robert Greene', '9780132350884', 'Personal Development', 3, 3);
GO

INSERT INTO Members
    (FullName, Email, MembershipType, DateJoined, IsActive)
VALUES
    ('Lhanz Carlos', 'lhanz.carlos@email.com', 'Student', '2026-01-03', 1),
    ('Kim Santos', 'kim.santos@email.com', 'Student', '2026-02-04', 1),
    ('john Rabino', 'john.rabino@email.com', 'Faculty', '2026-03-05', 1),
    ('Rene Baterbonia', 'rene.baterbonia@email.com', 'Student', '2026-04-06', 1);
GO

INSERT INTO Loans
    (BookId, MemberId, BorrowedDate, DueDate, ReturnedDate, Status)
VALUES
    (1, 1, '2026-10-01', '2026-10-08', '2026-10-07', 'Returned'),
    (2, 2, '2026-09-10', '2026-09-12', NULL, 'Borrowed');
GO