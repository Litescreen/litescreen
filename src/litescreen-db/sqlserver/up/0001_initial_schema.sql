CREATE TABLE dbo.Organization (
    OrganizationId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Organization PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    OnboardingCompletedAt DATETIME2 NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(255) NOT NULL,
    UpdatedAt DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,
    IsActive BIT NOT NULL,
    RowVersion ROWVERSION NOT NULL
);

CREATE TABLE dbo.BillingStatus (
    BillingStatusId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_BillingStatus PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(4000) NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(255) NOT NULL,
    UpdatedAt DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,
    IsActive BIT NOT NULL,
    RowVersion ROWVERSION NOT NULL
);

CREATE TABLE dbo.Billing (
    BillingId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Billing PRIMARY KEY,
    OrganizationId BIGINT NOT NULL,
    BillingStatusId INT NOT NULL,
    TrialExpirationAt DATETIME2 NULL,
    TrialExtensions INT NOT NULL,
    LastBillingStatusAt DATETIME2 NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(255) NOT NULL,
    UpdatedAt DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,
    IsActive BIT NOT NULL,
    RowVersion ROWVERSION NOT NULL,
    CONSTRAINT FK_Billing_Organization FOREIGN KEY (OrganizationId) REFERENCES dbo.Organization(OrganizationId),
    CONSTRAINT FK_Billing_BillingStatus FOREIGN KEY (BillingStatusId) REFERENCES dbo.BillingStatus(BillingStatusId)
);

CREATE TABLE dbo.[User] (
    UserId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_User PRIMARY KEY,
    OrganizationId BIGINT NOT NULL,
    ExternalAuthProviderData NVARCHAR(MAX) NOT NULL,
    ExternalId NVARCHAR(255) NOT NULL,
    Email NVARCHAR(320) NOT NULL,
    FirstName NVARCHAR(255) NOT NULL,
    LastName NVARCHAR(255) NULL,
    DisplayName NVARCHAR(255) NOT NULL,
    OnboardingCompletedAt DATETIME2 NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NOT NULL,
    IsActive BIT NOT NULL,
    RowVersion ROWVERSION NOT NULL,
    CONSTRAINT FK_User_Organization FOREIGN KEY (OrganizationId) REFERENCES dbo.Organization(OrganizationId)
);

CREATE TABLE dbo.OrganizationUser (
    OrganizationUserId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_OrganizationUser PRIMARY KEY,
    OrganizationId BIGINT NOT NULL,
    UserId BIGINT NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(255) NOT NULL,
    UpdatedAt DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,
    IsActive BIT NOT NULL,
    RowVersion ROWVERSION NOT NULL,
    CONSTRAINT FK_OrganizationUser_Organization FOREIGN KEY (OrganizationId) REFERENCES dbo.Organization(OrganizationId),
    CONSTRAINT FK_OrganizationUser_User FOREIGN KEY (UserId) REFERENCES dbo.[User](UserId),
    CONSTRAINT UQ_OrganizationUser_Organization_User UNIQUE (OrganizationId, UserId)
);

CREATE TABLE dbo.OrganizationUserInvitationStatus (
    OrganizationUserInvitationStatusId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_OrganizationUserInvitationStatus PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(4000) NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(255) NOT NULL,
    UpdatedAt DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,
    IsActive BIT NOT NULL,
    RowVersion ROWVERSION NOT NULL
);

CREATE TABLE dbo.OrganizationUserInvitation (
    OrganizationUserInvitationId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_OrganizationUserInvitation PRIMARY KEY,
    OrganizationId BIGINT NOT NULL,
    OrganizationUserInvitationStatusId INT NOT NULL,
    Email NVARCHAR(320) NOT NULL,
    Token NVARCHAR(512) NOT NULL,
    InvitedBy NVARCHAR(255) NULL,
    CreatedAt DATETIME2 NOT NULL,
    ExpiresAt DATETIME2 NOT NULL,
    AcceptedAt DATETIME2 NULL,
    RevokedAt DATETIME2 NULL,
    RevokedBy NVARCHAR(255) NULL,
    CONSTRAINT FK_OrganizationUserInvitation_Organization FOREIGN KEY (OrganizationId) REFERENCES dbo.Organization(OrganizationId),
    CONSTRAINT FK_OrganizationUserInvitation_Status FOREIGN KEY (OrganizationUserInvitationStatusId) REFERENCES dbo.OrganizationUserInvitationStatus(OrganizationUserInvitationStatusId),
    CONSTRAINT UQ_OrganizationUserInvitation_Token UNIQUE (Token)
);

