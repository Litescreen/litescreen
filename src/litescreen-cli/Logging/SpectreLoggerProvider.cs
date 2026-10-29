using Microsoft.Extensions.Logging;

namespace LitescreenCli.Logging
{
    public sealed class SpectreLoggerProvider : ILoggerProvider
    {
        public ILogger CreateLogger(string categoryName)
            => new SpectreLogger(categoryName);

        public void Dispose() { }
    }
}