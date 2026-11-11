using System.Data.Common;

namespace LitescreenCore.Database;

/// <summary>
/// Creates connections for the configured database provider. Use the returned connection
/// with Dapper's extension methods and dispose it after each unit of work.
/// </summary>
public interface IDatabaseService
{
    /// <summary>
    /// Determines the database provider from the settings.
    /// </summary>
    /// <returns>The database provider as a constants string.</returns>
    string GetDatabaseProvider();

    /// <summary>
    /// Creates a closed connection for the database provider.
    /// </summary>
    /// <returns>The database connection.</returns>
    DbConnection CreateConnection();
}
