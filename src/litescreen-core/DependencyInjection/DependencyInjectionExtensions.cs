using LitescreenCore.AppSettings;
using LitescreenCore.Authentication;
using LitescreenCore.Database;
using LitescreenCore.StorageProviders;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using System;

namespace LitescreenCore.DependencyInjection;

/// <summary>
/// Registers the services provided by Litescreen.Core.
/// </summary>
public static class DependencyInjectionExtensions
{
    /// <summary>
    /// Adds Litescreen.Core services and binds settings from the "Litescreen" configuration section.
    /// </summary>
    public static IServiceCollection AddLitescreenCore(
        this IServiceCollection services,
        IConfiguration configuration)
    {
        ArgumentNullException.ThrowIfNull(services);
        ArgumentNullException.ThrowIfNull(configuration);

        var settings = configuration
            .Get<LitescreenAppSettings>() ?? new LitescreenAppSettings();

        services.AddSingleton(settings);
        services.AddSingleton<R2Service>();
        services.AddSingleton<AuthenticationService>();
        services.AddSingleton<IDatabaseService, DatabaseService>();

        return services;
    }
}
