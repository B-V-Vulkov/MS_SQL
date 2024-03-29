--01 Find Names of All Employees by First Name
SELECT [FirstName], [LastName]
	FROM [Employees]
	WHERE [FirstName] LIKE ('Sa%')

--02 Find Names of All Employees by Last Name
SELECT [FirstName], [LastName]
	FROM [Employees]
	WHERE [LastName] LIKE('%ei%')

--03 Find First Names of All Employess
SELECT [FirstName]
	FROM [Employees]
	WHERE ([DepartmentID] = 3 OR [DepartmentID] = 10) AND YEAR([HireDate]) BETWEEN 1995 AND 2005

--04 Find All Employees Except Engineers
SELECT [FirstName], [LastName]
	FROM [Employees]
	WHERE [JobTitle] NOT LIKE('%engineer%')

--05 Find Towns with Name Length
SELECT [Name]
	FROM [Towns]
	WHERE LEN([Name]) = 5 OR LEN([Name]) = 6
	ORDER BY [Name]

--06 Find Towns Starting With
SELECT *
	FROM [Towns]
	WHERE [Name] LIKE('M%') OR [Name] LIKE('K%') OR [Name] LIKE('B%') OR [Name] LIKE('E%')
	ORDER BY [Name]

--07 Find Towns Not Starting With
SELECT *
	FROM [Towns]
	WHERE [Name] NOT LIKE('R%') AND [Name] NOT LIKE('B%') AND [Name] NOT LIKE('D%')
	ORDER BY [Name]

--08 Create View Employees Hired After
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT [FirstName], [LastName]
	FROM [Employees]
	WHERE YEAR([HireDate]) > 2000

--09 Length of Last Name
SELECT [FirstName], [LastName]
	FROM [Employees]
	WHERE LEN([LastName]) = 5

--10 Rank Employees by Salary
SELECT [EmployeeID], [FirstName], [LastName], [Salary],
	DENSE_RANK() OVER(partition by [Salary] ORDER BY [EmployeeID]) AS [Rank]
	FROM[Employees]
	WHERE [Salary] BETWEEN 10000 AND 50000
	ORDER BY [Salary] DESC

--11 Find All Employees with Rank 2
SELECT *
	FROM (
		SELECT e.[EmployeeID], e.[FirstName],[LastName], [Salary],
		DENSE_RANK() OVER(partition by [Salary] ORDER BY [EmployeeID]) as 'Rank'
		FROM[Employees] AS e
		WHERE [Salary] BETWEEN 10000 AND 50000 ) AS t
	WHERE t.[Rank] = 2
	ORDER BY t.[Salary] DESC

--12 Countries Holding 'A'
SELECT [CountryName], [IsoCode]
	FROM [Countries]
	WHERE UPPER([CountryName]) LIKE('%A%A%A%')
	ORDER BY [IsoCode]

--13 Mix of Peak and River Names
SELECT p.[PeakName], r.[RiverName], LOWER(CONCAT(p.[PeakName], SUBSTRING(r.[RiverName], 2, LEN(r.[RiverName])))) AS [Mix]
	FROM [Peaks] AS p, [Rivers] AS r
	WHERE RIGHT(p.[PeakName], 1) = LEFT(r.[RiverName], 1)
	ORDER BY [Mix]

--14 Games From 2011 and 2012 Year
SELECT TOP(50) [Name], FORMAT([start], 'yyyy-MM-dd') AS 'Start'
	FROM Games
	WHERE YEAR([Start]) BETWEEN 2011 AND 2012
	ORDER BY [Start]

--15 User Email Providers
SELECT [Username], SUBSTRING([Email], CHARINDEX('@', [Email]) + 1, LEN([Email])) AS 'Email Provider'
	FROM [Users]
	ORDER BY [Email Provider], [Username]

--16 Get Users with IPAddress Like Pattern
SELECT [Username], [IpAddress]
	FROM [Users]
	WHERE [IpAddress] LIKE('___.1%.%.___')
	ORDER BY [Username]

--17 Show All Games with Duration
SELECT [Name],
	CASE
		WHEN DATEPART(HOUR, [Start]) >= 0 AND DATEPART(HOUR, [Start])  < 12 THEN 'Morning'
		WHEN DATEPART(HOUR, [Start]) >= 12 AND DATEPART(HOUR, [Start]) < 18 THEN 'Afternoon'
		ELSE 'Evening '
	END AS 'Part of the Day',

	CASE
		WHEN [Duration] <= 3 THEN 'Extra Short'
		WHEN [Duration] BETWEEN 4 AND 6 THEN 'Short'
		WHEN [Duration] > 6 THEN 'Long'
		ELSE 'Extra Long'
	END AS 'Duration'

	FROM [Games]
	ORDER BY [Name], [Duration], [Part of the Day]

--18 Orders Table
SELECT [ProductName], [OrderDate], DATEADD(DAY, 3, [OrderDate]), DATEADD(MONTH, 1, [OrderDate])
	FROM [Orders]