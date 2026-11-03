using System;

namespace LitescreenCore.DataModel.Entities
{
    public class PlaylistItem
    {
        public long PlaylistItemId { get; set; }

        public long PlaylistId { get; set; }

        public long AssetId { get; set; }

        public long EnvironmentId { get; set; }

        public string? Name { get; set; }

        public int NavigationOrder { get; set; }

        public int TransitionTriggerTypeId { get; set; }

        public decimal DurationSeconds { get; set; }

        public DateTime CreatedAt { get; set; }

        public string CreatedBy { get; set; } = null!;

        public DateTime UpdatedAt { get; set; }

        public string UpdatedBy { get; set; } = null!;

        public bool IsActive { get; set; }

        public byte[] RowVersion { get; set; } = null!;
    }
}