CREATE TABLE dbo.OrganizationSetting (
    OrganizationSettingId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_OrganizationSetting PRIMARY KEY,
    OrganizationId BIGINT NOT NULL,
    SettingKey NVARCHAR(255) NOT NULL,
    SettingValue NVARCHAR(4000) NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(255) NOT NULL,
    UpdatedAt DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,
    IsActive BIT NOT NULL,
    RowVersion ROWVERSION NOT NULL,
    CONSTRAINT FK_OrganizationSetting_Organization FOREIGN KEY (OrganizationId) REFERENCES dbo.Organization(OrganizationId),
    CONSTRAINT UQ_OrganizationSetting_Organization_Key UNIQUE (OrganizationId, SettingKey)
);

CREATE TABLE dbo.Environment (
    EnvironmentId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Environment PRIMARY KEY,
    OrganizationId BIGINT NOT NULL,
    Name NVARCHAR(255) NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(255) NOT NULL,
    UpdatedAt DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,
    IsActive BIT NOT NULL,
    RowVersion ROWVERSION NOT NULL,
    CONSTRAINT FK_Environment_Organization FOREIGN KEY (OrganizationId) REFERENCES dbo.Organization(OrganizationId)
);

CREATE TABLE dbo.AssetType (
    AssetTypeId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_AssetType PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(4000) NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(255) NOT NULL,
    UpdatedAt DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,
    IsActive BIT NOT NULL,
    RowVersion ROWVERSION NOT NULL
);

CREATE TABLE dbo.Asset (
    AssetId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Asset PRIMARY KEY,
    AssetTypeId INT NOT NULL,
    EnvironmentId BIGINT NOT NULL,
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(4000) NULL,
    AssetData NVARCHAR(4000) NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(255) NOT NULL,
    UpdatedAt DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,
    IsActive BIT NOT NULL,
    RowVersion ROWVERSION NOT NULL,
    CONSTRAINT FK_Asset_AssetType FOREIGN KEY (AssetTypeId) REFERENCES dbo.AssetType(AssetTypeId),
    CONSTRAINT FK_Asset_Environment FOREIGN KEY (EnvironmentId) REFERENCES dbo.Environment(EnvironmentId)
);

CREATE TABLE dbo.PlaybackStatus (
    PlaybackStatusId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_PlaybackStatus PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(4000) NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(255) NOT NULL,
    UpdatedAt DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,
    IsActive BIT NOT NULL,
    RowVersion ROWVERSION NOT NULL
);

CREATE TABLE dbo.PlayerType (
    PlayerTypeId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_PlayerType PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(4000) NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(255) NOT NULL,
    UpdatedAt DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,
    IsActive BIT NOT NULL,
    RowVersion ROWVERSION NOT NULL
);

CREATE TABLE dbo.ScreenStatus (
    ScreenStatusId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_ScreenStatus PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(4000) NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(255) NOT NULL,
    UpdatedAt DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,
    IsActive BIT NOT NULL,
    RowVersion ROWVERSION NOT NULL
);

