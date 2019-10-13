--01 Employees with Salary Above 35000
CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000
AS
BEGIN
	SELECT e.[FirstName], e.[LastName]
	FROM [Employees] AS e
	WHERE e.[Salary] > 35000
END
GO

--02 Employees with Salary Above Number
CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber (@Salary DECIMAL(18, 4))
AS
BEGIN
	SELECT e.[FirstName], e.[LastName]
	FROM [Employees] AS e
	WHERE e.[Salary] >= @Salary
END
GO

--03 Town Names Starting With
CREATE PROCEDURE usp_GetTownsStartingWith(@StartPattern NVARCHAR(MAX))
AS
BEGIN
	SELECT t.[Name]
	FROM [Towns] AS t
	WHERE t.[Name] LIKE(@StartPattern + '%')
END
GO

--04 Employees from Town
CREATE PROCEDURE usp_GetEmployeesFromTown(@TownName NVARCHAR(MAX))
AS
BEGIN
	SELECT e.[FirstName], e.[LastName]
	FROM [Employees] AS e
	JOIN [Addresses] AS a ON e.[AddressID] = a.[AddressID]
	JOIN [Towns] AS t ON a.[TownID] = t.[TownID]
	WHERE t.[Name] = @TownName
END
GO

--05 Salary Level Function
CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS NVARCHAR(10)
AS
BEGIN
DECLARE @SalaryLevel nvarchar(10)

	IF(@salary < 30000)
	BEGIN
		SET @SalaryLevel = 'Low'
	END

	ELSE IF(@salary BETWEEN 30000 AND 50000)
	BEGIN
		SET @SalaryLevel = 'Average'
	END

	ELSE
	BEGIN
		SET @SalaryLevel = 'High'
	END

	RETURN @SalaryLevel
END
GO

--06 Employees by Salary Level
CREATE PROCEDURE usp_EmployeesBySalaryLevel(@Parameter NVARCHAR(10))
AS
BEGIN
	SELECT e.[FirstName], e.[LastName]
	FROM [Employees] AS e
	WHERE dbo.ufn_GetSalaryLevel(e.[Salary]) = @Parameter
END
GO

--07 Define Function
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters NVARCHAR(MAX), @word NVARCHAR(MAX))
RETURNS BIT
AS
BEGIN
	DECLARE @counter INT = 1;
	DECLARE @currentLetter CHAR;

	WHILE(@counter <= LEN(@word))
	BEGIN
		SET @currentLetter = SUBSTRING(@word, @counter, 1);
		DECLARE @charIndex INT = CHARINDEX(@currentLetter, @setOfLetters);

		IF(@charIndex <= 0)
		BEGIN
			RETURN 0;
		END

		SET @counter += 1;
	END

	RETURN 1;
END 
GO

--08 Delete Employees and Departments
CREATE PROCEDURE usp_DeleteEmployeesFromDepartment (@departmentId INT)
AS 
BEGIN
	DELETE FROM [EmployeesProjects]
	WHERE [EmployeeID] IN
	(
		SELECT e.[EmployeeID]
		FROM [Employees] AS e
		WHERE e.[DepartmentID] = @departmentId
	);

	UPDATE [Employees] 
	SET [ManagerID] = NULL
	WHERE [ManagerID] IN
	(
		SELECT e.[EmployeeID]
		FROM [Employees] AS e
		WHERE e.[DepartmentID] = @departmentId
	);

	ALTER TABLE [Departments]
	ALTER COLUMN [ManagerID] INT;

	UPDATE [Departments]
	SET [ManagerID] = NULL
	WHERE [DepartmentID] = @departmentId;

	ALTER TABLE [Employees]
	ALTER COLUMN [DepartmentID] INT;

	UPDATE [Employees]
	SET [DepartmentID] = NULL
	WHERE [DepartmentID] = @departmentId;

	DELETE FROM [Departments]
	WHERE [DepartmentID] = @departmentId;

	DELETE FROM [Employees]
	WHERE [DepartmentID] = @departmentId;

	SELECT COUNT(*)
	FROM [Employees] AS e
	WHERE e.[DepartmentID] = @departmentId;
END
GO

--09 Find Full Name
CREATE PROCEDURE usp_GetHoldersFullName
AS
BEGIN
	SELECT CONCAT(ah.FirstName, ' ', ah.[LastName]) AS [Full Name]
	FROM [AccountHolders] AS ah
END
GO

--10 People with Balance Higher Than
CREATE PROCEDURE usp_GetHoldersWithBalanceHigherThan @money DECIMAL(18, 4)
AS
BEGIN
	SELECT ah.[FirstName], ah.[LastName]
	FROM [AccountHolders] AS ah
	JOIN [Accounts] AS a ON ah.[Id] = a.[AccountHolderId]
	GROUP BY ah.[FirstName], ah.[LastName]
	HAVING SUM(a.[Balance]) > @money
	ORDER BY ah.[FirstName], ah.[LastName]
END
GO

--11 Future Value Function
CREATE FUNCTION ufn_CalculateFutureValue
(
	@initialSum DECIMAL(18, 4),
	@yearlyInterestRate FLOAT, 
	@numberOfYears INT
)
RETURNS DECIMAL(18, 4)
AS
BEGIN
DECLARE @result DECIMAL(18, 4);
	SET @result = @initialSum * POWER( (1 + @yearlyInterestRate), @numberOfYears);
	RETURN @result;
END
GO

--12 Calculating Interest
CREATE PROCEDURE usp_CalculateFutureValueForAccount
(
	@accountId INT, 
	@yearlyInterestRate FLOAT
)
AS 
BEGIN
SELECT TOP(1)
		ah.[Id], 
		ah.[FirstName], 
		ah.[LastName],
		a.[Balance] AS [Current Balance],
		dbo.ufn_CalculateFutureValue(a.[Balance], @yearlyInterestRate, 5) AS [Balance in 5 years]
	FROM [AccountHolders] AS ah
	JOIN [Accounts] AS a ON ah.[Id] = a.[AccountHolderId]
	WHERE ah.[Id] = @accountId
END
GO

--13 Cash in User Games Odd Rows
CREATE FUNCTION ufn_CashInUsersGames(@gameName NVARCHAR(MAX))
RETURNS @result TABLE (SumCash DECIMAL(18, 4))
AS
BEGIN
INSERT INTO @result
SELECT SUM(ut.[Cash]) AS [SumCash]
	FROM(
	SELECT 
			ug.[Cash],
			ROW_NUMBER() OVER (PARTITION BY [GameId] ORDER BY [Cash] DESC) AS [row]
		FROM [Games] AS g
		JOIN [UsersGames] AS ug ON g.[Id] = ug.[GameId]
		WHERE g.[Name] = @gameName
	) AS ut
	WHERE ut.[row] % 2 <> 0;

	RETURN;
END
GO
