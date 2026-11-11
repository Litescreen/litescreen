using Amazon.Runtime;
using Amazon.S3;
using Amazon.S3.Model;
using LitescreenCore.AppSettings;
using Microsoft.Extensions.Logging;
using System;

namespace LitescreenCore.StorageProviders
{
    public class R2Service
    {
        private readonly ILogger<R2Service> _logger;
        private readonly LitescreenAppSettings _litescreenAppSettings;
        private readonly IAmazonS3 _s3Client;

        public R2Service(ILogger<R2Service> logger, LitescreenAppSettings litescreenAppSettings)
        {
            _logger = logger;
            _litescreenAppSettings = litescreenAppSettings;
            _s3Client = SetupS3Client();
        }

        private IAmazonS3 SetupS3Client()
        {
            var accessKey = _litescreenAppSettings.R2Settings.AccessKeyId;
            var secretKey = _litescreenAppSettings.R2Settings.SecretAccessKey;
            var credentials = new BasicAWSCredentials(accessKey, secretKey);
            return new AmazonS3Client(credentials, new AmazonS3Config
            {
                ServiceURL = $"https://{_litescreenAppSettings.R2Settings.AccountId}.r2.cloudflarestorage.com"
            });
        }

        public string? GeneratePresignedDownloadUrl(string objectKey)
        {
            var presign = new GetPreSignedUrlRequest
            {
                BucketName = _litescreenAppSettings.R2Settings.BucketName,
                Key = objectKey,
                Verb = HttpVerb.GET,
                Expires = DateTime.UtcNow.AddMinutes(_litescreenAppSettings.R2Settings.DefaultPresignedUrlExpirationMinutes),
            };

            var presignedUrl = _s3Client.GetPreSignedURL(presign);
            return presignedUrl;
        }

        public string? GeneratePresignedUploadUrl(string objectKey)
        {
            var presign = new GetPreSignedUrlRequest
            {
                BucketName = _litescreenAppSettings.R2Settings.BucketName,
                Key = objectKey,
                Verb = HttpVerb.PUT,
                Expires = DateTime.UtcNow.AddMinutes(_litescreenAppSettings.R2Settings.DefaultPresignedUrlExpirationMinutes),
            };

            var presignedUrl = _s3Client.GetPreSignedURL(presign);
            return presignedUrl;
        }
    }
}