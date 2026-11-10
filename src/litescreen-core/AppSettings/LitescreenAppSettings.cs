namespace LitescreenCore.AppSettings
{
    public class LitescreenAppSettings
    {
        public R2Settings R2Settings { get; set; } = null!;
    }

    public class R2Settings
    {
        public string AccessKeyId { get; set; } = null!;
        
        public string SecretAccessKey { get; set; } = null!;

        public string AccountId { get; set; } = null!;

        public string BucketName { get; set; } = null!;

        public int DefaultPresignedUrlExpirationMinutes { get; set; }
    }
}
