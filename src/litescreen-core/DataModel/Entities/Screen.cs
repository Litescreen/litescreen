using System;

namespace LitescreenCore.DataModel.Entities
{
    public class Screen
    {
        public long ScreenId { get; set; }

        public long EnvironmentId { get; set; }

        public int ScreenStatusId { get; set; }

        public int PlaybackStatusId { get; set; }

        public string? Name { get; set; }

        public string? Description { get; set; }

        public int PlayerTypeId { get; set; }

        public string PlayerVersion { get; set; } = null!;

        public string Platform { get; set; } = null!;

        public string OperatingSystem { get; set; } = null!;

        public string Architecture { get; set; } = null!;

        public decimal RAMCapacity { get; set; }

        public string RegistrationToken { get; set; } = null!;

        public DateTime? RegisteredAt { get; set; }

        public string ApiKey { get; set; } = null!;

        public DateTime? LastUpdateAttemptAt { get; set; }

        public DateTime? LastSuccessfulUpdateAt { get; set; }

        public DateTime? LastHeartbeat { get; set; }

        public DateTime? LastScreenStatusAt { get; set; }

        public DateTime? LastPlaybackStatusAt { get; set; }

        public DateTime CreatedAt { get; set; }

        public string CreatedBy { get; set; } = null!;

        public DateTime UpdatedAt { get; set; }

        public string UpdatedBy { get; set; } = null!;

        public bool IsActive { get; set; }

        public byte[] RowVersion { get; set; } = null!;
    }
}
