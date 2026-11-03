using System;

namespace LitescreenCore.DataModel.Entities
{
    public class OrganizationUser
    {
        public long OrganizationUserId { get; set; }

        public long OrganizationId { get; set; }
        
        public long UserId { get; set; }

        public DateTime CreatedAt { get; set; }
        
        public string CreatedBy { get; set; } = null!;
        
        public DateTime UpdatedAt { get; set; }
        
        public string UpdatedBy { get; set; } = null!;

        public bool IsActive { get; set; }

        public byte[] RowVersion { get; set; } = null!;
    }
}