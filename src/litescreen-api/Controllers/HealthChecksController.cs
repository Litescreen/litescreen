using LitescreenApi.Models;
using Microsoft.AspNetCore.Mvc;

namespace LitescreenApi.Controllers
{
    [Route("api/v1/[controller]")]
    [ApiController]
    public class HealthChecksController : ControllerBase
    {
        private readonly ILogger<HealthChecksController> _logger;

        private const string HealthyStatus = "Healthy";
        private const string DegradedStatus = "Degraded";
        private const string UnhealthyStatus = "Unhealthy";

        public HealthChecksController(ILogger<HealthChecksController> logger)
        {
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        /// <summary>
        /// Healthcheck for the API itself.
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(HealthCheckStatusResponse))]
        public ActionResult<HealthCheckStatusResponse> CheckApiHealth()
        {
            var status = new HealthCheckStatusResponse() { Status = HealthyStatus };
            return Ok(status);
        }
    }
}
