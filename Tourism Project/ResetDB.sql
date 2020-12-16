CREATE TABLE [dbo].[User]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [profImage] VARCHAR(MAX) NULL, 
    [name] VARCHAR(MAX) NULL, 
    [password] VARCHAR(MAX) NULL, 
    [email] VARCHAR(50) NULL, 
    [contact] VARCHAR(20) NULL, 
    [authorization] INT NULL, 
    [stripeId] VARCHAR(MAX) NULL
)

CREATE TABLE [dbo].[Location]
(
	[Id] VARCHAR(50) NOT NULL PRIMARY KEY, 
    [name] NVARCHAR(MAX) NULL, 
    [address] VARCHAR(MAX) NULL, 
    [type] VARCHAR(20) NULL, 
    [images] VARCHAR(MAX) NULL, 
    [userId] VARCHAR(50) NULL, 
    CONSTRAINT [FK_Location_ToUser] FOREIGN KEY ([userId]) REFERENCES [User]([Id])
)
