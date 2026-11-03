using System;

namespace LitescreenCore.DataModel.Entities
{
    public class PowerBIReportSlideshow
    {
        public long PowerBIReportSlideshowId { get; set; }

        public long EnvironmentId { get; set; }

        public string? Name { get; set; }

        public Guid GroupId { get; set; }

        public Guid ReportId { get; set; }

        public decimal VisualRefreshIntervalSeconds { get; set; }

        public bool HideNavigationPane { get; set; }

        public DateTime CreatedAt { get; set; }

        public string CreatedBy { get; set; } = null!;

        public DateTime UpdatedAt { get; set; }

        public string UpdatedBy { get; set; } = null!;

        public bool IsActive { get; set; }

        public byte[] RowVersion { get; set; } = null!;
    }
}
