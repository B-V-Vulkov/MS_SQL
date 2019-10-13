--Section 01
CREATE DATABASE [Bitbucket]
GO

USE [Bitbucket]
GO

CREATE TABLE [Users](
	[Id]			INT IDENTITY,
	[Username]		NVARCHAR(30) NOT NULL,
	[Password]		NVARCHAR(30) NOT NULL,
	[Email]			NVARCHAR(50) NOT NULL,
	CONSTRAINT PK_Users 
	PRIMARY KEY([Id])
)

CREATE TABLE [Repositories](
	[Id]			INT IDENTITY,
	[Name]			NVARCHAR(50) NOT NULL,
	CONSTRAINT PK_Repositories 
	PRIMARY KEY([Id])
)

CREATE TABLE [RepositoriesContributors](
	[RepositoryId]	INT,
	[ContributorId]	INT,
	CONSTRAINT PK_RepositoriesContributors 
	PRIMARY KEY([RepositoryId], [ContributorId])
)

CREATE TABLE [Issues](
	[Id]			INT IDENTITY,
	[Title]			NVARCHAR(255) NOT NULL,
	[IssueStatus]	NCHAR(6) NOT NULL,
	[RepositoryId]	INT NOT NULL,
	[AssigneeId]	INT NOT NULL
	CONSTRAINT PK_Issues
	PRIMARY KEY([Id])
)

CREATE TABLE [Commits](
	[Id]			INT IDENTITY,
	[Message]		NVARCHAR(255) NOT NULL,
	[IssueId]		INT,
	[RepositoryId]	INT NOT NULL,
	[ContributorId]	INT NOT NULL
	CONSTRAINT PK_Commits
	PRIMARY KEY([Id])
)

CREATE TABLE [Files](
	[Id]			INT IDENTITY,
	[Name]			NVARCHAR(255) NOT NULL,
	[Size]			DECIMAL(18, 2) NOT NULL,
	[ParentId]		INT,
	[CommitId]		INT NOT NULL
	CONSTRAINT PK_Files
	PRIMARY KEY([Id])
)

ALTER TABLE [RepositoriesContributors]
ADD CONSTRAINT FK_RepositoriesContributors_Repositories
FOREIGN KEY([RepositoryId]) REFERENCES [Repositories]([Id])

ALTER TABLE [RepositoriesContributors]
ADD CONSTRAINT FK_RepositoriesContributors_Users
FOREIGN KEY([ContributorId]) REFERENCES [Users]([Id])

ALTER TABLE [Issues]
ADD CONSTRAINT FK_Issues_Repositories
FOREIGN KEY([RepositoryId]) REFERENCES [Repositories]([Id])

ALTER TABLE [Issues]
ADD CONSTRAINT FK_Issues_Users
FOREIGN KEY([AssigneeId]) REFERENCES [Users]([Id])

ALTER TABLE [Commits]
ADD CONSTRAINT FK_Commits_Issues
FOREIGN KEY([IssueId]) REFERENCES [Issues]([Id])

ALTER TABLE [Commits]
ADD CONSTRAINT FK_Commits_Repositories
FOREIGN KEY([RepositoryId]) REFERENCES [Repositories]([Id])

ALTER TABLE [Commits]
ADD CONSTRAINT FK_Commits_Users
FOREIGN KEY([ContributorId]) REFERENCES [Users]([Id])

ALTER TABLE [Files]
ADD CONSTRAINT FK_Files_Files
FOREIGN KEY([ParentId]) REFERENCES [Files]([Id])

ALTER TABLE [Files]
ADD CONSTRAINT FK_Files_Commits
FOREIGN KEY([CommitId]) REFERENCES [Commits]([Id])