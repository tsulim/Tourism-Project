--Trillium's Destroy all Constraints and Tables Copy Pasta Codes (START)--
DECLARE @SQL VARCHAR(MAX)=''
SELECT @SQL = @SQL + 'ALTER TABLE ' + QUOTENAME(FK.TABLE_SCHEMA) + '.' + QUOTENAME(FK.TABLE_NAME) + ' DROP CONSTRAINT [' + RTRIM(C.CONSTRAINT_NAME) +'];' + CHAR(13)
--SELECT K_Table = FK.TABLE_NAME, FK_Column = CU.COLUMN_NAME, PK_Table = PK.TABLE_NAME, PK_Column = PT.COLUMN_NAME, Constraint_Name = C.CONSTRAINT_NAME
  FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS C
 INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS FK
	ON C.CONSTRAINT_NAME = FK.CONSTRAINT_NAME
 INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS PK
	ON C.UNIQUE_CONSTRAINT_NAME = PK.CONSTRAINT_NAME
 INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE CU
	ON C.CONSTRAINT_NAME = CU.CONSTRAINT_NAME
 INNER JOIN (
			SELECT i1.TABLE_NAME, i2.COLUMN_NAME
			  FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS i1
			 INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE i2
				ON i1.CONSTRAINT_NAME = i2.CONSTRAINT_NAME
			WHERE i1.CONSTRAINT_TYPE = 'PRIMARY KEY'
		   ) PT
	ON PT.TABLE_NAME = PK.TABLE_NAME

EXEC (@SQL)
PRINT @SQL


DECLARE @sql2 NVARCHAR(max)=''

SELECT @sql2 += ' Drop table ' + QUOTENAME(TABLE_SCHEMA) + '.'+ QUOTENAME(TABLE_NAME) + '; '
FROM   INFORMATION_SCHEMA.TABLES
WHERE  TABLE_TYPE = 'BASE TABLE'

Exec Sp_executesql @sql2
--Trillium's Destroy all Constraints and Tables Copy Pasta Codes (END)--


--Table of Contents

--> Global
--> User 
--Xiu Jia
--> Location
--> Promotion
--> Statistics
--> Ticket
--> Location Promotion
--Trillium
--> Events
--> Blog
--> Comment
--> Event Location
--Hui En
--> Tour
--> Booking
--> Review
--> Tour Location
--Nazrie
--> Policy
--> Reminder
--> Invoice
--> Feedback


--Table Creation Codes (START)
CREATE TABLE [dbo].[User]
(
	[Id] INT IDENTITY(1, 1) NOT NULL PRIMARY KEY, 
	[GoogleId] NVARCHAR(MAX) NULL, 
	[ProfImage] NVARCHAR(MAX) NULL, 
	[Name] NVARCHAR(MAX) NULL, 
	[PasswordHash] NVARCHAR(MAX) NULL,
	[PasswordSalt] NVARCHAR(MAX) NULL,
	[Email] NVARCHAR(50) NULL, 
	[Contact] NVARCHAR(20) NULL, 
	[Authorization] INT NULL,
	[StripeId] NVARCHAR(MAX) NULL,
	[IV]           NVARCHAR (MAX) NULL,
	[Key]          NVARCHAR (MAX) NULL,
)

--CREATE TABLE [dbo].[CreditCard]
--(
--	[Id] INT NOT NULL PRIMARY KEY, 
--)

-- Xiu Jia

CREATE TABLE [dbo].[Location]
(
	[Id] INT IDENTITY(1, 1) NOT NULL PRIMARY KEY, 
	[Name] NVARCHAR(MAX) NULL, 
	[Address] NVARCHAR(MAX) NULL, 
	[Details] NVARCHAR(MAX) NULL,
	[Type] NVARCHAR(20) NULL, 
	[Images] NVARCHAR(MAX) NULL, 
	[Status] BIT NULL,
	[UserId] INT NULL, 
	CONSTRAINT [FK_Location_ToUser] FOREIGN KEY ([UserId]) REFERENCES [User]([Id])
)

CREATE TABLE [dbo].[Statistic]
(
	[Id] INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[SDate] DATE NULL,
	[Revenue] FLOAT NULL,
	[LocationId] INT NULL,
	CONSTRAINT [FK_Statistic_ToLocation] FOREIGN KEY ([LocationId]) REFERENCES [Location]([Id])
)

