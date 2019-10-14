--Section 02
--02 Insert
INSERT INTO [Planes] VALUES('Airbus 336', 112, 5132)
INSERT INTO [Planes] VALUES('Airbus 330', 432, 5325)
INSERT INTO [Planes] VALUES('Boeing 369', 231, 2355)
INSERT INTO [Planes] VALUES('Stelt 297', 254, 2143)
INSERT INTO [Planes] VALUES('Boeing 338', 165, 5111)
INSERT INTO [Planes] VALUES('Airbus 558', 387, 1342)
INSERT INTO [Planes] VALUES('Boeing 128', 345, 5541)

INSERT INTO [LuggageTypes] VALUES('Crossbody Bag')
INSERT INTO [LuggageTypes] VALUES('School Backpack')
INSERT INTO [LuggageTypes] VALUES('Shoulder Bag')

--03 Update
UPDATE [Tickets]
	SET [Price] = [Price] * 1.13
	WHERE [FlightId] IN (
		SELECT f.[Id]
		FROM [Flights] AS f
		WHERE f.[Destination] = 'Carlsbad')

--04 Delete
ALTER TABLE [Tickets]
ALTER COLUMN [FlightId] INT

UPDATE [Tickets]
	SET [FlightId] = NULL
	WHERE [FlightId] IN (
		SELECT f.[Id]
		FROM [Flights] AS f
		WHERE f.[Destination] = 'Ayn Halagim')

DELETE [Flights]
WHERE [Destination] = 'Ayn Halagim'