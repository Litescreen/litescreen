using System;

namespace LitescreenCore.DataModel.Entities
{
    public class PowerBIDashboardSlideshow
    {
        public long PowerBIDashboardSlideshowId { get; set; }

        public int DashboardPageViewTypeId { get; set; }

        public long EnvironmentId { get; set; }

        public string? Name { get; set; }

        public Guid GroupId { get; set; }

        public Guid DashboardId { get; set; }

        public DateTime CreatedAt { get; set; }

        public string CreatedBy { get; set; } = null!;

        public DateTime UpdatedAt { get; set; }

        public string UpdatedBy { get; set; } = null!;

        public bool IsActive { get; set; }

        public byte[] RowVersion { get; set; } = null!;
    }
}