CREATE TABLE [dbo].[Promotion]
(
	[Id] INT IDENTITY(1, 1) NOT NULL PRIMARY KEY, 
	[Title] NVARCHAR(50) NULL, 
	[Details] NVARCHAR(MAX) NULL,
	[StartDate] DATETIME NULL, 
	[EndDate] DATETIME NULL, 
	[LocationArr] NVARCHAR(MAX) NULL,
	[UserId] INT NULL,
	CONSTRAINT [FK_Promotion_ToUser] FOREIGN KEY ([UserId]) REFERENCES [User]([Id])
)

CREATE TABLE [dbo].[Ticket]
(
	[Id] INT IDENTITY(1, 1) NOT NULL PRIMARY KEY, 
	[Name] NVARCHAR(MAX) NULL, 
	[Price] FLOAT NULL, 
	[SoldAmount] INT NULL, 
	[LocationId] INT NULL, 
	CONSTRAINT [FK_Ticket_ToLocation] FOREIGN KEY ([LocationId]) REFERENCES [Location]([Id])
)

CREATE TABLE [dbo].[PurchasedTicket]
(
	[Id] INT IDENTITY(1, 1) NOT NULL PRIMARY KEY, 
	[Quantity] FLOAT NULL, 
	[Status] INT NULL,
	[TicketId] INT NULL, 
	[UserId] INT NULL,
	CONSTRAINT [FK_PurchasedTicket_ToTicket] FOREIGN KEY ([TicketId]) REFERENCES [Ticket]([Id]),
	CONSTRAINT [FK_PurchasedTicket_ToUser] FOREIGN KEY ([UserId]) REFERENCES [User]([Id])
)

CREATE TABLE [dbo].[LocationPromotion]
(
	[LocationId] INT NOT NULL,
	[PromotionId] INT NOT NULL,
	CONSTRAINT [FK_LocationPromotion_ToLocation] FOREIGN KEY ([LocationId]) REFERENCES [Location]([Id]), 
	CONSTRAINT [FK_LocationPromotion_ToPromotion] FOREIGN KEY ([PromotionId]) REFERENCES [Promotion]([Id]), 
	CONSTRAINT [PK_LocationPromotion] PRIMARY KEY ([LocationId], [PromotionId])
)

CREATE TABLE [dbo].[Blog]
(
	[Id] INT IDENTITY(1, 1) NOT NULL PRIMARY KEY, 
	[Content] NVARCHAR(MAX) NULL, 
	[ImageArr] NVARCHAR(MAX) NULL, 
	[Like] INT NULL, 
	[LocationId] INT NULL, 
	CONSTRAINT [FK_Blog_ToLocation] FOREIGN KEY ([LocationId]) REFERENCES [Location]([Id])
)

CREATE TABLE [dbo].[Like]
(
	[Id] INT IDENTITY(1, 1) NOT NULL PRIMARY KEY, 
	[Status] BIT NULL DEFAULT 0,
	[BlogId] INT NULL, 
	CONSTRAINT [FK_Like_ToBlog] FOREIGN KEY ([BlogId]) REFERENCES [Blog]([Id])
)

CREATE TABLE [dbo].[Comment]
(
	[Id] INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	[Content] NVARCHAR(MAX) NULL, 
	[BlogId] INT NULL,
	CONSTRAINT [FK_Comment_ToBlog] FOREIGN KEY ([BlogId]) REFERENCES [Blog]([Id])
)

-- Trillium

CREATE TABLE [dbo].[Event]
(
	[Id] INT IDENTITY(1, 1) NOT NULL PRIMARY KEY, 
	[Name] NVARCHAR(50) NULL, 
	[Location] NVARCHAR(MAX) NULL, 
	[Status] NVARCHAR(MAX) NULL, 
	[Desc] NVARCHAR(MAX) NULL, 
	[Images] NVARCHAR(MAX) NULL, 
	[EStartDate] DATETIME NULL, 
	[EEndDate] DATETIME NULL, 
	
	[ProgCreated] INT NOT NULL, 
	[PStartDate] DATETIME NULL, 
	[PEndDate] DATETIME NULL, 

	[UserId] INT NULL,
	CONSTRAINT [FK_Event_ToUser] FOREIGN KEY ([UserId]) REFERENCES [User]([Id]),
)

