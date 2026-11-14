using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace LitescreenCore.Config
{
    public class LitescreenConfig
    {
        [JsonPropertyName("activeProfile")]
        public string ActiveProfile { get; set; } = string.Empty;

        [JsonPropertyName("profiles")]
        public Dictionary<string, LitescreenConfigProfile> Profiles { get; set; } = [];
    }

    public class LitescreenConfigProfile
    {
        [JsonPropertyName("cli")]
        public Cli? Cli { get; set; }

        [JsonPropertyName("api")]
        public Api? Api { get; set; }

        [JsonPropertyName("console")]
        public Console? Console { get; set; }

        [JsonPropertyName("desktop")]
        public Desktop? Desktop { get; set; }
    }

    public class Api
    {
        [JsonPropertyName("r2")]
        public R2 R2 { get; set; } = null!;

        [JsonPropertyName("database")]
        public Database Database { get; set; } = null!;

    }

    public class R2
    {
        [JsonPropertyName("accessKeyId")]
        public string AccessKeyId { get; set; } = null!;

        [JsonPropertyName("secretAccessKey")]
        public string SecretAccessKey { get; set; } = null!;

        [JsonPropertyName("accountId")]
        public string AccountId { get; set; } = null!;

        [JsonPropertyName("bucketName")]
        public string BucketName { get; set; } = null!;

        [JsonPropertyName("defaultPresignedUrlExpirationMinutes")]
        public int DefaultPresignedUrlExpirationMinutes { get; set; }
    }

    public class Database
    {
        [JsonPropertyName("provider")]
        public string Provider { get; set; } = null!;

        [JsonPropertyName("connectionString")]
        public string ConnectionString { get; set; } = null!;
    }

    public class Cli
    {
        [JsonPropertyName("apiBaseUrl")]
        public string ApiBaseUrl { get; set; } = null!;
    }

    public class Console
    {
        [JsonPropertyName("apiBaseUrl")]
        public string ApiBaseUrl { get; set; } = null!;
    }

    public class Desktop
    {
        [JsonPropertyName("apiBaseUrl")]
        public string ApiBaseUrl { get; set; } = null!;
    }
}