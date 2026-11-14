using Microsoft.Extensions.Logging;
using System;
using System.IO;
using System.Text.Json;

namespace LitescreenCore.Config
{
    public class ConfigService
    {
        private readonly ILogger<ConfigService> _logger;
        private readonly JsonSerializerOptions _jsonSerializerOptions;

        public ConfigService(ILogger<ConfigService> logger)
        {
            _logger = logger;
            _jsonSerializerOptions = new JsonSerializerOptions
            {
                WriteIndented = true,
                PropertyNameCaseInsensitive = true
            };
        }

        public static string GetAppDirectory()
        {
            var exePath = Environment.ProcessPath
                ?? throw new Exception("Could not determine application directory.");
            return Path.GetDirectoryName(exePath)
                ?? throw new Exception("Could not determine application directory.");
        }

        public static string GetAppDataDirectory()
        {
            return Path.Combine(
                Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData),
                CoreConstants.PlatformName);
        }

        public static string GetConfigPath()
        {
            var appDirectory = GetAppDirectory();
            var localPath = Path.Combine(
                appDirectory,
                CoreConstants.ConfigFileName);

            if (File.Exists(localPath))
                return localPath;

            var appDataDirectory = GetAppDataDirectory();
            var appDataPath = Path.Combine(appDataDirectory, CoreConstants.ConfigFileName);

            if (File.Exists(appDataPath))
                return appDataPath;

            throw new Exception(
                "Could not find a config file in either the application directory or the AppData directory. Please initialize a config file."
                );
        }
    }
}
