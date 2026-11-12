using LitescreenCore.AppSettings;
using Microsoft.Data.SqlClient;
using Npgsql;
using System;
using System.Data.Common;
using System.IO;
using System.Reflection;

namespace LitescreenCore.Database;

public sealed class DatabaseService : IDatabaseService
{
    private readonly LitescreenAppSettings _litescreenAppSettings;

    public DatabaseService(LitescreenAppSettings litescreenAppSettings)
    {
        _litescreenAppSettings = litescreenAppSettings;
    }

    public string GetDatabaseProvider()
    {
        return _litescreenAppSettings.DatabaseSettings.Provider?.Trim().ToLowerInvariant() ?? string.Empty;
    }

    public DbConnection CreateConnection()
    {
        var connectionString = _litescreenAppSettings.DatabaseSettings.ConnectionString;

        if (string.IsNullOrWhiteSpace(connectionString))
        {
            throw new InvalidOperationException($"{nameof(_litescreenAppSettings.DatabaseSettings.ConnectionString)} must be configured.");
        }

        return GetDatabaseProvider() switch
        {
            CoreConstants.DatabaseProviders.SqlServer => new SqlConnection(connectionString),
            CoreConstants.DatabaseProviders.Postgres => new NpgsqlConnection(connectionString),
            _ => throw new InvalidOperationException(
                $"Unsupported database provider '{_litescreenAppSettings.DatabaseSettings.Provider}'. Please use a whitelisted database provider.")
        };
    }

    private string BuildEmbeddedSqlFilename(string sqlFilename)
    {
        var databaseProviderFolderName = GetDatabaseProvider() switch
        {
            CoreConstants.DatabaseProviders.SqlServer => CoreConstants.DatabaseProvidersMappedsqlFolderNames.SqlServer,
            CoreConstants.DatabaseProviders.Postgres => CoreConstants.DatabaseProvidersMappedsqlFolderNames.Postgres,
            _ => throw new InvalidOperationException(
                $"Unsupported database provider '{_litescreenAppSettings.DatabaseSettings.Provider}'. Please use a whitelisted database provider.")
        };

        return string.Concat(nameof(LitescreenCore), "Database", databaseProviderFolderName, sqlFilename);
    }
        

    public string LoadSqlFile(string sqlFilename)
    {
        var embeddedSqlFilename = BuildEmbeddedSqlFilename(sqlFilename);

        using var stream = Assembly.GetExecutingAssembly().GetManifestResourceStream(embeddedSqlFilename)
            ?? throw new FileNotFoundException($"SQL resource '{embeddedSqlFilename}' not found.");
        
        using var reader = new StreamReader(stream);
        return reader.ReadToEnd();
    }
}
