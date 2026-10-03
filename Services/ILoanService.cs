using LibraryManagementApi.DTO;

namespace LibraryManagementApi.Services
{
    public interface ILoanService
    {
        Task<List<LoanDto>> GetAllAsync();
        Task<LoanDto?> GetByIdAsync(int id);
        Task<List<LoanDto>> GetByMemberIdAsync(int memberId);
        Task<LoanDto> CreateAsync(CreateLoanDto dto);
        Task<LoanDto> ReturnAsync(int id);
    }
}