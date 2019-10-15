--Section 01
--01 DDL
USE [master]
GO

CREATE DATABASE [School]
GO

USE [School]
GO

CREATE TABLE [Students](
	[Id]			INT IDENTITY,
	[FirstName]		NVARCHAR(30) NOT NULL,
	[MiddleName]	NVARCHAR(25) NULL,
	[LastName]		NVARCHAR(30) NOT NULL,
	[Age]			SMALLINT NULL,
	[Address]		NVARCHAR(50) NULL,
	[Phone]			NCHAR(10) NULL,
	CONSTRAINT CHK_AgeBetween5And100
	CHECK([Age] BETWEEN 5 AND 100),
	CONSTRAINT PK_Students
	PRIMARY KEY([Id])
)

CREATE TABLE [Subjects](
	[Id]			INT IDENTITY,
	[Name]			NVARCHAR(20) NOT NULL,
	[Lessons]		INT,
	CONSTRAINT CHK_LessonsMoreThan0
	CHECK([Lessons] > 0),
	CONSTRAINT PK_Subjects
	PRIMARY KEY([Id])
)

CREATE TABLE [StudentsSubjects](
	[Id]			INT IDENTITY,
	[StudentId]		INT NOT NULL,
	[SubjectId]		INT NOT NULL,
	[Grade]			DECIMAL(3, 2),
	CONSTRAINT CHK_GradeBetween2And6_StudentsSubjects
	CHECK([Grade] BETWEEN 2 AND 6),
	CONSTRAINT PK_StudentsSubjects
	PRIMARY KEY([Id])
)

CREATE TABLE [Exams](
	[Id]			INT IDENTITY,
	[Date]			DATETIME NULL,
	[SubjectId]		INT NOT NULL,
	CONSTRAINT PK_Exams
	PRIMARY KEY([Id])
)

CREATE TABLE [StudentsExams](
	[StudentId]		INT,
	[ExamId]		INT,
	[Grade]			DECIMAL
	CONSTRAINT CHK_GradeBetween2And6_StudentsExams
	CHECK([Grade] BETWEEN 2 AND 6),
	CONSTRAINT PK_StudentsExams
	PRIMARY KEY([StudentId], [ExamId])
)

CREATE TABLE [Teachers](
	[Id]			INT IDENTITY,
	[FirstName]		NVARCHAR(20) NOT NULL,
	[LastName]		NVARCHAR(20) NOT NULL,
	[Address]		NVARCHAR(20) NOT NULL,
	[Phone]			NCHAR(10) NULL,
	[SubjectId]		INT NOT NULL,
	CONSTRAINT PK_Teachers
	PRIMARY KEY([Id])
)

CREATE TABLE [StudentsTeachers](
	[StudentId]		INT,
	[TeacherId]		INT,
	CONSTRAINT PK_StudentsTeachers
	PRIMARY KEY([StudentId], [TeacherId])
)

ALTER TABLE [StudentsSubjects]
ADD CONSTRAINT FK_StudentsSubjects_Students
FOREIGN KEY ([StudentId]) REFERENCES [Students]([Id])

ALTER TABLE [StudentsSubjects]
ADD CONSTRAINT FK_StudentsSubjects_Subjects
FOREIGN KEY ([SubjectId]) REFERENCES [Subjects]([Id])

ALTER TABLE [Exams]
ADD CONSTRAINT FK_Exams_Subjects
FOREIGN KEY ([SubjectId]) REFERENCES [Subjects]([Id])

ALTER TABLE [StudentsExams]
ADD CONSTRAINT FK_StudentsExams_Students
FOREIGN KEY ([StudentId]) REFERENCES [Students]([Id])

ALTER TABLE [StudentsExams]
ADD CONSTRAINT FK_StudentsExams_Exams
FOREIGN KEY ([ExamId]) REFERENCES [Exams]([Id])

ALTER TABLE [Teachers]
ADD CONSTRAINT FK_Teachers_Subjects
FOREIGN KEY ([SubjectId]) REFERENCES [Subjects]([Id])

ALTER TABLE [StudentsTeachers]
ADD CONSTRAINT FK_StudentsTeachers_Students
FOREIGN KEY ([StudentId]) REFERENCES [Students]([Id])

ALTER TABLE [StudentsTeachers]
ADD CONSTRAINT FK_StudentsTeachers_Teachers
FOREIGN KEY ([TeacherId]) REFERENCES [Teachers]([Id])