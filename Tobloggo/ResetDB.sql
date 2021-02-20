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
	[StartDate] DATETIME          NULL,
	[EndDate]   DATETIME          NULL,
	[CreateDate] DATETIME NULL,
	[AmtPpl]    INT            NULL,
	[Status]    NVARCHAR (30) NULL,
	[UserId] INT NULL,
	[TourId] INT NULL, 
	PRIMARY KEY CLUSTERED ([Id] ASC), 
	CONSTRAINT [FK_Booking_ToUser] FOREIGN KEY ([UserId]) REFERENCES [User]([Id]),
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

-- Finance Executive:
-- Email: tobloggo_fe@gmail.com
-- Password: P@55w0rd

SET IDENTITY_INSERT [dbo].[User] ON
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (1, N'', N'', N'Admin', N'qilrEmQrqmyXOLlSqKMERajphuorYUxpuWW4YuAkP/Kd0gSCwIuM/cmj30I6SyXD14L+nn1SU51sTfz2ZEoqFQ==', N'oXmwjiNyXfU=', N'admin@gmail.com', N'988765432', 1, N'', N'zUjkwPieiqUCg2F6ICNM+w==', N'nPK0LRxRm+JzXFBE8pvQLfqIfkgo9gnAZrJL3839HK4=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (2, N'', N'', N'Event', N'V/4DAGJ57Tk3jhcZYkb1GOd+EwnMQxJ/4b4MdjD6c1eMK/4xcjaoLFC8d00CPH/+aNZFDbl8UqHiNKO2Uia4dA==', N'6Fv0iuW8u8k=', N'event@gmail.com', N'98765432', 2, N'', N'lhhVjmA+iMBM2vrORUPA1A==', N'Oj1xYPWER7GTGbzUrCQUMXECTBqPaTyXyY0OafiMp8w=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (3, N'', N'', N'Test', N'V/4DAGJ57Tk3jhcZYkb1GOd+EwnMQxJ/4b4MdjD6c1eMK/4xcjaoLFC8d00CPH/+aNZFDbl8UqHiNKO2Uia4dA==', N'6Fv0iuW8u8k=', N'test@gmail.com', N'98765432', 3, N'', N'lhhVjmA+iMBM2vrORUPA1A==', N'Oj1xYPWER7GTGbzUrCQUMXECTBqPaTyXyY0OafiMp8w=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (4, N'', N'', N'Tour', N'V/4DAGJ57Tk3jhcZYkb1GOd+EwnMQxJ/4b4MdjD6c1eMK/4xcjaoLFC8d00CPH/+aNZFDbl8UqHiNKO2Uia4dA==', N'6Fv0iuW8u8k=', N'tour@gmail.com', N'98765432', 4, N'', N'lhhVjmA+iMBM2vrORUPA1A==', N'Oj1xYPWER7GTGbzUrCQUMXECTBqPaTyXyY0OafiMp8w=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (5, N'', N'', N'Finance Executive', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'tobloggo_fe@gmail.com', N'12345678', 5, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (6, NULL, NULL, N'John Appleseed', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot1@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (7, NULL, NULL, N'Nadia Yusof', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot2@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (8, NULL, NULL, N'Troy Nguyen', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot3@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (9, NULL, NULL, N'Amir Hamed', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot4@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (10, NULL, NULL, N'Hoa Xio Han', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot5@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (11, NULL, NULL, N'Sanie Tyzer', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot6@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (12, NULL, NULL, N'Allison Rae', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'192529t@mymail.nyp.edu.sg', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (13, NULL, NULL, N'Zak Combell', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot8@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (14, NULL, NULL, N'Devi Kumar', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot9@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (15, NULL, NULL, N'James Ma', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot10@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (16, NULL, NULL, N'Putri Aidan', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot11@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (17, NULL, NULL, N'Jefri Lim', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot12@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (18, NULL, NULL, N'Naveka Ghandi', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot13@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (19, NULL, NULL, N'Joseph Kor', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot14@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (20, NULL, NULL, N'Pooja Anupriya', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot15@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (21, NULL, NULL, N'Ashton Kutcher', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot16@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (22, NULL, NULL, N'Bonnie Clyde', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot17@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (23, NULL, NULL, N'Amirul Syak', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot18@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (24, NULL, NULL, N'Aya Asahina', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot19@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (25, NULL, NULL, N'Cyntia Delmarie', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot20@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (26, NULL, NULL, N'Krit Kanapoom', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot21@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (27, NULL, NULL, N'Noah Galvin', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot22@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (28, NULL, NULL, N'Aiko Shibuki', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot23@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (29, NULL, NULL, N'Luke Warm', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot24@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (30, NULL, NULL, N'Anita Hanjaab', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot25@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (31, NULL, NULL, N'Draco Malfoy', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot26@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (32, NULL, NULL, N'Armando Serrano', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot27@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (33, NULL, NULL, N'Nathan Gurdoski', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot28@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (34, NULL, NULL, N'Keita Machida', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot29@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (35, NULL, NULL, N'Dixie Normous', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot30@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (36, NULL, NULL, N'Willow Carabajal', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot31@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (37, NULL, NULL, N'Gustav Melano', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot32@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (38, NULL, NULL, N'Dong Wobin', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot33@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (39, NULL, NULL, N'Qyung Woon', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot34@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (40, NULL, NULL, N'Indya Moore', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot35@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (41, NULL, NULL, N'Tul Pakorn', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot36@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (42, NULL, NULL, N'Caleb Wong', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot37@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (43, NULL, NULL, N'Yu Hang', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot38@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (44, NULL, NULL, N'Feliz Navidad', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot39@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (45, NULL, NULL, N'Nina Storm', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot40@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (46, NULL, NULL, N'Carlota Brunette', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot41@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (47, NULL, NULL, N'Antoni Proski', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot42@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (48, NULL, NULL, N'Matthew Dimsum', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot43@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (49, NULL, NULL, N'Gunther Seamen', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot44@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (50, NULL, NULL, N'Onika Maraj', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot45@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (51, NULL, NULL, N'Nuska Almanzi', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot46@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (52, NULL, NULL, N'Hendrik Giesler', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot47@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (53, NULL, NULL, N'Mara Lafontan', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot48@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (54, NULL, NULL, N'Lon Tong', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot49@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (55, NULL, NULL, N'Sonia Chew', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot50@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (56, NULL, NULL, N'Na Gini', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot51@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (57, NULL, NULL, N'Oscar Faurger', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot52@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (58, NULL, NULL, N'Isaac Ang', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot53@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (59, NULL, NULL, N'Shin Yeun', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot54@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (60, NULL, NULL, N'Ohm Natawin', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot55@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (61, NULL, NULL, N'Lukas Andes', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot56@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (62, NULL, NULL, N'Pwi Ansaer', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot57@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (63, NULL, NULL, N'T Bone', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot58@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (64, NULL, NULL, N'Sabrina West', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot59@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (65, NULL, NULL, N'Reynold Ryan', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot60@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
INSERT INTO [dbo].[User] ([Id], [GoogleId], [ProfImage], [Name], [PasswordHash], [PasswordSalt], [Email], [Contact], [Authorization], [StripeId], [IV], [Key]) VALUES (66, NULL, NULL, N'Melisa Tan', N'b9jWF4UnWvDz8GJbMjVNer0dLpzJM5UdxnNWVKaKWj6N5XyEZ+jrSqyS2GBVK+CEagS9ZrLdjM7e4fQoacC0Fg==', N'pqJarJmVqPs=', N'bot61@gmail.com', N'12345678', 0, N'', N'9BvkcPaBSdj+dqotMjbv1Q==', N'S2aCch4bQntCUtYyvLHVGYPiF+ZQFQsdT7tH6y/Y0VU=')
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

SET IDENTITY_INSERT [dbo].[Tour] ON
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (1, N'River Safari', N'riversafari.jfif', N' River Safari', N'02/22/21 08:00 PM - 02/22/21 10:00 PM', 30, 5, 6, 10, N'(8PM - 10PM) Explore')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (2, N'Singapore Zoo ', N'Zoo.jpg', N'Zoo', N'02/23/21 02:00 PM - 02/23/21 05:00 PM', 35, 5, 6, 10, N'(2PM - 5PM) Walk around ')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (3, N'Museum', N'museum.jfif', N'Art Museum', N'02/20/21 01:00 PM - 02/20/21 05:00 PM', 40, 5, 6, 10, N'(1PM - 5PM) View collections')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (4, N'My Backyard Garden', NULL, NULL, NULL, 15, 1, 3, 0, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (5, N'Hello Life!', NULL, NULL, NULL, 39, 1, 4, 0, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (6, N'Funky Jazz', NULL, NULL, NULL, 22, 1, 2, 14, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (7, N'Golden Hour', NULL, NULL, NULL, 10, 1, 3, 3, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (8, N'Art in the Streets', NULL, NULL, NULL, 28, 1, 4, 5, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (9, N'World of Coffee', NULL, NULL, NULL, 20, 1, 3, 0, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (10, N'Wok & Stroll', NULL, NULL, NULL, 28, 1, 6, 4, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (11, N'Fun, Splash ''N'' Wet', NULL, NULL, NULL, 20, 1, 6, 5, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (12, N'Christmas Wonderland', NULL, NULL, NULL, 15, 1, 6, 0, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (13, N'A Fishy Adventure', NULL, NULL, NULL, 12, 1, 5, 15, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (14, N'The Haunted Trail', NULL, NULL, NULL, 40, 1, 6, 0, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (15, N'Bizzare Wildlife', NULL, NULL, NULL, 26, 1, 4, 19, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (16, N'Under the Rock', NULL, NULL, NULL, 14, 1, 4, 11, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (17, N'A Tale of Thousand Stars', NULL, NULL, NULL, 18, 1, 1, 10, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (18, N'Story before Bedtime', NULL, NULL, NULL, 16, 1, 5, 8, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (19, N'Craft from Recycables', NULL, NULL, NULL, 10, 1, 6, 11, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (20, N'History of Singapore', NULL, NULL, NULL, 35, 1, 3, 19, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (21, N'Where''s the Tea?', NULL, NULL, NULL, 20, 1, 4, 16, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (22, N'In Another Life', NULL, NULL, NULL, 40, 1, 4, 10, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (23, N'The Artist in Me', NULL, NULL, NULL, 15, 1, 3, 10, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (24, N'Say Cheese!', NULL, NULL, NULL, 10, 1, 4, 1, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (25, N'Walk like a Diva', NULL, NULL, NULL, 22, 1, 2, 20, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (26, N'My Grandfather Road', NULL, NULL, NULL, 13, 1, 3, 11, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (27, N'Alice in Singapore', NULL, NULL, NULL, 50, 1, 5, 2, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (28, N'Chemtrails over the Country Club', NULL, NULL, NULL, 11, 1, 2, 15, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (29, N'Beast From the East', NULL, NULL, NULL, 25, 1, 5, 8, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (30, N'Can You Keep Up?', NULL, NULL, NULL, 28, 1, 4, 6, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (31, N'Long and Thick', NULL, NULL, NULL, 32, 1, 2, 7, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (32, N'But Make it Fashion', NULL, NULL, NULL, 34, 1, 5, 20, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (33, N'All About Science', NULL, NULL, NULL, 23, 1, 4, 17, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (34, N'CNY Special', NULL, NULL, NULL, 35, 1, 6, 0, N'(12PM - 6PM)')
INSERT INTO [dbo].[Tour] ([Id], [Title], [Image], [Details], [DateTime], [Price], [MinPpl], [MaxPpl], [AvailSlots], [Iti]) VALUES (35, N'Frog Farm', NULL, NULL, NULL, 15, 1, 3, 13, N'(12PM - 6PM)')
SET IDENTITY_INSERT [dbo].[Tour] OFF

SET IDENTITY_INSERT [dbo].[Booking] ON
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (1, N'2020-01-01', N'2021-12-01', N'2020-10-09 00:00:00', 2, N'1', 6, 21)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (2, N'2020-01-01', N'2021-12-01', N'2020-10-12 00:00:00', 4, N'1', 8, 21)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (3, N'2020-01-01', N'2021-12-01', N'2020-10-13 00:00:00', 3, N'1', 10, 24)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (4, N'2020-01-01', N'2021-12-01', N'2020-10-13 00:00:00', 2, N'0', 12, 24)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (5, N'2020-01-01', N'2021-12-01', N'2020-10-15 00:00:00', 3, N'0', 14, 21)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (6, N'2020-01-01', N'2021-12-01', N'2020-10-15 00:00:00', 4, N'1', 16, 24)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (7, N'2020-01-01', N'2021-12-01', N'2020-10-16 00:00:00', 3, N'1', 18, 14)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (8, N'2020-01-01', N'2021-12-01', N'2020-10-16 00:00:00', 2, N'0', 20, 24)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (9, N'2020-01-01', N'2021-12-01', N'2020-10-16 00:00:00', 3, N'1', 22, 24)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (10, N'2020-01-01', N'2021-12-01', N'2020-10-16 00:00:00', 4, N'1', 24, 29)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (11, N'2020-01-01', N'2021-12-01', N'2020-10-17 00:00:00', 6, N'1', 26, 14)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (12, N'2020-01-01', N'2021-12-01', N'2020-10-17 00:00:00', 5, N'1', 28, 14)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (13, N'2020-01-01', N'2021-12-01', N'2020-10-17 00:00:00', 6, N'1', 30, 14)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (14, N'2020-01-01', N'2021-12-01', N'2020-10-18 00:00:00', 3, N'1', 32, 21)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (15, N'2020-01-01', N'2021-12-01', N'2020-10-18 00:00:00', 2, N'1', 34, 21)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (16, N'2020-01-01', N'2021-12-01', N'2020-10-21 00:00:00', 4, N'1', 36, 29)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (17, N'2020-01-01', N'2021-12-01', N'2020-10-21 00:00:00', 2, N'1', 38, 29)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (18, N'2020-01-01', N'2021-12-01', N'2020-10-27 00:00:00', 5, N'1', 40, 29)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (19, N'2020-01-01', N'2021-12-01', N'2020-11-03 00:00:00', 3, N'1', 7, 23)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (20, N'2020-01-01', N'2021-12-01', N'2020-11-04 00:00:00', 3, N'1', 9, 26)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (21, N'2020-01-01', N'2021-12-01', N'2020-11-04 00:00:00', 2, N'1', 11, 26)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (22, N'2020-01-01', N'2021-12-01', N'2020-11-05 00:00:00', 2, N'1', 13, 4)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (23, N'2020-01-01', N'2021-12-01', N'2020-11-07 00:00:00', 2, N'1', 15, 7)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (24, N'2020-01-01', N'2021-12-01', N'2020-11-07 00:00:00', 1, N'1', 17, 7)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (25, N'2020-01-01', N'2021-12-01', N'2020-11-08 00:00:00', 1, N'1', 19, 7)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (26, N'2020-01-01', N'2021-12-01', N'2020-11-10 00:00:00', 1, N'1', 23, 7)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (27, N'2020-01-01', N'2021-12-01', N'2020-11-15 00:00:00', 1, N'1', 25, 4)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (28, N'2020-01-01', N'2021-12-01', N'2020-11-15 00:00:00', 2, N'1', 27, 4)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (29, N'2020-01-01', N'2021-12-01', N'2020-11-22 00:00:00', 2, N'1', 29, 23)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (30, N'2020-01-01', N'2021-12-01', N'2020-11-22 00:00:00', 3, N'1', 31, 9)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (31, N'2020-01-01', N'2021-12-01', N'2020-11-24 00:00:00', 3, N'1', 33, 9)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (32, N'2020-01-01', N'2021-12-01', N'2020-11-26 00:00:00', 2, N'1', 35, 5)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (33, N'2020-01-01', N'2021-12-01', N'2020-11-26 00:00:00', 4, N'1', 37, 5)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (34, N'2020-01-01', N'2021-12-01', N'2020-11-27 00:00:00', 3, N'1', 39, 9)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (35, N'2020-01-01', N'2021-12-01', N'2020-11-28 00:00:00', 3, N'1', 41, 9)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (36, N'2020-01-01', N'2021-12-01', N'2020-11-28 00:00:00', 2, N'1', 43, 9)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (37, N'2020-01-01', N'2021-12-01', N'2020-11-30 00:00:00', 3, N'1', 45, 5)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (38, N'2020-01-01', N'2021-12-01', N'2020-11-30 00:00:00', 4, N'1', 47, 5)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (39, N'2020-01-01', N'2021-12-01', N'2020-11-30 00:00:00', 3, N'1', 49, 5)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (40, N'2020-01-01', N'2021-12-01', N'2020-12-01 00:00:00', 4, N'1', 20, 13)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (41, N'2020-01-01', N'2021-12-01', N'2020-12-02 00:00:00', 3, N'1', 21, 30)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (42, N'2020-01-01', N'2021-12-01', N'2020-12-02 00:00:00', 2, N'1', 22, 13)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (43, N'2020-01-01', N'2021-12-01', N'2020-12-03 00:00:00', 3, N'1', 23, 30)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (44, N'2020-01-01', N'2021-12-01', N'2020-12-03 00:00:00', 3, N'1', 24, 13)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (45, N'2020-01-01', N'2021-12-01', N'2020-12-05 00:00:00', 2, N'1', 25, 6)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (46, N'2020-01-01', N'2021-12-01', N'2020-12-05 00:00:00', 3, N'1', 26, 31)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (47, N'2020-01-01', N'2021-12-01', N'2020-12-06 00:00:00', 2, N'1', 27, 6)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (48, N'2020-01-01', N'2021-12-01', N'2020-12-09 00:00:00', 4, N'1', 28, 31)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (49, N'2020-01-01', N'2021-12-01', N'2020-12-09 00:00:00', 4, N'1', 29, 13)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (50, N'2020-01-01', N'2021-12-01', N'2020-12-11 00:00:00', 3, N'1', 30, 31)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (51, N'2020-01-01', N'2021-12-01', N'2020-12-11 00:00:00', 6, N'1', 31, 31)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (52, N'2020-01-01', N'2021-12-01', N'2020-12-12 00:00:00', 3, N'1', 32, 22)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (53, N'2020-01-01', N'2021-12-01', N'2020-12-12 00:00:00', 4, N'1', 33, 22)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (54, N'2020-01-01', N'2021-12-01', N'2020-12-12 00:00:00', 2, N'1', 34, 22)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (55, N'2020-01-01', N'2021-12-01', N'2020-12-13 00:00:00', 3, N'1', 35, 30)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (56, N'2020-01-01', N'2021-12-01', N'2020-12-13 00:00:00', 2, N'1', 36, 13)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (57, N'2020-01-01', N'2021-12-01', N'2020-12-15 00:00:00', 3, N'1', 37, 13)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (58, N'2020-01-01', N'2021-12-01', N'2020-12-15 00:00:00', 5, N'1', 38, 13)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (59, N'2020-01-01', N'2021-12-01', N'2020-12-17 00:00:00', 2, N'1', 39, 6)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (60, N'2020-01-01', N'2021-12-01', N'2020-12-17 00:00:00', 4, N'1', 40, 30)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (61, N'2020-01-01', N'2021-12-01', N'2020-12-18 00:00:00', 6, N'1', 41, 12)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (62, N'2020-01-01', N'2021-12-01', N'2020-12-18 00:00:00', 5, N'1', 42, 12)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (63, N'2020-01-01', N'2021-12-01', N'2020-12-18 00:00:00', 3, N'1', 43, 12)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (64, N'2020-01-01', N'2021-12-01', N'2020-12-19 00:00:00', 5, N'1', 44, 12)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (65, N'2020-01-01', N'2021-12-01', N'2020-12-19 00:00:00', 5, N'1', 45, 12)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (66, N'2020-01-01', N'2021-12-01', N'2020-12-19 00:00:00', 6, N'1', 46, 30)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (67, N'2020-01-01', N'2021-12-01', N'2020-12-19 00:00:00', 4, N'1', 47, 27)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (68, N'2020-01-01', N'2021-12-01', N'2020-12-20 00:00:00', 5, N'1', 48, 27)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (69, N'2020-01-01', N'2021-12-01', N'2020-12-20 00:00:00', 5, N'1', 49, 27)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (70, N'2020-01-01', N'2021-12-01', N'2020-12-20 00:00:00', 4, N'1', 50, 22)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (71, N'2020-01-01', N'2021-12-01', N'2020-12-20 00:00:00', 3, N'1', 51, 22)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (72, N'2020-01-01', N'2021-12-01', N'2020-12-20 00:00:00', 5, N'1', 52, 12)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (73, N'2020-01-01', N'2021-12-01', N'2020-12-21 00:00:00', 4, N'1', 53, 12)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (74, N'2020-01-01', N'2021-12-01', N'2020-12-21 00:00:00', 3, N'1', 54, 22)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (75, N'2020-01-01', N'2021-12-01', N'2020-12-21 00:00:00', 3, N'1', 55, 22)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (76, N'2020-01-01', N'2021-12-01', N'2020-12-21 00:00:00', 3, N'1', 56, 12)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (77, N'2020-01-01', N'2021-12-01', N'2020-12-21 00:00:00', 2, N'1', 57, 27)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (78, N'2020-01-01', N'2021-12-01', N'2020-12-21 00:00:00', 5, N'1', 58, 12)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (79, N'2020-01-01', N'2021-12-01', N'2020-12-21 00:00:00', 5, N'1', 59, 12)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (80, N'2020-01-01', N'2021-12-01', N'2020-12-23 00:00:00', 5, N'1', 60, 27)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (81, N'2020-01-01', N'2021-12-01', N'2020-12-23 00:00:00', 5, N'1', 61, 27)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (82, N'2020-01-01', N'2021-12-01', N'2020-12-23 00:00:00', 5, N'1', 62, 27)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (83, N'2020-01-01', N'2021-12-01', N'2020-12-24 00:00:00', 2, N'1', 63, 6)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (84, N'2020-01-01', N'2021-12-01', N'2020-12-24 00:00:00', 2, N'1', 64, 6)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (85, N'2020-01-01', N'2021-12-01', N'2020-12-24 00:00:00', 4, N'1', 65, 30)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (86, N'2020-01-01', N'2021-12-01', N'2020-12-25 00:00:00', 4, N'1', 66, 22)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (87, N'2020-01-01', N'2021-12-01', N'2020-12-27 00:00:00', 4, N'1', 19, 22)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (88, N'2020-01-01', N'2021-12-01', N'2020-12-28 00:00:00', 2, N'1', 18, 31)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (89, N'2020-01-01', N'2021-12-01', N'2020-12-28 00:00:00', 2, N'1', 17, 31)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (90, N'2020-01-01', N'2021-12-01', N'2020-12-29 00:00:00', 1, N'1', 16, 31)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (91, N'2020-01-01', N'2021-12-01', N'2020-12-29 00:00:00', 1, N'1', 15, 31)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (92, N'2020-01-01', N'2021-12-01', N'2020-12-29 00:00:00', 2, N'1', 14, 22)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (93, N'2020-01-01', N'2021-12-01', N'2020-12-30 00:00:00', 1, N'1', 13, 22)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (94, N'2020-01-01', N'2021-12-01', N'2020-12-30 00:00:00', 2, N'1', 12, 31)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (95, N'2020-01-01', N'2021-12-01', N'2021-01-01 00:00:00', 3, N'0', 11, 15)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (96, N'2020-01-01', N'2021-12-01', N'2021-01-01 00:00:00', 2, N'0', 10, 15)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (97, N'2020-01-01', N'2021-12-01', N'2021-01-01 00:00:00', 3, N'1', 9, 8)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (98, N'2020-01-01', N'2021-12-01', N'2021-01-01 00:00:00', 4, N'1', 8, 15)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (99, N'2020-01-01', N'2021-12-01', N'2021-01-01 00:00:00', 4, N'1', 7, 15)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (100, N'2020-01-01', N'2021-12-01', N'2021-01-01 00:00:00', 3, N'1', 6, 8)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (101, N'2020-01-01', N'2021-12-01', N'2021-01-02 00:00:00', 3, N'1', 53, 8)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (102, N'2020-01-01', N'2021-12-01', N'2021-01-02 00:00:00', 2, N'1', 52, 8)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (103, N'2020-01-01', N'2021-12-01', N'2021-01-02 00:00:00', 2, N'1', 51, 8)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (104, N'2020-01-01', N'2021-12-01', N'2021-01-02 00:00:00', 4, N'1', 50, 16)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (105, N'2020-01-01', N'2021-12-01', N'2021-01-03 00:00:00', 3, N'1', 49, 18)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (106, N'2020-01-01', N'2021-12-01', N'2021-01-03 00:00:00', 2, N'1', 48, 18)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (107, N'2020-01-01', N'2021-12-01', N'2021-01-03 00:00:00', 2, N'1', 47, 18)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (108, N'2020-01-01', N'2021-12-01', N'2021-01-03 00:00:00', 3, N'1', 46, 8)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (109, N'2020-01-01', N'2021-12-01', N'2021-01-05 00:00:00', 4, N'1', 46, 8)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (110, N'2020-01-01', N'2021-12-01', N'2021-01-05 00:00:00', 4, N'1', 34, 15)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (111, N'2020-01-01', N'2021-12-01', N'2021-01-05 00:00:00', 4, N'1', 33, 15)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (112, N'2020-01-01', N'2021-12-01', N'2021-01-09 00:00:00', 2, N'1', 32, 8)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (113, N'2020-01-01', N'2021-12-01', N'2021-01-09 00:00:00', 2, N'1', 31, 16)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (114, N'2020-01-01', N'2021-12-01', N'2021-01-09 00:00:00', 3, N'1', 30, 18)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (115, N'2020-01-01', N'2021-12-01', N'2021-01-09 00:00:00', 3, N'1', 29, 18)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (116, N'2020-01-01', N'2021-12-01', N'2021-01-12 00:00:00', 4, N'1', 28, 15)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (117, N'2020-01-01', N'2021-12-01', N'2021-01-12 00:00:00', 3, N'1', 27, 15)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (118, N'2020-01-01', N'2021-12-01', N'2021-01-14 00:00:00', 4, N'1', 26, 16)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (119, N'2020-01-01', N'2021-12-01', N'2021-01-23 00:00:00', 3, N'1', 25, 11)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (120, N'2020-01-01', N'2021-12-01', N'2021-01-23 00:00:00', 1, N'1', 24, 8)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (121, N'2020-01-01', N'2021-12-01', N'2021-01-26 00:00:00', 4, N'1', 23, 11)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (123, N'2020-01-01', N'2021-12-01', N'2021-01-26 00:00:00', 5, N'1', 22, 11)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (124, N'2020-01-01', N'2021-12-01', N'2021-01-26 00:00:00', 3, N'1', 21, 8)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (125, N'2020-01-01', N'2021-12-01', N'2021-01-27 00:00:00', 3, N'1', 20, 11)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (126, N'2020-01-01', N'2021-12-01', N'2021-01-27 00:00:00', 4, N'1', 19, 11)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (127, N'2020-01-01', N'2021-12-01', N'2021-01-27 00:00:00', 5, N'1', 18, 11)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (128, N'2020-01-01', N'2021-12-01', N'2021-01-27 00:00:00', 4, N'1', 17, 15)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (129, N'2020-01-01', N'2021-12-01', N'2021-01-31 00:00:00', 6, N'1', 16, 11)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (130, N'2020-01-01', N'2021-12-01', N'2021-01-31 00:00:00', 2, N'1', 15, 15)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (131, N'2020-01-01', N'2021-12-01', N'2021-02-01 00:00:00', 2, N'1', 6, 19)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (132, N'2020-01-01', N'2021-12-01', N'2021-02-02 00:00:00', 1, N'1', 7, 20)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (133, N'2020-01-01', N'2021-12-01', N'2021-02-03 00:00:00', 4, N'1', 8, 34)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (134, N'2020-01-01', N'2021-12-01', N'2021-02-06 00:00:00', 5, N'1', 9, 34)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (135, N'2020-01-01', N'2021-12-01', N'2021-02-06 00:00:00', 1, N'1', 10, 34)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (136, N'2020-01-01', N'2021-12-01', N'2021-02-09 00:00:00', 2, N'1', 11, 33)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (137, N'2020-01-01', N'2021-12-01', N'2021-02-09 00:00:00', 6, N'1', 12, 34)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (138, N'2020-01-01', N'2021-12-01', N'2021-02-09 00:00:00', 6, N'1', 13, 34)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (139, N'2020-01-01', N'2021-12-01', N'2021-02-10 00:00:00', 5, N'1', 14, 34)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (140, N'2020-01-01', N'2021-12-01', N'2021-02-10 00:00:00', 5, N'1', 15, 34)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (141, N'2020-01-01', N'2021-12-01', N'2021-02-10 00:00:00', 5, N'1', 16, 34)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (142, N'2020-01-01', N'2021-12-01', N'2021-02-11 00:00:00', 5, N'1', 17, 34)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (143, N'2020-01-01', N'2021-12-01', N'2021-02-11 00:00:00', 4, N'1', 18, 33)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (144, N'2020-01-01', N'2021-12-01', N'2021-02-12 00:00:00', 3, N'1', 19, 33)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (145, N'2020-01-01', N'2021-12-01', N'2021-02-12 00:00:00', 3, N'1', 20, 33)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (146, N'2020-01-01', N'2021-12-01', N'2021-02-15 00:00:00', 2, N'1', 21, 20)
INSERT INTO [dbo].[Booking] ([Id], [StartDate], [EndDate], [CreateDate], [AmtPpl], [Status], [UserId], [TourId]) VALUES (147, N'2020-01-01', N'2021-12-01', N'2021-02-16 00:00:00', 2, N'1', 22, 33)
SET IDENTITY_INSERT [dbo].[Booking] OFF


SET IDENTITY_INSERT [dbo].[Invoice] ON
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (40, N'BC', N'2021-02-20 22:32:15', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (41, N'BC', N'2021-02-20 22:32:20', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (42, N'BC', N'2021-02-20 22:32:36', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (43, N'BC', N'2021-02-20 22:32:39', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (44, N'BC', N'2021-02-20 22:32:41', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (45, N'BC', N'2021-02-20 22:32:43', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (46, N'BC', N'2021-02-20 22:32:46', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (47, N'BC', N'2021-02-20 22:32:49', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (48, N'BC', N'2021-02-20 22:32:51', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (49, N'BC', N'2021-02-20 22:32:54', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (50, N'BC', N'2021-02-20 22:32:57', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (51, N'BC', N'2021-02-20 22:32:59', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (52, N'BC', N'2021-02-20 22:33:01', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (53, N'BC', N'2021-02-20 22:33:04', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (54, N'BC', N'2021-02-20 22:33:06', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (55, N'BC', N'2021-02-20 22:33:09', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (56, N'BC', N'2021-02-20 22:33:12', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (57, N'BC', N'2021-02-20 22:33:15', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (58, N'BC', N'2021-02-20 22:33:17', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (59, N'BC', N'2021-02-20 22:33:20', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (60, N'BC', N'2021-02-20 22:33:22', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (61, N'BC', N'2021-02-20 22:33:30', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (62, N'BC', N'2021-02-20 22:33:32', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (63, N'BC', N'2021-02-20 22:33:34', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (64, N'BC', N'2021-02-20 22:33:36', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (65, N'BC', N'2021-02-20 22:33:38', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (66, N'BC', N'2021-02-20 22:33:41', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (67, N'BC', N'2021-02-20 22:33:43', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (68, N'BC', N'2021-02-20 22:33:45', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (69, N'BC', N'2021-02-20 22:33:47', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (70, N'BC', N'2021-02-20 22:33:49', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (71, N'BC', N'2021-02-20 22:33:52', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (72, N'BC', N'2021-02-20 22:33:54', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (73, N'BC', N'2021-02-20 22:33:56', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (74, N'BC', N'2021-02-20 22:33:58', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (75, N'BC', N'2021-02-20 22:34:01', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (76, N'BC', N'2021-02-20 22:34:03', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (77, N'BC', N'2021-02-20 22:34:05', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (78, N'BC', N'2021-02-20 22:34:08', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (79, N'BC', N'2021-02-20 22:34:10', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (80, N'BC', N'2021-02-20 22:34:12', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (81, N'BC', N'2021-02-20 22:34:14', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (82, N'BC', N'2021-02-20 22:34:16', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (83, N'BC', N'2021-02-20 22:34:19', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (84, N'BC', N'2021-02-20 22:34:21', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (85, N'BC', N'2021-02-20 22:34:23', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (86, N'BC', N'2021-02-20 22:34:25', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (87, N'BC', N'2021-02-20 22:34:27', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (88, N'BC', N'2021-02-20 22:34:30', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (89, N'BC', N'2021-02-20 22:34:32', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (90, N'BC', N'2021-02-20 22:34:34', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (91, N'BC', N'2021-02-20 22:34:36', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (92, N'BC', N'2021-02-20 22:34:38', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (93, N'BC', N'2021-02-20 22:34:40', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (94, N'RA', N'2021-02-20 22:47:52', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (95, N'BC', N'2021-02-20 22:34:44', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (96, N'BC', N'2021-02-20 22:34:46', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (97, N'BC', N'2021-02-20 22:34:48', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (98, N'BC', N'2021-02-20 22:39:21', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (99, N'BC', N'2021-02-20 22:34:53', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (100, N'RA', N'2021-02-20 22:34:56', 0)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (101, N'BC', N'2021-02-20 22:45:55', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (102, N'BC', N'2021-02-20 22:45:57', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (103, N'BC', N'2021-02-20 22:45:59', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (104, N'BC', N'2021-02-20 22:46:01', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (105, N'BC', N'2021-02-20 22:46:02', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (106, N'BC', N'2021-02-20 22:46:04', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (107, N'BC', N'2021-02-20 22:46:06', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (108, N'BC', N'2021-02-20 22:46:08', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (109, N'BC', N'2021-02-20 22:46:10', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (110, N'BC', N'2021-02-20 22:46:12', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (111, N'BC', N'2021-02-20 22:46:14', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (112, N'BC', N'2021-02-20 22:46:15', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (113, N'BC', N'2021-02-20 22:46:17', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (114, N'BC', N'2021-02-20 22:46:20', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (115, N'BC', N'2021-02-20 22:46:21', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (116, N'BC', N'2021-02-20 22:46:23', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (117, N'BC', N'2021-02-20 22:46:25', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (118, N'BC', N'2021-02-20 22:46:27', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (119, N'BC', N'2021-02-20 22:46:29', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (120, N'BC', N'2021-02-20 22:46:31', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (121, N'BC', N'2021-02-20 22:46:33', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (123, N'BC', N'2021-02-20 22:46:35', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (124, N'BC', N'2021-02-20 22:46:38', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (125, N'BC', N'2021-02-20 22:46:40', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (126, N'BC', N'2021-02-20 22:46:42', 1)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (127, N'BC', N'2021-02-20 22:47:40', 0)
INSERT INTO [dbo].[Invoice] ([BookingId], [Type], [CreateDate], [Status]) VALUES (128, N'BC', N'2021-02-20 22:47:42', 0)
SET IDENTITY_INSERT [dbo].[Invoice] OFF