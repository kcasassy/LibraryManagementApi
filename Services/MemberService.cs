using LibraryManagementApi.DTO;
using LibraryManagementApi.Models;
using LibraryManagementApi.Repositories;

namespace LibraryManagementApi.Services
{
    public class MemberService : IMemberService
    {
        private readonly IMemberRepository _repository;

        public MemberService(IMemberRepository repository)
        {
            _repository = repository;
        }

        public async Task<List<MemberDto>> GetAllAsync()
        {
            var members = await _repository.GetAllAsync();

            return members.Select(member => new MemberDto
            {
                Id = member.Id,
                FullName = member.FullName,
                Email = member.Email,
                MembershipType = member.MembershipType,
                DateJoined = member.DateJoined,
                IsActive = member.IsActive
            }).ToList();
        }

        public async Task<MemberDto?> GetByIdAsync(int id)
        {
            var member = await _repository.GetByIdAsync(id);

            if (member == null)
            {
                return null;
            }

            return new MemberDto
            {
                Id = member.Id,
                FullName = member.FullName,
                Email = member.Email,
                MembershipType = member.MembershipType,
                DateJoined = member.DateJoined,
                IsActive = member.IsActive
            };
        }

        public async Task<MemberDto> CreateAsync(CreateMemberDto dto)
        {
            if (dto.MembershipType != "Student" &&
                dto.MembershipType != "Faculty")
            {
                throw new InvalidOperationException(
                    "MembershipType must be Student or Faculty.");
            }

            var member = new Member
            {
                FullName = dto.FullName,
                Email = dto.Email,
                MembershipType = dto.MembershipType,
                DateJoined = dto.DateJoined,
                IsActive = true
            };

            var createdMember = await _repository.AddAsync(member);

            return new MemberDto
            {
                Id = createdMember.Id,
                FullName = createdMember.FullName,
                Email = createdMember.Email,
                MembershipType = createdMember.MembershipType,
                DateJoined = createdMember.DateJoined,
                IsActive = createdMember.IsActive
            };
        }

        public async Task<bool> UpdateAsync(int id, UpdateMemberDto dto)
        {
            var member = await _repository.GetByIdAsync(id);

            if (member == null)
            {
                return false;
            }

            if (dto.MembershipType != "Student" &&
                dto.MembershipType != "Faculty")
            {
                throw new InvalidOperationException(
                    "MembershipType must be Student or Faculty.");
            }

            member.FullName = dto.FullName;
            member.Email = dto.Email;
            member.MembershipType = dto.MembershipType;
            member.IsActive = dto.IsActive;

            await _repository.UpdateAsync(member);

            return true;
        }

        public async Task<bool> DeleteAsync(int id)
        {
            var member = await _repository.GetByIdAsync(id);

            if (member == null)
            {
                return false;
            }

            await _repository.DeleteAsync(member);

            return true;
        }
    }
}