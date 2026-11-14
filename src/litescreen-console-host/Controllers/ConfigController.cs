using Microsoft.AspNetCore.Mvc;

namespace LitescreenConsoleHost.Controllers
{
    [Route("api/v1/[controller]")]
    [ApiController]
    public class ConfigController : ControllerBase
    {
        private readonly ILogger<ConfigController> _logger;

        public ConfigController(ILogger<ConfigController> logger)
        {
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        /// <summary>
        /// Get the configuration for the console host.
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(object))]
        public ActionResult<object> GetConfig()
        {
            var config = new
            {
                AppName = HostConstants.AppName,
                Version = HostConstants.SwaggerVersion,
                SwaggerEndpoint = "/openapi/v1.json"
            };
            return Ok(config);
        }
    }
}
