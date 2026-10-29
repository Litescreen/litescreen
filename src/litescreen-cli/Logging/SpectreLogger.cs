using Microsoft.Extensions.Logging;
using Spectre.Console;

namespace LitescreenCli.Logging
{
    public sealed class SpectreLogger : ILogger
    {
        private sealed class NullScope : IDisposable
        {
            public static readonly NullScope Instance = new();
            public void Dispose() { }
        }

        private readonly string _category;

        public SpectreLogger(string category)
        {
            _category = category;
        }

        public IDisposable BeginScope<TState>(TState state) where TState : notnull => NullScope.Instance;

        public bool IsEnabled(LogLevel logLevel) => true;

        public void Log<TState>(
            LogLevel logLevel,
            EventId eventId,
            TState state,
            Exception? exception,
            Func<TState, Exception?, string> formatter)
        {
            var message = formatter(state, exception);

            var prefix = logLevel switch
            {
                LogLevel.Information => "[grey]",
                LogLevel.Warning => "[yellow]",
                LogLevel.Error => "[red]",
                LogLevel.Critical => "[bold red]",
                _ => "[dim]"
            };

            AnsiConsole.MarkupLine($"{prefix}{message}[/]");

            if (exception != null)
            {
                AnsiConsole.WriteException(exception);
            }
        }
    }
}
