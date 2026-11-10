-- ===========================================================================
-- Reusable SQL variables
-- ===========================================================================

DECLARE @System nvarchar(255) = 'litescreen'
;
DECLARE @Now datetime2 = GETUTCDATE()
;
DECLARE @Active bit = 1
;
DECLARE @Inactive bit = 0
;

-- ===========================================================================
-- Seeding
-- ===========================================================================

INSERT INTO dbo.PlayerType
(
	Name
	,Description
	,CreatedAt
	,CreatedBy
	,UpdatedAt
	,UpdatedBy
	,IsActive
)
VALUES
	('Desktop', 'The cross-platform Litescreen Desktop player.', @Now, @System, @Now, @System, @Active);

INSERT INTO dbo.BillingStatus
(
	Name
	,Description
	,CreatedAt
	,CreatedBy
	,UpdatedAt
	,UpdatedBy
	,IsActive
)
VALUES
	('Active Trial', 'The organization has an active trial running.', @Now, @System, @Now, @System, @Active)
	,('Expired Trial', 'The organization had an active trial running and failed to convert.', @Now, @System, @Now, @System, @Active)
	,('Active Customer', 'The organization is an active customer.', @Now, @System, @Now, @System, @Active)
	,('Churned Customer', 'The organization is a churned customer.', @Now, @System, @Now, @System, @Active);

INSERT INTO dbo.ScreenStatus
(
	Name
	,Description
	,CreatedAt
	,CreatedBy
	,UpdatedAt
	,UpdatedBy
	,IsActive
)
VALUES
	('Online', 'The screen is online and functional.', @Now, @System, @Now, @System, @Active)
	,('Offline', 'The screen is offline and nonfunctional.', @Now, @System, @Now, @System, @Active)
	,('Updating', 'The screen is updating its player client.', @Now, @System, @Now, @System, @Active);

INSERT INTO dbo.PlaybackStatus
(
	Name
	,Description
	,CreatedAt
	,CreatedBy
	,UpdatedAt
	,UpdatedBy
	,IsActive
)
VALUES
	('Playing', 'The screen player is playing content.', @Now, @System, @Now, @System, @Active)
	,('Paused', 'The screen player content has been paused.', @Now, @System, @Now, @System, @Active)
	,('Stopped', 'The screen player content has been stopped.', @Now, @System, @Now, @System, @Active)
	,('Idle', 'The screen player is available to play content.', @Now, @System, @Now, @System, @Active)
	,('Synchronizing', 'The screen player content is synchronizing.', @Now, @System, @Now, @System, @Active);

INSERT INTO dbo.TransitionTriggerType
(
	Name
	,Description
	,CreatedAt
	,CreatedBy
	,UpdatedAt
	,UpdatedBy
	,IsActive
)
VALUES
	('Countdown', 'The asset triggers a playlist transition upon the completion of a timed countdown.', @Now, @System, @Now, @System, @Active)
	,('Asset', 'The asset triggers a playlist transition from an internal mechanism.', @Now, @System, @Now, @System, @Active);

INSERT INTO dbo.AssetType
(
	Name
	,Description
	,CreatedAt
	,CreatedBy
	,UpdatedAt
	,UpdatedBy
	,IsActive
)
VALUES
	('Image', 'An image file.', @Now, @System, @Now, @System, @Active)
	,('Video', 'A video file.', @Now, @System, @Now, @System, @Active)
	,('Web Page', 'A web page.', @Now, @System, @Now, @System, @Active)
	,('Power BI Report Slideshow', 'A Power BI Report Slideshow.', @Now, @System, @Now, @System, @Active)
	,('Power BI Dashboard Slideshow', 'A Power BI Dashboard Slideshow.', @Now, @System, @Now, @System, @Active);

INSERT INTO dbo.MimeType
(
    Name,
    Description,
    CreatedAt,
    CreatedBy,
    UpdatedAt,
    UpdatedBy,
    IsActive
)
SELECT
    seed.MimeType
    ,seed.Description
	,@Now
	,@System
	,@Now
	,@System
	,@Active
FROM
(
    VALUES
        -- Images
        (N'image/jpeg', N'JPEG image.'),
        (N'image/png',  N'PNG image.'),
        (N'image/gif',  N'GIF image.'),
        (N'image/webp', N'WebP image.'),

        -- Audio
        (N'audio/mpeg', N'MPEG audio, commonly MP3.'),
        (N'audio/wav',  N'WAV audio.'),
        (N'audio/ogg',  N'Ogg audio.'),
        (N'audio/flac', N'FLAC audio.'),

        -- Video
        (N'video/mp4',  N'MP4 video.'),
        (N'video/webm', N'WebM video.')
) AS seed (MimeType, Description)

INSERT INTO dbo.StorageProviderType
(
	Name
	,Description
	,CreatedAt
	,CreatedBy
	,UpdatedAt
	,UpdatedBy
	,IsActive
)
VALUES
	('Filesystem', 'The image is located on the server filesystem.', @Now, @System, @Now, @System, @Inactive)
	,('Cloudflare R2', 'The image is located in the Cloudflare R2 storage service.', @Now, @System, @Now, @System, @Active)
	,('Azure Blob', 'The image is located in the Azure Blob storage service.', @Now, @System, @Now, @System, @Inactive)
	,('AWS S3', 'The image is located in the AWS S3 storage service.', @Now, @System, @Now, @System, @Inactive)