CREATE TABLE dbo.Screen (
    ScreenId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Screen PRIMARY KEY,
    EnvironmentId BIGINT NOT NULL,
    ScreenStatusId INT NOT NULL,
    PlaybackStatusId INT NOT NULL,
    Name NVARCHAR(255) NULL,
    Description NVARCHAR(4000) NULL,
    PlayerTypeId INT NOT NULL,
    PlayerVersion NVARCHAR(255) NOT NULL,
    Platform NVARCHAR(255) NOT NULL,
    OperatingSystem NVARCHAR(255) NOT NULL,
    Architecture NVARCHAR(255) NOT NULL,
    RAMCapacity DECIMAL(18,4) NOT NULL,
    RegistrationToken NVARCHAR(512) NOT NULL,
    RegisteredAt DATETIME2 NULL,
    ApiKey NVARCHAR(512) NOT NULL,
    LastUpdateAttemptAt DATETIME2 NULL,
    LastSuccessfulUpdateAt DATETIME2 NULL,
    LastHeartbeat DATETIME2 NULL,
    LastScreenStatusAt DATETIME2 NULL,
    LastPlaybackStatusAt DATETIME2 NULL,
    CreatedAt DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(255) NOT NULL,
    UpdatedAt DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,
    IsActive BIT NOT NULL,
    RowVersion ROWVERSION NOT NULL,
    CONSTRAINT FK_Screen_Environment FOREIGN KEY (EnvironmentId) REFERENCES dbo.Environment(EnvironmentId),
    CONSTRAINT FK_Screen_ScreenStatus FOREIGN KEY (ScreenStatusId) REFERENCES dbo.ScreenStatus(ScreenStatusId),
    CONSTRAINT FK_Screen_PlaybackStatus FOREIGN KEY (PlaybackStatusId) REFERENCES dbo.PlaybackStatus(PlaybackStatusId),
    CONSTRAINT FK_Screen_PlayerType FOREIGN KEY (PlayerTypeId) REFERENCES dbo.PlayerType(PlayerTypeId),
    CONSTRAINT UQ_Screen_RegistrationToken UNIQUE (RegistrationToken),
    CONSTRAINT UQ_Screen_ApiKey UNIQUE (ApiKey)
);

CREATE TABLE dbo.TransitionTriggerType (
    TransitionTriggerTypeId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_TransitionTriggerType PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(4000) NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(255) NOT NULL,
    UpdatedAt DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,
    IsActive BIT NOT NULL,
    RowVersion ROWVERSION NOT NULL
);

CREATE TABLE dbo.Playlist (
    PlaylistId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Playlist PRIMARY KEY,
    EnvironmentId BIGINT NOT NULL,
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(4000) NULL,
    PlaylistItemsLastUpdatedAt DATETIME2 NULL,
    CreatedAt DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(255) NOT NULL,
    UpdatedAt DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,
    IsActive BIT NOT NULL,
    RowVersion ROWVERSION NOT NULL,
    CONSTRAINT FK_Playlist_Environment FOREIGN KEY (EnvironmentId) REFERENCES dbo.Environment(EnvironmentId)
);

CREATE TABLE dbo.PlaylistItem (
    PlaylistItemId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_PlaylistItem PRIMARY KEY,
    PlaylistId BIGINT NOT NULL,
    AssetId BIGINT NOT NULL,
    EnvironmentId BIGINT NOT NULL,
    Name NVARCHAR(255) NULL,
    NavigationOrder INT NOT NULL,
    TransitionTriggerTypeId INT NOT NULL,
    DurationSeconds DECIMAL(18,4) NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(255) NOT NULL,
    UpdatedAt DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,
    IsActive BIT NOT NULL,
    RowVersion ROWVERSION NOT NULL,
    CONSTRAINT FK_PlaylistItem_Playlist FOREIGN KEY (PlaylistId) REFERENCES dbo.Playlist(PlaylistId),
    CONSTRAINT FK_PlaylistItem_Asset FOREIGN KEY (AssetId) REFERENCES dbo.Asset(AssetId),
    CONSTRAINT FK_PlaylistItem_Environment FOREIGN KEY (EnvironmentId) REFERENCES dbo.Environment(EnvironmentId),
    CONSTRAINT FK_PlaylistItem_TransitionTriggerType FOREIGN KEY (TransitionTriggerTypeId) REFERENCES dbo.TransitionTriggerType(TransitionTriggerTypeId)
);

CREATE TABLE dbo.PowerBIDashboardPageViewType (
    DashboardPageViewTypeId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_PowerBIDashboardPageViewType PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(4000) NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(255) NOT NULL,
    UpdatedAt DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,
    IsActive BIT NOT NULL,
    RowVersion ROWVERSION NOT NULL
);

