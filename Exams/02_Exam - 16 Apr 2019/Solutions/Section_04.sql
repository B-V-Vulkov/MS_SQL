--Section 04
--18 Vacation
CREATE FUNCTION udf_CalculateTickets(
	@origin VARCHAR(MAX), 
	@destination VARCHAR(MAX), 
	@peopleCount INT
)
RETURNS NVARCHAR(100)
AS
BEGIN
	IF(@peopleCount <= 0)
	BEGIN
		RETURN 'Invalid people count!';
	END

	DECLARE @triId INT;
	SET @TriId = (
		SELECT f.[Id]
		FROM [Flights] AS f
		JOIN [Tickets] AS t ON f.[Id] = t.[FlightId]
		WHERE f.[Origin] = @origin AND f.[Destination] = @destination)

	IF(@triId IS NULL)
	BEGIN
		RETURN 'Invalid flight!';
	END

	DECLARE @priceForOneTiket DECIMAL(15, 2);
	DECLARE @totalPrice DECIMAL(15, 2);

	SET @priceForOneTiket = (
		SELECT t.[Price]
		FROM [Flights] AS f
		JOIN [Tickets] AS t ON f.[Id] = t.[FlightId]
		WHERE f.[Id] = @triId)

	SET @totalPrice = @priceForOneTiket * @peopleCount;

	RETURN CONCAT('Total price ', @totalPrice);
END
GO

--19 Wrong Data
CREATE PROCEDURE usp_CancelFlights
AS
BEGIN
	UPDATE [Flights]
	SET [ArrivalTime] = NULL, [DepartureTime] = NULL
	WHERE [ArrivalTime] > [DepartureTime]
END

--20 Deleted Planes
CREATE TABLE [DeletedPlanes](
	[Id]		INT NOT NULL,
	[Name]		NVARCHAR(30) NOT NULL,
	[Seats]		INT NOT NULL,
	[Range]		INT NOT NULL,
	CONSTRAINT PK_DeletedPlanes
	PRIMARY KEY([Id])
)
GO

CREATE TRIGGER tr_onDeletedPlanes ON [Planes] FOR DELETE
AS
BEGIN
	INSERT INTO [DeletedPlanes]
		SELECT 
			d.[Id],
			d.[Name],
			d.[Seats],
			d.[Range]
		FROM [deleted] AS d
END