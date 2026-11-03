using System;

namespace LitescreenCore.DataModel.Entities
{
    public class AssetType
    {
        public int AssetTypeId { get; set; }
        
        public string Name { get; set; } = null!;

        public string Description { get; set; }

        public string AssetData { get; set; } = null!;

        public DateTime CreatedAt { get; set; }

        public string CreatedBy { get; set; } = null!;

        public DateTime UpdatedAt { get; set; }

        public string UpdatedBy { get; set; } = null!;

        public bool IsActive { get; set; }

        public byte[] RowVersion { get; set; } = null!;
    }
}
