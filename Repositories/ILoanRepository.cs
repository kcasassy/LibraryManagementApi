using LibraryManagementApi.Models.Domain;

namespace LibraryManagementApi.Repositories
{
    public interface ILoanRepository
    {
        Task<List<Loan>> GetAllAsync();

        Task<Loan?> GetByIdAsync(int id);

        Task<List<Loan>> GetByMemberIdAsync(int memberId);

        Task<Loan> AddAsync(Loan loan);

        Task UpdateAsync(Loan loan);
    }
}