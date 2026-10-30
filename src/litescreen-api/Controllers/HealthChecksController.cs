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
        /// Simple endpoint that returns a default 200 and healthy status. This is used just to make sure the API is accessible.
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
