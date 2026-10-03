using LibraryManagementApi.DTO;
using LibraryManagementApi.Models;
using LibraryManagementApi.Repositories;

namespace LibraryManagementApi.Services
{
    public class LoanService : ILoanService
    {
        private readonly ILoanRepository _loanRepository;
        private readonly IBookRepository _bookRepository;
        private readonly IMemberRepository _memberRepository;

        public LoanService(
            ILoanRepository loanRepository,
            IBookRepository bookRepository,
            IMemberRepository memberRepository)
        {
            _loanRepository = loanRepository;
            _bookRepository = bookRepository;
            _memberRepository = memberRepository;
        }

        public async Task<List<LoanDto>> GetAllAsync()
        {
            var loans = await _loanRepository.GetAllAsync();

            return loans.Select(loan => new LoanDto
            {
                Id = loan.Id,
                BookId = loan.BookId,
                BookTitle = loan.Book.Title,
                MemberId = loan.MemberId,
                MemberName = loan.Member.FullName,
                BorrowedDate = loan.BorrowedDate,
                DueDate = loan.DueDate,
                ReturnedDate = loan.ReturnedDate,
                Status = GetCurrentStatus(loan)
            }).ToList();
        }

        public async Task<LoanDto?> GetByIdAsync(int id)
        {
            var loan = await _loanRepository.GetByIdAsync(id);

            if (loan == null)
            {
                return null;
            }

            return new LoanDto
            {
                Id = loan.Id,
                BookId = loan.BookId,
                BookTitle = loan.Book.Title,
                MemberId = loan.MemberId,
                MemberName = loan.Member.FullName,
                BorrowedDate = loan.BorrowedDate,
                DueDate = loan.DueDate,
                ReturnedDate = loan.ReturnedDate,
                Status = GetCurrentStatus(loan)
            };
        }

        public async Task<List<LoanDto>> GetByMemberIdAsync(int memberId)
        {
            var loans = await _loanRepository.GetByMemberIdAsync(memberId);

            return loans.Select(loan => new LoanDto
            {
                Id = loan.Id,
                BookId = loan.BookId,
                BookTitle = loan.Book.Title,
                MemberId = loan.MemberId,
                MemberName = loan.Member.FullName,
                BorrowedDate = loan.BorrowedDate,
                DueDate = loan.DueDate,
                ReturnedDate = loan.ReturnedDate,
                Status = GetCurrentStatus(loan)
            }).ToList();
        }

        public async Task<LoanDto> CreateAsync(CreateLoanDto dto)
        {
            var book = await _bookRepository.GetByIdAsync(dto.BookId);

            if (book == null)
            {
                throw new KeyNotFoundException("Book not found.");
            }

            var member = await _memberRepository.GetByIdAsync(dto.MemberId);

            if (member == null)
            {
                throw new KeyNotFoundException("Member not found.");
            }

            if (!member.IsActive)
            {
                throw new InvalidOperationException(
                    "Inactive members cannot borrow books.");
            }

            if (book.AvailableCopies <= 0)
            {
                throw new InvalidOperationException(
                    "The book has no available copies.");
            }

            var memberLoans = await _loanRepository.GetByMemberIdAsync(dto.MemberId);

            var activeLoans = memberLoans.Count(loan =>
                loan.Status == "Borrowed" ||
                loan.Status == "Overdue");

            if (activeLoans >= 3)
            {
                throw new InvalidOperationException(
                    "A member can have a maximum of 3 active loans.");
            }

            var borrowedDate = DateTime.UtcNow;

            var loan = new Loan
            {
                BookId = dto.BookId,
                MemberId = dto.MemberId,
                BorrowedDate = borrowedDate,
                DueDate = borrowedDate.AddDays(7),
                ReturnedDate = null,
                Status = "Borrowed"
            };

            book.AvailableCopies--;

            await _bookRepository.UpdateAsync(book);

            var createdLoan = await _loanRepository.AddAsync(loan);

            return new LoanDto
            {
                Id = createdLoan.Id,
                BookId = createdLoan.BookId,
                BookTitle = book.Title,
                MemberId = createdLoan.MemberId,
                MemberName = member.FullName,
                BorrowedDate = createdLoan.BorrowedDate,
                DueDate = createdLoan.DueDate,
                ReturnedDate = createdLoan.ReturnedDate,
                Status = createdLoan.Status
            };
        }

        public async Task<LoanDto> ReturnAsync(int id)
        {
            var loan = await _loanRepository.GetByIdAsync(id);

            if (loan == null)
            {
                throw new KeyNotFoundException("Loan not found.");
            }

            if (loan.ReturnedDate != null || loan.Status == "Returned")
            {
                throw new InvalidOperationException(
                    "This loan has already been returned.");
            }

            loan.ReturnedDate = DateTime.UtcNow;
            loan.Status = "Returned";

            if (loan.Book.AvailableCopies < loan.Book.TotalCopies)
            {
                loan.Book.AvailableCopies++;
            }

            await _bookRepository.UpdateAsync(loan.Book);
            await _loanRepository.UpdateAsync(loan);

            return new LoanDto
            {
                Id = loan.Id,
                BookId = loan.BookId,
                BookTitle = loan.Book.Title,
                MemberId = loan.MemberId,
                MemberName = loan.Member.FullName,
                BorrowedDate = loan.BorrowedDate,
                DueDate = loan.DueDate,
                ReturnedDate = loan.ReturnedDate,
                Status = loan.Status
            };
        }

        private static string GetCurrentStatus(Loan loan)
        {
            if (loan.ReturnedDate != null)
            {
                return "Returned";
            }

            if (loan.DueDate < DateTime.UtcNow)
            {
                return "Overdue";
            }

            return "Borrowed";
        }
    }
}