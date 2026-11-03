using System;

namespace LitescreenCore.DataModel.Entities
{
    public class User
    {
        public long UserId { get; set; }

        public long OrganizationId { get; set; }

        public string ExternalAuthProviderData { get; set; } = null!;

        public string ExternalId { get; set; } = null!;

        public string Email { get; set; } = null!;

        public string FirstName { get; set; } = null!;

        public string? LastName { get; set; }

        public string DisplayName { get; set; } = null!;

        public DateTime OnboardingCompletedAt { get; set; }

        public DateTime CreatedAt { get; set; }

        public DateTime UpdatedAt { get; set; }

        public bool IsActive { get; set; }

        public byte[] RowVersion { get; set; } = null!;
    }
}
