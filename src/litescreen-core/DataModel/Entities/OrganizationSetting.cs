using System;

namespace LitescreenCore.DataModel.Entities
{
    public class OrganizationSetting
    {
        public long OrganizationSettingId { get; set; }
        
        public long OrganizationId { get; set; }
        
        public string SettingKey { get; set; } = null!;
        
        public string SettingValue { get; set; } = null!;
        
        public DateTime CreatedAt { get; set; }
        
        public string CreatedBy { get; set; } = null!;
        
        public DateTime UpdatedAt { get; set; }
        
        public string UpdatedBy { get; set; } = null!;

        public bool IsActive { get; set; }

        public byte[] RowVersion { get; set; } = null!;
    }
}
