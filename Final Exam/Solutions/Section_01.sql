--Section 01
--01 DDL
USE [master]
GO

CREATE DATABASE [Service]
GO

USE [Service]
GO

CREATE TABLE [Users](
	[Id]			INT IDENTITY,
	[Username]		NVARCHAR(30) NOT NULL,
	[Password]		NVARCHAR(50) NOT NULL,
	[Name]			NVARCHAR(50) NOT NULL,
	[Birthdate]		DATETIME NOT NULL,
	[Age]			INT NULL,
	[Email]			NVARCHAR(50) NOT NULL,
	CONSTRAINT CHK_AgeBetween14And110
	CHECK([Age] BETWEEN 14 AND 110),
	CONSTRAINT PK_Users
	PRIMARY KEY([Id]),
)

CREATE TABLE [Departments](
	[Id]			INT IDENTITY,
	[Name]			VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Departments
	PRIMARY KEY([Id]),
)

CREATE TABLE [Employees](
	[Id]			INT IDENTITY,
	[FirstName]		VARCHAR(25) NULL,
	[LastName]		VARCHAR(25) NULL,
	[Birthdate]		DATETIME NULL,
	[Age]			INT NULL,
	[DepartmentId]	INT NULL,
	CONSTRAINT CHK_AgeBetween18And110
	CHECK([Age] BETWEEN 18 AND 110),
	CONSTRAINT PK_Employees
	PRIMARY KEY([Id]),
)

CREATE TABLE [Categories](
	[Id]			INT IDENTITY,
	[Name]			VARCHAR(50) NOT NULL,
	[DepartmentId]	INT NOT NULL,
	CONSTRAINT PK_Categories
	PRIMARY KEY([Id]),
)

CREATE TABLE [Status](
	[Id]			INT IDENTITY,
	[Label]			VARCHAR(30) NOT NULL,
	CONSTRAINT PK_Status
	PRIMARY KEY([Id]),
)

CREATE TABLE [Reports](
	[Id]			INT IDENTITY,
	[CategoryId]	INT NOT NULL,
	[StatusId]		INT NOT NULL,
	[OpenDate]		DATETIME NOT NULL,
	[CloseDate]		DATETIME NULL,
	[Description]	VARCHAR(200) NOT NULL,
	[UserId]		INT NOT NULL,
	[EmployeeId]	INT NULL,
	CONSTRAINT PK_Reports
	PRIMARY KEY([Id]),
)

ALTER TABLE [Employees]
ADD CONSTRAINT FK_Employees_Departments
FOREIGN KEY([DepartmentId]) REFERENCES [Departments]([Id])

ALTER TABLE [Categories]
ADD CONSTRAINT FK_Categories_Departments
FOREIGN KEY([DepartmentId]) REFERENCES [Departments]([Id])

ALTER TABLE [Reports]
ADD CONSTRAINT FK_Reports_Categories
FOREIGN KEY([CategoryId]) REFERENCES [Categories]([Id])

ALTER TABLE [Reports]
ADD CONSTRAINT FK_Reports_Status
FOREIGN KEY([StatusId]) REFERENCES [Status]([Id])

ALTER TABLE [Reports]
ADD CONSTRAINT FK_Reports_Users
FOREIGN KEY([UserId]) REFERENCES [Users]([Id])

ALTER TABLE [Reports]
ADD CONSTRAINT FK_Reports_Employees
FOREIGN KEY([EmployeeId]) REFERENCES [Employees]([Id])