CREATE TABLE dbo.PowerBIDashboardSlideshow (
    PowerBIDashboardSlideshowId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_PowerBIDashboardSlideshow PRIMARY KEY,
    DashboardPageViewTypeId INT NOT NULL,
    EnvironmentId BIGINT NOT NULL,
    Name NVARCHAR(255) NULL,
    GroupId UNIQUEIDENTIFIER NOT NULL,
    DashboardId UNIQUEIDENTIFIER NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(255) NOT NULL,
    UpdatedAt DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,
    IsActive BIT NOT NULL,
    RowVersion ROWVERSION NOT NULL,
    CONSTRAINT FK_PowerBIDashboardSlideshow_PageViewType FOREIGN KEY (DashboardPageViewTypeId) REFERENCES dbo.PowerBIDashboardPageViewType(DashboardPageViewTypeId),
    CONSTRAINT FK_PowerBIDashboardSlideshow_Environment FOREIGN KEY (EnvironmentId) REFERENCES dbo.Environment(EnvironmentId)
);

CREATE TABLE dbo.PowerBIReportSlideshow (
    PowerBIReportSlideshowId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_PowerBIReportSlideshow PRIMARY KEY,
    EnvironmentId BIGINT NOT NULL,
    Name NVARCHAR(255) NULL,
    GroupId UNIQUEIDENTIFIER NOT NULL,
    ReportId UNIQUEIDENTIFIER NOT NULL,
    VisualRefreshIntervalSeconds DECIMAL(18,4) NOT NULL,
    HideNavigationPane BIT NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(255) NOT NULL,
    UpdatedAt DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,
    IsActive BIT NOT NULL,
    RowVersion ROWVERSION NOT NULL,
    CONSTRAINT FK_PowerBIReportSlideshow_Environment FOREIGN KEY (EnvironmentId) REFERENCES dbo.Environment(EnvironmentId)
);

CREATE TABLE dbo.PowerBIReportSlideshowItemType (
    PowerBIReportSlideshowItemTypeId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_PowerBIReportSlideshowItemType PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(4000) NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(255) NOT NULL,
    UpdatedAt DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,
    IsActive BIT NOT NULL,
    RowVersion ROWVERSION NOT NULL
);

CREATE TABLE dbo.PowerBIReportSlideshowItem (
    PowerBIReportSlideshowItemId BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_PowerBIReportSlideshowItem PRIMARY KEY,
    PowerBIReportSlideshowItemTypeId INT NOT NULL,
    PowerBIReportSlideshowId BIGINT NOT NULL,
    EnvironmentId BIGINT NOT NULL,
    PowerBINavigationItemId NVARCHAR(255) NOT NULL,
    NavigationOrder INT NOT NULL,
    DurationSeconds DECIMAL(18,4) NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(255) NOT NULL,
    UpdatedAt DATETIME2 NOT NULL,
    UpdatedBy NVARCHAR(255) NOT NULL,
    IsActive BIT NOT NULL,
    RowVersion ROWVERSION NOT NULL,
    CONSTRAINT FK_PowerBIReportSlideshowItem_Type FOREIGN KEY (PowerBIReportSlideshowItemTypeId) REFERENCES dbo.PowerBIReportSlideshowItemType(PowerBIReportSlideshowItemTypeId),
    CONSTRAINT FK_PowerBIReportSlideshowItem_Slideshow FOREIGN KEY (PowerBIReportSlideshowId) REFERENCES dbo.PowerBIReportSlideshow(PowerBIReportSlideshowId),
    CONSTRAINT FK_PowerBIReportSlideshowItem_Environment FOREIGN KEY (EnvironmentId) REFERENCES dbo.Environment(EnvironmentId)
);

CREATE INDEX IX_Billing_OrganizationId ON dbo.Billing(OrganizationId);
CREATE INDEX IX_Environment_OrganizationId ON dbo.Environment(OrganizationId);
CREATE INDEX IX_Asset_EnvironmentId ON dbo.Asset(EnvironmentId);
CREATE INDEX IX_Screen_EnvironmentId ON dbo.Screen(EnvironmentId);
CREATE INDEX IX_Playlist_EnvironmentId ON dbo.Playlist(EnvironmentId);
CREATE INDEX IX_PlaylistItem_PlaylistId_NavigationOrder ON dbo.PlaylistItem(PlaylistId, NavigationOrder);
CREATE INDEX IX_PowerBIReportSlideshowItem_SlideshowId_NavigationOrder ON dbo.PowerBIReportSlideshowItem(PowerBIReportSlideshowId, NavigationOrder);
