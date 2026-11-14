using System.Text.Json.Serialization;

namespace LitescreenConsoleHost.Models
{
    public class HealthCheckStatusResponse
    {
        [JsonPropertyName("status")]
        public string Status { get; set; } = null!;
    }
}
