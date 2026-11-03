using System;

namespace LitescreenCore.DataModel.Entities
{
    public class Playlist
    {
        public long PlaylistId { get; set; }

        public long EnvironmentId { get; set; }

        public string Name { get; set; } = null!;

        public string? Description { get; set; }

        public DateTime? PlaylistItemsLastUpdatedAt { get; set; }

        public DateTime CreatedAt { get; set; }
        
        public string CreatedBy { get; set; } = null!;
        
        public DateTime UpdatedAt { get; set; }
        
        public string UpdatedBy { get; set; } = null!;

        public bool IsActive { get; set; }

        public byte[] RowVersion { get; set; } = null!;
    }
}