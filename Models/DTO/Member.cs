namespace LibraryManagementApi.DTO
{
    public class MemberDto
    {
        public int Id { get; set; }

        public string FullName { get; set; } = string.Empty;

        public string Email { get; set; } = string.Empty;

        public string MembershipType { get; set; } = string.Empty;

        public DateTime DateJoined { get; set; }

        public bool IsActive { get; set; }
    }

    public class CreateMemberDto
    {
        public string FullName { get; set; } = string.Empty;

        public string Email { get; set; } = string.Empty;

        public string MembershipType { get; set; } = string.Empty;

        public DateTime DateJoined { get; set; }
    }

    public class UpdateMemberDto
    {
        public string FullName { get; set; } = string.Empty;

        public string Email { get; set; } = string.Empty;

        public string MembershipType { get; set; } = string.Empty;

        public bool IsActive { get; set; }
    }
}