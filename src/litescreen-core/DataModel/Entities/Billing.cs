using System;

namespace LitescreenCore.DataModel.Entities
{
    public class Billing
    {
        public long BillingId { get; set; }

        public long OrganizationId { get; set; }

        public int BillingStatusId { get; set; }

        public DateTime TrialExpirationAt { get; set; }

        public int TrialExtensions { get; set; }

        public DateTime LastBillingStatusAt { get; set; }

        public DateTime CreatedAt { get; set; }

        public string CreatedBy { get; set; } = null!;

        public DateTime UpdatedAt { get; set; }

        public string UpdatedBy { get; set; } = null!;

        public bool IsActive { get; set; }

        public byte[] RowVersion { get; set; } = null!;
    }
}
