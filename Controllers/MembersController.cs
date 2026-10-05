using LibraryManagementApi.Models.DTO;
using LibraryManagementApi.Services;
using Microsoft.AspNetCore.Mvc;

namespace LibraryManagementApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class MembersController : ControllerBase
    {
        private readonly IMemberService _service;

        public MembersController(IMemberService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<List<MemberDto>>> GetAll()
        {
            var members = await _service.GetAllAsync();

            return Ok(members);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<MemberDto>> GetById(int id)
        {
            var member = await _service.GetByIdAsync(id);

            if (member == null)
            {
                return NotFound(new { message = "Member not found." });
            }

            return Ok(member);
        }

        [HttpPost]
        public async Task<ActionResult<MemberDto>> Create(
            CreateMemberDto dto)
        {
            var member = await _service.CreateAsync(dto);

            return CreatedAtAction(
                nameof(GetById),
                new { id = member.Id },
                member);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Update(
            int id,
            UpdateMemberDto dto)
        {
            var updated = await _service.UpdateAsync(id, dto);

            if (!updated)
            {
                return NotFound(new { message = "Member not found." });
            }

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var deleted = await _service.DeleteAsync(id);

            if (!deleted)
            {
                return NotFound(new { message = "Member not found." });
            }

            return NoContent();
        }
    }
}