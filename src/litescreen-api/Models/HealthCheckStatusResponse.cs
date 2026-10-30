using System.Text.Json.Serialization;

namespace LitescreenApi.Models
{
    public class HealthCheckStatusResponse
    {
        [JsonPropertyName("status")]
        public string Status { get; set; } = null!;
    }
}
