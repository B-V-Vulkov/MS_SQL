--01 Create Database
CREATE DATABASE Minions
GO
USE Minions

--02 Create Tables
CREATE TABLE [Minions](
[Id]		INT PRIMARY KEY,
[Name]		NVARCHAR(20) NOT NULL,
[Age]		INT,
[TownId]	INT
)

CREATE TABLE [Towns](
[Id]	INT PRIMARY KEY,
[Name]	NVARCHAR(20) NOT NULL
)

--03 Alter Minions Tables
ALTER TABLE [Minions]
ADD CONSTRAINT FK_Minions_Towns FOREIGN KEY (TownId) REFERENCES [Towns](Id)

--04. Insert Records in Both Tables
INSERT INTO Towns ([Id], [Name])
	 VALUES (1, 'Sofia'),
			(2, 'Plovdiv'),
			(3, 'Varna')

INSERT INTO Minions(Id, [Name], [Age],[TownId])
	 VALUES (1, 'Kevin', 22, 1),
			(2, 'Bob', 15, 3),
			(3, 'Steward', NULL, 2)

--05 Truncate Table Minions
TRUNCATE TABLE [Minions]

--06 Drop All Tables
ALTER TABLE [Minions]
DROP CONSTRAINT FK_Minions_Towns
TRUNCATE TABLE [Towns]

--07 Create Table People
CREATE TABLE [People](
[Id]			INT PRIMARY KEY IDENTITY,
[Name]			NVARCHAR(200) NOT NULL,
[Picture]		VARBINARY(2),
[Height]		DECIMAL(5,2),
[Weight] 		DECIMAL(5,2),
[Gender]		NVARCHAR(1) NOT NULL,
[Birthdate]		DATE NOT NULL,
[Biography]		NVARCHAR(100)
)

INSERT INTO [People]([Name], [Picture], [Height], [Weight], [Gender], [Birthdate], [Biography])
	VALUES('Pesho', NULL, 1.54, 1.2, 'm', '1992-09-12', NULL),
		  ('Misho', NULL, 1.54, 1.2, 'm', '1992-09-12', NULL),
		  ('Gosho', NULL, 1.54, 1.2, 'm', '1992-09-12', NULL),
		  ('Sara', NULL, 1.54, 1.2, 'f', '1992-09-12', NULL),
		  ('Elinor', NULL, 1.54, 1.2, 'f', '1992-09-12', NULL)  

--08 Create Table Users
CREATE TABLE [Users](
[Id]				INT PRIMARY KEY IDENTITY,
[Username]			NVARCHAR(30) NOT NULL,
[Password]			NVARCHAR(26) NOT NULL,
[ProfilePicture]	VARBINARY(1),
[LastLoginTime]		DATETIME,
[IsDeleted]			NVARCHAR(5),
)

INSERT INTO [Users]([Username], [Password])
	VALUES('Gosho', '123456'),
		  ('Misho', '09876'),
		  ('Silvia', 'dsdsdsd'),
		  ('Ivan', '1JJ21'),
		  ('Eva', '32323')

--09 Change Primary Key
ALTER TABLE [Users]
DROP CONSTRAINT PK__Users__3214EC074969D5BC

ALTER TABLE [Users]
ADD CONSTRAINT PK_Users
PRIMARY KEY ([Id], [Username])

--10 Add Check Constraint
ALTER TABLE [Users]
ADD CONSTRAINT CHK_Password
CHECK (LEN([Password]) >= 5)

--11 Set Default Value of a Field
ALTER TABLE [Users]
ADD DEFAULT GETDATE() FOR [LastLoginTime]

--12 Set Unique Field
ALTER TABLE [Users]
DROP CONSTRAINT PK_Users

ALTER TABLE [Users]
ADD CONSTRAINT PK_Id
PRIMARY KEY ([Id])

ALTER TABLE [Users]
ADD UNIQUE ([Username])

ALTER TABLE [Users]
ADD CONSTRAINT CHK_Username
CHECK (LEN([Username]) >= 3)

--13 Movies Database
CREATE DATABASE [Movies]
GO
USE [Movies]
GO

CREATE TABLE [Directors](
	[Id]				INT PRIMARY KEY IDENTITY,
	[DirectorName]		NVARCHAR(30) NOT NULL,
	[Notes]				TEXT
)

