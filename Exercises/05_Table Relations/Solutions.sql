--01 One-To-One Relationship
CREATE TABLE [Persons](
	[PersonID]			INT IDENTITY,
	[FirstName]			NVARCHAR(30) NOT NULL,
	[Salary]			DECIMAL(7,2) NOT NULL,
	[PassportID]		INT NOT NULL
	CONSTRAINT PK_Persons PRIMARY KEY([PersonID])
)

CREATE TABLE [Passports](
	[PassportID]		INT,
	[PassportNumber]	NVARCHAR(8),
	CONSTRAINT PK_Passports PRIMARY KEY([PassportID])
)

ALTER TABLE [Persons]
	ADD CONSTRAINT FK_Persons_Passports
	FOREIGN KEY([PassportID]) REFERENCES [Passports]([PassportID])

INSERT INTO [Passports] VALUES (101, 'N34FG21B')
INSERT INTO [Passports] VALUES (102, 'K65LO4R7')
INSERT INTO [Passports] VALUES (103, 'ZE657QP2')

INSERT INTO [Persons] VALUES ('Roberto', 43300.00, 102)
INSERT INTO [Persons] VALUES ('Tom', 56100.00, 103)
INSERT INTO [Persons] VALUES ('Yana', 60200.00, 101)

--02 One-To-Many Relationship
CREATE TABLE [Models](
	[ModelID]			INT,
	[Name]				NVARCHAR(30),
	[ManufacturerID]	INT NOT NULL,
	CONSTRAINT PK_Models PRIMARY KEY([ModelID])
)

CREATE TABLE [Manufacturers](
	[ManufacturerID]	INT,
	[Name]				NVARCHAR(30),
	[EstablishedOn]		DATE,
	CONSTRAINT PK_Manufacturers PRIMARY KEY([ManufacturerID])
)

ALTER TABLE [Models]
	ADD CONSTRAINT FK_Models_Manufacturers
	FOREIGN KEY([ManufacturerID]) REFERENCES [Manufacturers]([ManufacturerID]) 

INSERT INTO [Manufacturers] VALUES (1, 'BMW', '7/03/1916')
INSERT INTO [Manufacturers] VALUES (2, 'Tesla', '01/01/2003')
INSERT INTO [Manufacturers] VALUES (3, 'Lada', '01/05/1966')

INSERT INTO [Models] VALUES (101, 'X1', 1)
INSERT INTO [Models] VALUES (102, 'i6', 1)
INSERT INTO [Models] VALUES (103, 'Model S', 2)
INSERT INTO [Models] VALUES (104, 'Model X', 2)
INSERT INTO [Models] VALUES (105, 'Model 3', 2)
INSERT INTO [Models] VALUES (106, 'Nova', 3)

--03 Many-To-Many Relationship
CREATE TABLE [Students](
	[StudentID]		INT,
	[Name]			NVARCHAR(30),
	CONSTRAINT PK_Students PRIMARY KEY([StudentID])
)

CREATE TABLE [Exams](
	[ExamID]		INT,
	[Name]			NVARCHAR(30),
	CONSTRAINT PK_Exams PRIMARY KEY([ExamID])
)

CREATE TABLE [StudentsExams](
	[StudentID]		INT,
	[ExamID]		INT,
	CONSTRAINT PK_StudentsExams PRIMARY KEY([StudentID], [ExamID])
)

ALTER TABLE [StudentsExams]
	ADD CONSTRAINT FK_StudentsExams_Students
	FOREIGN KEY([StudentID]) REFERENCES [Students]([StudentID]) 

ALTER TABLE [StudentsExams]
	ADD CONSTRAINT FK_StudentsExams_Exams
	FOREIGN KEY([ExamID]) REFERENCES [Exams]([ExamID]) 

INSERT INTO [Students] VALUES (1, 'Mila')
INSERT INTO [Students] VALUES (2, 'Toni')
INSERT INTO [Students] VALUES (3, 'Ron')

INSERT INTO [Exams] VALUES (101, 'SpringMVC')
INSERT INTO [Exams] VALUES (102, 'Neo4j')
INSERT INTO [Exams] VALUES (103, 'Oracle 11g')

INSERT INTO [StudentsExams] VALUES (1, 101)
INSERT INTO [StudentsExams] VALUES (1, 102)
INSERT INTO [StudentsExams] VALUES (2, 101)
INSERT INTO [StudentsExams] VALUES (3, 103)
INSERT INTO [StudentsExams] VALUES (2, 102)
INSERT INTO [StudentsExams] VALUES (2, 103)

--04 Self-Referencing
CREATE TABLE [Teachers](
	[TeacherID]		INT,
	[Name]			NVARCHAR(30),
	[ManagerID]		INT,
	CONSTRAINT PK_Teachers PRIMARY KEY([TeacherID]),
	CONSTRAINT FK_ManagerID_TeacherID FOREIGN KEY([ManagerID]) REFERENCES [Teachers]([TeacherID])
)

