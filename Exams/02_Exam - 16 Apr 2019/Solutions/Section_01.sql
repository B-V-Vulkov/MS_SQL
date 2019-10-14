--Section 01
--01 DDL
CREATE DATABASE [Airport]
GO

USE [Airport]
GO

CREATE TABLE [Planes](
	[Id]			INT IDENTITY,
	[Name]			NVARCHAR(30) NOT NULL,
	[Seats]			INT NOT NULL,
	[Range]			INT NOT NULL,
	CONSTRAINT PK_Planes
	PRIMARY KEY([Id])
)

CREATE TABLE [Flights](
	[Id]			INT IDENTITY,
	[DepartureTime]	DATETIME NULL,
	[ArrivalTime]	DATETIME NULL,
	[Origin]		NVARCHAR(50) NOT NULL,
	[Destination]	NVARCHAR(50) NOT NULL,
	[PlaneId]		INT NOT NULL,
	CONSTRAINT PK_Flights
	PRIMARY KEY([Id])
)

CREATE TABLE [Passengers](
	[Id]			INT IDENTITY,
	[FirstName]		NVARCHAR(30) NOT NULL,
	[LastName]		NVARCHAR(30) NOT NULL,
	[Age]			INT NOT NULL,
	[Address]		NVARCHAR(30) NOT NULL,
	[PassportId]	NCHAR(11) NOT NULL,
	CONSTRAINT PK_Passengers
	PRIMARY KEY([Id])
)

CREATE TABLE [LuggageTypes](
	[Id]			INT IDENTITY,
	[Type]			NVARCHAR(30) NOT NULL,
	CONSTRAINT PK_LuggageTypes
	PRIMARY KEY([Id])
)

CREATE TABLE [Luggages](
	[Id]			INT IDENTITY,
	[LuggageTypeId]	INT NOT NULL,
	[PassengerId]	INT NOT NULL,
	CONSTRAINT PK_Luggages
	PRIMARY KEY([Id])
)

CREATE TABLE [Tickets](
	[Id]			INT IDENTITY,
	[PassengerId]	INT NOT NULL,
	[FlightId]		INT NOT NULL,
	[LuggageId]		INT NOT NULL,
	[Price]			DECIMAL(18, 2) NOT NULL,
	CONSTRAINT PK_Tickets
	PRIMARY KEY([Id])
)

ALTER TABLE [Flights]
ADD CONSTRAINT FK_Flights_Planes
FOREIGN KEY([PlaneId]) REFERENCES [Planes]([Id])

ALTER TABLE [Luggages]
ADD CONSTRAINT FK_Luggages_LuggageTypes
FOREIGN KEY([LuggageTypeId]) REFERENCES [LuggageTypes]([Id])

ALTER TABLE [Luggages]
ADD CONSTRAINT FK_Luggages_Passengers
FOREIGN KEY([PassengerId]) REFERENCES [Passengers]([Id])

ALTER TABLE [Tickets]
ADD CONSTRAINT FK_Tickets_Passengers
FOREIGN KEY([PassengerId]) REFERENCES [Passengers]([Id])

ALTER TABLE [Tickets]
ADD CONSTRAINT FK_Tickets_Flights
FOREIGN KEY([FlightId]) REFERENCES [Flights]([Id])

ALTER TABLE [Tickets]
ADD CONSTRAINT FK_Tickets_Luggages
FOREIGN KEY([LuggageId]) REFERENCES [Luggages]([Id])