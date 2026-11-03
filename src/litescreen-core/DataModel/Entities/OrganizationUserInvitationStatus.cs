using System;

namespace LitescreenCore.DataModel.Entities
{
    internal class OrganizationUserInvitationStatus
    {
        public int OrganizationUserInvitationStatusId { get; set; }

        public string Name { get; set; } = null!; // Pending, Accepted, Expired, Revoked

        public string Description { get; set; } = null!;

        public DateTime CreatedAt { get; set; }

        public string CreatedBy { get; set; } = null!;

        public DateTime UpdatedAt { get; set; }

        public string UpdatedBy { get; set; } = null!;

        public bool IsActive { get; set; }

        public byte[] RowVersion { get; set; } = null!;
    }
}