--05 Online Store Database
CREATE DATABASE [OnlineStore]
USE [OnlineStore]

CREATE TABLE [Orders](
	[OrderID]		INT,
	[CustomerID]	INT,
	CONSTRAINT PK_Orders PRIMARY KEY([OrderID])
)

CREATE TABLE [Customers](
	[CustomerID]	INT,
	[Name]			NVARCHAR(50),
	[Birthday]		DATE,
	[CityID]		INT
	CONSTRAINT PK_Customers PRIMARY KEY([CustomerID])
)

CREATE TABLE [Cities](
	[CityID]		INT,
	[Name]			NVARCHAR(50),
	CONSTRAINT PK_Cities PRIMARY KEY([CityID])
)

CREATE TABLE [OrderItems](
	[OrderID]		INT,
	[ItemID]		INT,
	CONSTRAINT PK_OrderItems PRIMARY KEY([OrderID], [ItemID])
)

CREATE TABLE [Items](
	[ItemID]		INT,
	[Name]			NVARCHAR(50),
	[ItemTypeID]	INT
	CONSTRAINT PK_Items PRIMARY KEY([ItemID])
)

CREATE TABLE [ItemTypes](
	[ItemTypeID]	INT,
	[Name]			NVARCHAR(50)
	CONSTRAINT PK_ItemTypes PRIMARY KEY([ItemTypeID])
)

ALTER TABLE [OrderItems]
	ADD CONSTRAINT FK_OrderItems_Orders
	FOREIGN KEY([OrderID]) REFERENCES [Orders]([OrderID])

ALTER TABLE [OrderItems]
	ADD CONSTRAINT FK_OrderItems_Items
	FOREIGN KEY([ItemID]) REFERENCES [Items]([ItemID])

ALTER TABLE [Items]
	ADD CONSTRAINT FK_Items_ItemTypes
	FOREIGN KEY([ItemTypeID]) REFERENCES [ItemTypes]([ItemTypeID])

ALTER TABLE [Orders]
	ADD CONSTRAINT FK_Orders_Customers
	FOREIGN KEY([CustomerID]) REFERENCES [Customers]([CustomerID])

ALTER TABLE [Customers]
	ADD CONSTRAINT FK_Customers_Cities
	FOREIGN KEY([CityID]) REFERENCES [Cities]([CityID])

--06 University Database
CREATE DATABASE [University]
GO
USE [University]
GO

CREATE TABLE [Majors](
	[MajorID]		INT,
	[Name]			NVARCHAR(30),
	CONSTRAINT PK_Majors PRIMARY KEY([MajorID])
)

CREATE TABLE [Payments](
	[PaymentID]		INT,
	[PaymentDate]	DATE,
	[PaymentAmaunt]	DECIMAL(7,2),
	[StudentID]		INT NOT NULL,
	CONSTRAINT PK_Payments PRIMARY KEY([PaymentID])
)

CREATE TABLE [Students](
	[StudentID]		INT,
	[StudentNumber]	NVARCHAR(10),
	[StudentName]	NVARCHAR(30),
	[MajorID]		INT NOT NULL,
	CONSTRAINT PK_Students PRIMARY KEY([StudentID])
)

CREATE TABLE [Agenda](
	[StudentID]		INT,
	[SubjectID]		INT,
	CONSTRAINT PK_Agenda PRIMARY KEY([StudentID], [SubjectID])
)

CREATE TABLE [Subjects](
	[SubjectID]		INT,
	[SubjectName]	NVARCHAR(30),
	CONSTRAINT PK_Subjects PRIMARY KEY([SubjectID])
)

ALTER TABLE [Students]
	ADD CONSTRAINT FK_Students_Majors
	FOREIGN KEY([MajorID]) REFERENCES [Majors]([MajorID])

ALTER TABLE [Payments]
	ADD CONSTRAINT FK_Payments_Students
	FOREIGN KEY([StudentID]) REFERENCES [Students]([StudentID])

ALTER TABLE [Agenda]
	ADD CONSTRAINT FK_Agenda_Students
	FOREIGN KEY([StudentID]) REFERENCES [Students]([StudentID])

ALTER TABLE [Agenda]
	ADD CONSTRAINT FK_Agenda_Subjects
	FOREIGN KEY([SubjectID]) REFERENCES [Subjects]([SubjectID])

--09 Peaks in Rila
SELECT m.[MountainRange], p.[PeakName], p.[Elevation]
	FROM [Peaks] AS p
	JOIN [Mountains] AS m ON p.[MountainID] = m.[Id]
	WHERE m.[MountainRange] = 'Rila'
	ORDER BY p.[Elevation] DESC