CREATE TABLE [Genres](
	[Id]				INT PRIMARY KEY IDENTITY,
	[GenreName]			NVARCHAR(30) NOT NULL,
	[Notes]				TEXT
)

CREATE TABLE [Categories](
	[Id]				INT PRIMARY KEY IDENTITY,
	[CategoryName]		NVARCHAR(30) NOT NULL,
	[Notes]				TEXT
)

CREATE TABLE [Movies](
	[Id]				INT PRIMARY KEY IDENTITY,
	[Title]				NVARCHAR(30) NOT NULL,
	[DirectorId]		INT,
	[CopyrightYear]		DATE,
	[Length]			INT,
	[GenreId]			INT,
	[CategoryId]		INT,
	[Rating]			DECIMAL(2,2),
	[Notes]				TEXT
)

ALTER TABLE [Movies]
ADD CONSTRAINT FK_Movies_Directors
FOREIGN KEY ([DirectorId]) REFERENCES [Directors]([Id])

ALTER TABLE [Movies]
ADD CONSTRAINT FK_Movies_Genres
FOREIGN KEY ([GenreId]) REFERENCES [Genres](Id)

ALTER TABLE [Movies]
ADD CONSTRAINT FK_Movies_Categories
FOREIGN KEY ([CategoryId]) REFERENCES [Categories](Id)

INSERT INTO [Directors] VALUES('Misho', NULL)
INSERT INTO [Directors] VALUES('Gosho', NULL)
INSERT INTO [Directors] VALUES('Stefan', NULL)
INSERT INTO [Directors] VALUES('Petko', NULL)
INSERT INTO [Directors] VALUES('Stoian', NULL)

INSERT INTO [Genres] VALUES('Action', NULL)
INSERT INTO [Genres] VALUES('Criminal', NULL)
INSERT INTO [Genres] VALUES('Comedy', NULL)
INSERT INTO [Genres] VALUES('Fiction', NULL)
INSERT INTO [Genres] VALUES('Fantasy', NULL)

INSERT INTO [Categories] VALUES('European', NULL)
INSERT INTO [Categories] VALUES('American', NULL)
INSERT INTO [Categories] VALUES('Ìusical', NULL)
INSERT INTO [Categories] VALUES('Asian', NULL)
INSERT INTO [Categories] VALUES('TV series', NULL)

INSERT INTO [Movies] VALUES('Titanic', 1, '12-12-1994', NULL, 1, 2, NULL, NULL)
INSERT INTO [Movies] VALUES('Titanic', 1, '12-12-1994', NULL, 1, 2, NULL, NULL)
INSERT INTO [Movies] VALUES('Titanic', 1, '12-12-1994', NULL, 1, 2, NULL, NULL)
INSERT INTO [Movies] VALUES('Titanic', 1, '12-12-1994', NULL, 1, 2, NULL, NULL)
INSERT INTO [Movies] VALUES('Titanic', 1, '12-12-1994', NULL, 1, 2, NULL, NULL)

--14 Car Rental Database
CREATE DATABASE [CarRental]
GO
USE [CarRental]
GO

CREATE TABLE [Categories](
	[Id]			INT IDENTITY,
	[CategoryName]	NVARCHAR(30) NOT NULL,
	[DailyRate]		DECIMAL(5,2) NOT NULL,
	[WeeklyRate]	DECIMAL(5,2) NOT NULL,
	[MonthlyRate]	DECIMAL(5,2) NOT NULL,
	[WeekendRate]	DECIMAL(5,2) NOT NULL,
	CONSTRAINT PK_Category PRIMARY KEY ([Id])
)

CREATE TABLE [Cars](
	[Id]			INT IDENTITY,
	[PlateNumber]	NVARCHAR(30) NOT NULL,
	[Manufacturer]	NVARCHAR(30) NOT NULL,
	[Model]			NVARCHAR(30) NOT NULL,
	[CarYear]		DATE,
	[CategoryId]	INT NOT NULL,
	[Doors]			INT,
	[Picture]		VARBINARY(MAX),
	[Condition]		VARCHAR(10),
	[Available]		BIT,
	CONSTRAINT PK_Car PRIMARY KEY ([Id])
)

