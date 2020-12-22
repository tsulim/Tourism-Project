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

--Table Creation Codes (START)

CREATE TABLE [dbo].[User]
(
    [Id] INT NOT NULL PRIMARY KEY, 
    [ProfImage] NVARCHAR(MAX) NULL, 
    [Name] NVARCHAR(MAX) NULL, 
    [PasswordHash] NVARCHAR(MAX) NULL,
    [PasswordSalt] NVARCHAR(MAX) NULL,
    [Email] NVARCHAR(50) NULL, 
    [Contact] NVARCHAR(20) NULL, 
    [Authorization] INT NULL,
    [StripeId] NVARCHAR(MAX) NULL
)

--Xiu Jia
    

CREATE TABLE [dbo].[Location]
(
    [Id] INT NOT NULL PRIMARY KEY, 
    [Name] NVARCHAR(MAX) NULL, 
    [Address] NVARCHAR(MAX) NULL, 
    [Type] NVARCHAR(20) NULL, 
    [Images] NVARCHAR(MAX) NULL, 
    [Status] BIT NULL,
    [UserId] INT NULL, 
    CONSTRAINT [FK_Location_ToUser] FOREIGN KEY ([UserId]) REFERENCES [User]([Id])
)

CREATE TABLE [dbo].[Statistic]
(
    [Id] INT NOT NULL PRIMARY KEY,
    [SDate] DATE NULL,
    [Revenue] FLOAT NULL,
    [LocationId] INT NULL,
    CONSTRAINT [FK_Statistic_ToLocation] FOREIGN KEY ([LocationId]) REFERENCES [Location]([Id])
)

CREATE TABLE [dbo].[Promotion]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Title] NVARCHAR(50) NULL, 
    [StartDate] DATETIME NULL, 
    [EndDate] DATETIME NULL, 
    [LocationArr] NVARCHAR(MAX) NULL,
	[UserId] INT NULL,
    CONSTRAINT [FK_Promotion_ToUser] FOREIGN KEY ([UserId]) REFERENCES [User]([Id])
)

CREATE TABLE [dbo].[Ticket]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Type] NVARCHAR(MAX) NULL, 
    [Price] FLOAT NULL, 
    [TotalAmount] INT NULL, 
    [SoldAmount] INT NULL, 
    [LocationId] INT NULL, 
    CONSTRAINT [FK_Ticket_ToLocation] FOREIGN KEY ([LocationId]) REFERENCES [Location]([Id])
)

CREATE TABLE [dbo].[PurchasedTicket]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Type] NVARCHAR(MAX) NULL, 
    [Price] FLOAT NULL, 
    [TotalAmount] INT NULL, 
    [SoldAmount] INT NULL, 
	[UserId] INT NULL,
    CONSTRAINT [FK_PurchasedTicket_ToUser] FOREIGN KEY ([UserId]) REFERENCES [User]([Id])
)
