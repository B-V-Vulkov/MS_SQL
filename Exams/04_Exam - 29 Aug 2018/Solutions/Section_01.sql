--Section 01 DDL
USE [master]
GO

CREATE DATABASE [Supermarket]
GO

USE [Supermarket]
GO

CREATE TABLE [Categories](
	[Id]			INT IDENTITY,
	[Name]			NVARCHAR(30) NOT NULL,
	CONSTRAINT PK_Categories
	PRIMARY KEY ([Id])
)

CREATE TABLE [Items](
	[Id]			INT IDENTITY,
	[Name]			NVARCHAR(30) NOT NULL,
	[Price]			DECIMAL(18, 2) NOT NULL,
	[CategoryId]	INT NOT NULL
	CONSTRAINT PK_Items
	PRIMARY KEY ([Id])
)

CREATE TABLE [Employees](
	[Id]			INT IDENTITY,
	[FirstName]		NVARCHAR(50) NOT NULL,
	[LastName]		NVARCHAR(50) NOT NULL,
	[Phone]			CHAR(12) NOT NULL,
	[Salary]		DECIMAL(18, 2) NOT NULL,
	CONSTRAINT PK_Employees
	PRIMARY KEY ([Id])
)

CREATE TABLE [Orders](
	[Id]			INT IDENTITY,
	[DateTime]		DATETIME NOT NULL,
	[EmployeeId]	INT NOT NULL,
	CONSTRAINT PK_Orders
	PRIMARY KEY ([Id])
)

CREATE TABLE [OrderItems](
	[OrderId]		INT,
	[ItemId]		INT,
	[Quantity]		INT NOT NULL,
	CONSTRAINT CHK_QuantityMore0
	CHECK([Quantity] > 0),
	CONSTRAINT PK_OrderItems
	PRIMARY KEY ([OrderId], [ItemId])
)

CREATE TABLE [Shifts](
	[Id]			INT IDENTITY,
	[EmployeeId]	INT,
	[CheckIn]		DATETIME NOT NULL,
	[CheckOut]		DATETIME NOT NULL,
	CONSTRAINT CHK_CheckInAfterCheckOut
	CHECK([CheckOut] > [CheckIn]),
	CONSTRAINT PK_Shifts
	PRIMARY KEY ([Id], [EmployeeId])
)

ALTER TABLE [Items]
ADD CONSTRAINT FK_Items_Categories
FOREIGN KEY([CategoryId]) REFERENCES [Categories]([Id])

ALTER TABLE [Orders]
ADD CONSTRAINT FK_Orders_Employees
FOREIGN KEY([EmployeeId]) REFERENCES [Employees]([Id])

ALTER TABLE [OrderItems]
ADD CONSTRAINT FK_OrderItems_Orders
FOREIGN KEY([OrderId]) REFERENCES [Orders]([Id])

ALTER TABLE [OrderItems]
ADD CONSTRAINT FK_OrderItems_Items
FOREIGN KEY([ItemId]) REFERENCES [Items]([Id])

ALTER TABLE [Shifts]
ADD CONSTRAINT FK_Shiftss_Employees
FOREIGN KEY([EmployeeId]) REFERENCES Employees([Id])