CREATE TABLE [Employees](
	[Id]			INT IDENTITY,
	[FirstName]		NVARCHAR(30) NOT NULL,
	[LastName]		NVARCHAR(30) NOT NULL,
	[Title]			NVARCHAR(30),
	[Notes]			TEXT,
	CONSTRAINT PK_Employee PRIMARY KEY ([Id])
)

CREATE TABLE [Customers](
	[Id]					INT IDENTITY,
	[DriverLicenceNumber]	NVARCHAR(30) NOT NULL,
	[FullName]				NVARCHAR(30) NOT NULL,
	[Address]				NVARCHAR(30),
	[City]					NVARCHAR(30),
	[ZIPCode]				INT,
	[Notes]					TEXT,
	CONSTRAINT PK_Customer PRIMARY KEY ([Id])
)

CREATE TABLE [RentalOrders](
	[Id]				INT IDENTITY,
	[EmployeeId]		INT NOT NULL,
	[CustomerId]		INT NOT NULL,
	[CarId]				INT NOT NULL,
	[TankLevel]			INT,
	[KilometrageStart]	INT,
	[KilometrageEnd]	INT,
	[TotalKilometrage]	INT,
	[StartDate]			DATE,
	[EndDate]			DATE,
	[TotalDays]			INT,
	[RateApplied]		NVARCHAR(30),
	[TaxRate]			DECIMAL(5,2),
	[OrderStatus]		NVARCHAR(30),
	[Notes]				TEXT,
	CONSTRAINT PK_RentalOrder PRIMARY KEY ([Id])
)

ALTER TABLE [Cars]
ADD CONSTRAINT FK_Cars_Categories
FOREIGN KEY ([CategoryId]) REFERENCES [Categories]([Id])

ALTER TABLE [RentalOrders]
ADD CONSTRAINT FK_RentalOrders_Employees
FOREIGN KEY ([EmployeeId]) REFERENCES [Employees]([Id])

ALTER TABLE [RentalOrders]
ADD CONSTRAINT FK_RentalOrders_Customers
FOREIGN KEY ([CustomerId]) REFERENCES [Customers]([Id])

ALTER TABLE [RentalOrders]
ADD CONSTRAINT FK_RentalOrders_Cars
FOREIGN KEY ([CarId]) REFERENCES [Cars]([Id])

INSERT INTO [Categories] VALUES ('Bus', 1.2, 2.2, 3.3, 4.4)
INSERT INTO [Categories] VALUES ('Bus', 1.2, 2.2, 3.3, 4.4)
INSERT INTO [Categories] VALUES ('Bus', 1.2, 2.2, 3.3, 4.4)

INSERT INTO [Cars] VALUES ('12RET45TF', 'BMW', '306', NULL, 1, NULL, NULL, NULL, NULL)
INSERT INTO [Cars] VALUES ('12RET45TF', 'BMW', '306', NULL, 2, NULL, NULL, NULL, NULL)
INSERT INTO [Cars] VALUES ('12RET45TF', 'BMW', '306', NULL, 3, NULL, NULL, NULL, NULL)

INSERT INTO [Employees] VALUES ('Misho', 'Mishev', 'Misho', NULL)
INSERT INTO [Employees] VALUES ('Misho', 'Mishev', 'Misho', NULL)
INSERT INTO [Employees] VALUES ('Misho', 'Mishev', 'Misho', NULL)

INSERT INTO [Customers] VALUES ('23RE3434', 'Mishev', 'Sofia', 'Sofia', NULL, NULL)
INSERT INTO [Customers] VALUES ('23RE3434', 'Mishev', 'Sofia', 'Sofia', NULL, NULL)
INSERT INTO [Customers] VALUES ('23RE3434', 'Mishev', 'Sofia', 'Sofia', NULL, NULL)

INSERT INTO [RentalOrders] ([EmployeeId], [CustomerId], [CarId]) VALUES (1, 1, 1)
INSERT INTO [RentalOrders] ([EmployeeId], [CustomerId], [CarId]) VALUES (1, 1, 1)
INSERT INTO [RentalOrders] ([EmployeeId], [CustomerId], [CarId]) VALUES (1, 1, 1)