using System;
using System.Data.Common;
using System.Threading;
using System.Threading.Tasks;
using Dapper;

namespace LitescreenCore.Authentication;

/// <summary>
/// Answers whether an active user has active membership in an active organization
/// that owns the requested resource.
/// </summary>
public sealed class AuthenticationService
{
    private readonly Func<DbConnection> _connectionFactory;

    public AuthenticationService(Func<DbConnection> connectionFactory)
    {
        _connectionFactory = connectionFactory
            ?? throw new ArgumentNullException(nameof(connectionFactory));
    }

    public Task<bool> IsUserActiveMemberOfOrganizationAsync(
        long userId,
        long organizationId,
        CancellationToken cancellationToken = default)
    {
        const string sql = """
            SELECT CONVERT(bit, CASE WHEN EXISTS (
                SELECT 1
                FROM dbo.[User] AS u
                INNER JOIN dbo.OrganizationUser AS ou
                    ON ou.UserId = u.UserId
                INNER JOIN dbo.Organization AS o
                    ON o.OrganizationId = ou.OrganizationId
                WHERE u.UserId = @UserId
                    AND ou.OrganizationId = @OrganizationId
                    AND u.IsActive = 1
                    AND ou.IsActive = 1
                    AND o.IsActive = 1
            ) THEN 1 ELSE 0 END);
            """;

        return ExecuteExistsQueryAsync(sql, new { UserId = userId, OrganizationId = organizationId }, cancellationToken);
    }

    public Task<bool> IsUserActiveMemberOfEnvironmentAsync(
        long userId,
        long environmentId,
        CancellationToken cancellationToken = default)
    {
        const string sql = """
            SELECT CONVERT(bit, CASE WHEN EXISTS (
                SELECT 1
                FROM dbo.[User] AS u
                INNER JOIN dbo.OrganizationUser AS ou
                    ON ou.UserId = u.UserId
                INNER JOIN dbo.Organization AS o
                    ON o.OrganizationId = ou.OrganizationId
                INNER JOIN dbo.Environment AS e
                    ON e.OrganizationId = o.OrganizationId
                WHERE u.UserId = @UserId
                    AND e.EnvironmentId = @EnvironmentId
                    AND u.IsActive = 1
                    AND ou.IsActive = 1
                    AND o.IsActive = 1
                    AND e.IsActive = 1
            ) THEN 1 ELSE 0 END);
            """;

        return ExecuteExistsQueryAsync(sql, new { UserId = userId, EnvironmentId = environmentId }, cancellationToken);
    }

    public Task<bool> IsUserActiveMemberOfAssetEnvironmentAsync(
        long userId,
        long assetId,
        CancellationToken cancellationToken = default)
    {
        const string sql = """
            SELECT CONVERT(bit, CASE WHEN EXISTS (
                SELECT 1
                FROM dbo.[User] AS u
                INNER JOIN dbo.OrganizationUser AS ou
                    ON ou.UserId = u.UserId
                INNER JOIN dbo.Organization AS o
                    ON o.OrganizationId = ou.OrganizationId
                INNER JOIN dbo.Environment AS e
                    ON e.OrganizationId = o.OrganizationId
                INNER JOIN dbo.Asset AS a
                    ON a.EnvironmentId = e.EnvironmentId
                WHERE u.UserId = @UserId
                    AND a.AssetId = @AssetId
                    AND u.IsActive = 1
                    AND ou.IsActive = 1
                    AND o.IsActive = 1
                    AND e.IsActive = 1
                    AND a.IsActive = 1
            ) THEN 1 ELSE 0 END);
            """;

        return ExecuteExistsQueryAsync(sql, new { UserId = userId, AssetId = assetId }, cancellationToken);
    }

    private async Task<bool> ExecuteExistsQueryAsync(
        string sql,
        object parameters,
        CancellationToken cancellationToken)
    {
        await using var connection = _connectionFactory();
        await connection.OpenAsync(cancellationToken);

        return await connection.QuerySingleAsync<bool>(
            new CommandDefinition(sql, parameters, cancellationToken: cancellationToken));
    }
}
