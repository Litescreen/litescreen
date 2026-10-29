using LitescreenCli;
using LitescreenCli.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Spectre.Console.Cli;

var builder = Host.CreateApplicationBuilder(args);

builder.Logging.ClearProviders();
builder.Logging.AddProvider(new LitescreenCli.Logging.SpectreLoggerProvider());

var registrar = new TypeRegistrar(builder.Services);
var app = new CommandApp(registrar);
app.Configure(config =>
{
    config.SetApplicationName(CliConstants.AppName.ToLower());
});

return app.Run(args);