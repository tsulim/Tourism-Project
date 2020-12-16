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
