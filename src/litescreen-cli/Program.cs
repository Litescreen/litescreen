using LitescreenCli;
using LitescreenCli.DependencyInjection;
using LitescreenCli.Settings;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Spectre.Console.Cli;
using System.Reflection;

var builder = Host.CreateApplicationBuilder(args);

#region Read embedded app settings.

using (var appSettingsStream = Assembly.GetExecutingAssembly()
    .GetManifestResourceStream("LitescreenCli.appsettings.json")
    ?? throw new InvalidOperationException("Could not load embedded appsettings.json."))
{
    builder.Configuration.AddJsonStream(appSettingsStream);
}

builder.Services.Configure<AppSettings>(builder.Configuration);

#endregion

builder.Logging.ClearProviders();
builder.Logging.AddProvider(new LitescreenCli.Logging.SpectreLoggerProvider());

var registrar = new TypeRegistrar(builder.Services);
var app = new CommandApp(registrar);
app.Configure(config =>
{
    config.SetApplicationName(CliConstants.AppName.ToLower());
});

return app.Run(args);