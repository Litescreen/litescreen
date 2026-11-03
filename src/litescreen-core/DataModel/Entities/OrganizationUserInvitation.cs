using System;

namespace LitescreenCore.DataModel.Entities
{
    internal class OrganizationUserInvitation
    {
        public long OrganizationUserInvitationId { get; set; }

        public long OrganizationId { get; set; }

        public int OrganizationUserInvitationStatusId { get; set; }

        public string Email { get; set; } = null!;

        public string Token { get; set; } = null!; // Unique, unguessable (Guid or random string)

        public string? InvitedBy { get; set; }

        public DateTime CreatedAt { get; set; }

        public DateTime ExpiresAt { get; set; }

        public DateTime? AcceptedAt { get; set; }

        public DateTime? RevokedAt { get; set; }

        public string? RevokedBy { get; set; }
    }
}