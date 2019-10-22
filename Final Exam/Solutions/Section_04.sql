--Section 04
--11 Hours to Complete
CREATE FUNCTION udf_HoursToComplete(
	@StartDate DATETIME, 
	@EndDate DATETIME
)
RETURNS INT
AS
BEGIN
	IF(@StartDate IS NULL)
	BEGIN
		RETURN 0;
	END

	IF(@EndDate IS NULL)
	BEGIN
		RETURN 0;
	END

	RETURN DATEDIFF(HOUR, @StartDate, @EndDate)
END
GO

--12 Assign Employee
CREATE PROCEDURE usp_AssignEmployeeToReport(
	@EmployeeId INT, 
	@ReportId INT
)
AS
BEGIN
	DECLARE @EmployeeDepartmentId INT;
	DECLARE @ReportDepartmentId INT;

	SET @EmployeeDepartmentId = (
		SELECT e.[DepartmentId]
		FROM [Employees] AS e
		WHERE e.[Id] = @EmployeeId);

	SET @ReportDepartmentId = (
		SELECT c.[DepartmentId]
		FROM [Reports] AS r
		JOIN [Categories] AS c ON r.[CategoryId] = c.[Id]
		WHERE r.[Id] = @ReportId);

	IF(@EmployeeDepartmentId != @ReportDepartmentId)
	BEGIN
		RAISERROR('Employee doesn''t belong to the appropriate department!', 16, 1)
		RETURN
	END

	UPDATE [Reports]
	SET [EmployeeId] = @EmployeeId
	WHERE [Id] = @ReportId;
END
GO