CREATE TABLE [dbo].[EventTeam]
(
	[Id] INT IDENTITY(1, 1) NOT NULL PRIMARY KEY, 
	[TeamName] NVARCHAR(50) NULL, 
	[ContactEmail] NVARCHAR(MAX) NULL, 
	
	[TStartDate] DATETIME NULL, 
	[TEndDate] DATETIME NULL, 

	[EventId] INT NULL,
	[TeamLeader] INT NULL,
	CONSTRAINT [FK_EventTeam_ToEvent] FOREIGN KEY ([EventId]) REFERENCES [Event]([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_EventTeam_ToUser] FOREIGN KEY ([TeamLeader]) REFERENCES [User]([Id]),
)

CREATE TABLE [dbo].[EventTask]
(
	[Id] INT IDENTITY(1, 1) NOT NULL PRIMARY KEY, 
	[Name] NVARCHAR(50) NULL, 
	[Description] NVARCHAR(MAX) NULL, 
	[Difficulty] NVARCHAR(MAX) NULL, 
    [Completed] BIT NULL, 
	
	[TeamId] INT NULL,
	CONSTRAINT [FK_EventTask_ToEventTeam] FOREIGN KEY ([TeamId]) REFERENCES [EventTeam]([Id]) ON DELETE CASCADE,
)

CREATE TABLE [dbo].[LocationEvent]
(
	[LocationId] INT NOT NULL,
	[EventId] INT NOT NULL,
	CONSTRAINT [FK_LocationEvent_ToLocation] FOREIGN KEY ([LocationId]) REFERENCES [Location]([Id]), 
	CONSTRAINT [FK_LocationEvent_ToEvent] FOREIGN KEY ([EventId]) REFERENCES [Event]([Id]), 
	CONSTRAINT [PK_LocationEvent] PRIMARY KEY ([LocationId], [EventId])
)

-- The Event Planner Tables, add it in baka

-- Hui En

CREATE TABLE [dbo].[Tour] (
    [Id]       INT            IDENTITY (1, 1) NOT NULL,
    [Title]    NVARCHAR (MAX) NULL,
    [Image]    NVARCHAR (MAX) NULL,
    [Details]  NVARCHAR (MAX) NULL,
    [DateTime] NVARCHAR (MAX) NULL,
    [Price]    FLOAT (53)     NULL,
    [MinPpl]   INT            NULL,
    [MaxPpl]   INT            NULL,
	[AvailSlots] INT		  NULL,
    [Iti]      NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


CREATE TABLE [dbo].[Booking] (
	[Id]        INT            NOT NULL,
	[StartDate] DATE           NULL,
	[EndDate]   DATE           NULL,
	[CreateDate] DATETIME NULL,
	[AmtPpl]    INT            NULL,
	[Status]    NVARCHAR (30) NULL,
	[TourId] INT NULL, 
	PRIMARY KEY CLUSTERED ([Id] ASC), 
	CONSTRAINT [FK_Booking_ToTour] FOREIGN KEY ([TourId]) REFERENCES [Tour]([Id])
);

CREATE TABLE [dbo].[Review]
(
	[Id] INT NOT NULL PRIMARY KEY, 
	[Image] NVARCHAR(MAX) NULL, 
	[Content] NVARCHAR(MAX) NULL, 
	[Rating] INT NULL, 
	[TourId] INT NULL, 
	CONSTRAINT [FK_Review_ToTour] FOREIGN KEY ([TourId]) REFERENCES [Tour]([Id])
)

CREATE TABLE [dbo].[LocationTour]
(
	[LocationId] INT NOT NULL,
	[TourId] INT NOT NULL,
	CONSTRAINT [FK_LocationTour_ToLocation] FOREIGN KEY ([LocationId]) REFERENCES [Location]([Id]), 
	CONSTRAINT [FK_LocationTour_ToTour] FOREIGN KEY ([TourId]) REFERENCES [Tour]([Id]), 
	CONSTRAINT [PK_LocationTour] PRIMARY KEY ([LocationId], [TourId])
)

-- Nazrie
CREATE TABLE [dbo].[Invoice] (
    [BookingId]  INT           NOT NULL,
    [Type]       NVARCHAR (20) NULL,
    [CreateDate] DATETIME      NULL,
    [Status]     BIT           NULL,
    PRIMARY KEY CLUSTERED ([BookingId] ASC),
    CONSTRAINT [FK_Invoice_ToBooking] FOREIGN KEY ([BookingId]) REFERENCES [dbo].[Booking] ([Id])
);

CREATE TABLE [dbo].[Reminder]
(
	[Id] INT NOT NULL PRIMARY KEY, 
	[Desc] NVARCHAR(MAX) NULL,

	[UserId] INT NULL,
	CONSTRAINT [FK_Reminder_ToUser] FOREIGN KEY ([UserId]) REFERENCES [User]([Id])
)

--Generating Data
-- Admin account: admin@gmail.com
-- Test account: test@gmail.com
-- Both Password: testTEST1!
SET IDENTITY_INSERT [dbo].[User] ON
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (1, N'', N'', N'Admin', N'qilrEmQrqmyXOLlSqKMERajphuorYUxpuWW4YuAkP/Kd0gSCwIuM/cmj30I6SyXD14L+nn1SU51sTfz2ZEoqFQ==', N'oXmwjiNyXfU=', N'admin@gmail.com', N'988765432', 1, N'', N'zUjkwPieiqUCg2F6ICNM+w==', N'nPK0LRxRm+JzXFBE8pvQLfqIfkgo9gnAZrJL3839HK4=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (2, N'', N'', N'Event', N'V/4DAGJ57Tk3jhcZYkb1GOd+EwnMQxJ/4b4MdjD6c1eMK/4xcjaoLFC8d00CPH/+aNZFDbl8UqHiNKO2Uia4dA==', N'6Fv0iuW8u8k=', N'event@gmail.com', N'98765432', 2, N'', N'lhhVjmA+iMBM2vrORUPA1A==', N'Oj1xYPWER7GTGbzUrCQUMXECTBqPaTyXyY0OafiMp8w=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (3, N'', N'', N'Test', N'V/4DAGJ57Tk3jhcZYkb1GOd+EwnMQxJ/4b4MdjD6c1eMK/4xcjaoLFC8d00CPH/+aNZFDbl8UqHiNKO2Uia4dA==', N'6Fv0iuW8u8k=', N'test@gmail.com', N'98765432', 3, N'', N'lhhVjmA+iMBM2vrORUPA1A==', N'Oj1xYPWER7GTGbzUrCQUMXECTBqPaTyXyY0OafiMp8w=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (4, N'', N'', N'Tour', N'V/4DAGJ57Tk3jhcZYkb1GOd+EwnMQxJ/4b4MdjD6c1eMK/4xcjaoLFC8d00CPH/+aNZFDbl8UqHiNKO2Uia4dA==', N'6Fv0iuW8u8k=', N'tour@gmail.com', N'98765432', 4, N'', N'lhhVjmA+iMBM2vrORUPA1A==', N'Oj1xYPWER7GTGbzUrCQUMXECTBqPaTyXyY0OafiMp8w=')
SET IDENTITY_INSERT [dbo].[User] OFF

SET IDENTITY_INSERT [dbo].[Location] ON
INSERT INTO [dbo].[Location] ([Id], [Name], [Address], [Details], [Type], [Images], [Status], [UserId]) VALUES (1, N'Pizza Hut Restaurant - Thomson Plaza', N'301 Upper Thomson Road, 26 Thomson Plaza, #02-24, 574408', N'<p><span style="color: rgb(137, 137, 137);">Pizza Hut </span><strong style="color: rgb(137, 137, 137);">operates in 84 countries</strong><span style="color: rgb(137, 137, 137);"> and territories throughout the world under the name </span><strong style="color: rgb(137, 137, 137);">“Pizza Hut”</strong><span style="color: rgb(137, 137, 137);"> and features a variety of pizzas with different toppings as well as pasta, salads, sandwiches and other food items and beverages. The distinctive décor features a bright red roof.</span></p>', N'Food', N'd4f34788-43a1-4f4a-b96c-ad4be22e3cf0image.png', 1, 1)
INSERT INTO [dbo].[Location] ([Id], [Name], [Address], [Details], [Type], [Images], [Status], [UserId]) VALUES (2, N'Causeway Point', N'642 Ang Mo Kio Ave 5', N'<p>Fun place to be! With lots of attractions and food stores!</p><p>Here are the listed few:</p><ul><li>Rollercoasters</li><li><strong>Bouncy Castles!!</strong></li><li>Merry Go Round</li><li>and many more..</li></ul>', N'Entertainment', N'5b0ea2e5-059f-4f10-920a-dcb8b590e1aaimage.jpg', 1, 3)
SET IDENTITY_INSERT [dbo].[Location] OFF

SET IDENTITY_INSERT [dbo].[Ticket] ON
INSERT INTO [dbo].[Ticket] ([Id], [Name], [Price], [SoldAmount], [LocationId]) VALUES (1, N'Adult', 10, 0, 2)
INSERT INTO [dbo].[Ticket] ([Id], [Name], [Price], [SoldAmount], [LocationId]) VALUES (2, N'Child', 6, 0, 2)
INSERT INTO [dbo].[Ticket] ([Id], [Name], [Price], [SoldAmount], [LocationId]) VALUES (3, N'Elderly', 6, 0, 2)
SET IDENTITY_INSERT [dbo].[Ticket] OFF
