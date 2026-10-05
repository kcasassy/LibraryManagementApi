using LibraryManagementApi.Models.DTO;
using LibraryManagementApi.Services;
using Microsoft.AspNetCore.Mvc;

namespace LibraryManagementApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class LoansController : ControllerBase
    {
        private readonly ILoanService _service;

        public LoansController(ILoanService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<List<LoanDto>>> GetAll()
        {
            var loans = await _service.GetAllAsync();
            return Ok(loans);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<LoanDto>> GetById(int id)
        {
            var loan = await _service.GetByIdAsync(id);

            if (loan == null)
            {
                return NotFound(new { message = "Loan not found." });
            }

            return Ok(loan);
        }

        [HttpPost]
        public async Task<ActionResult<LoanDto>> Create(CreateLoanDto dto)
        {
            var loan = await _service.CreateAsync(dto);

            return CreatedAtAction(
                nameof(GetById),
                new { id = loan.Id },
                loan);
        }

        [HttpPost("{id}/return")]
        public async Task<ActionResult<LoanDto>> Return(int id)
        {
            var loan = await _service.ReturnAsync(id);

            return Ok(loan);
        }

        [HttpGet("/api/members/{memberId}/loans")]
        public async Task<ActionResult<List<LoanDto>>> GetByMemberId(
            int memberId)
        {
            var loans = await _service.GetByMemberIdAsync(memberId);

            return Ok(loans);
        }
    }
}