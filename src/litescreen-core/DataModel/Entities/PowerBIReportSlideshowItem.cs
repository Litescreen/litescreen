using System;

namespace LitescreenCore.DataModel.Entities
{
    public class PowerBIReportSlideshowItem
    {
        public long PowerBIReportSlideshowItemId { get; set; }

        public int PowerBIReportSlideshowItemTypeId { get; set; }

        public long PowerBIReportSlideshowId { get; set; }

        public long EnvironmentId { get; set; }

        public string PowerBINavigationItemId { get; set; } = null!;

        public int NavigationOrder { get; set; }

        public decimal DurationSeconds { get; set; }

        public DateTime CreatedAt { get; set; }

        public string CreatedBy { get; set; } = null!;

        public DateTime UpdatedAt { get; set; }

        public string UpdatedBy { get; set; } = null!;

        public bool IsActive { get; set; }

        public byte[] RowVersion { get; set; } = null!;
    }
}