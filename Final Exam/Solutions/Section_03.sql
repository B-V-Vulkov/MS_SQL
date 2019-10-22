--Section 03
--05 Unassigned Reports
SELECT
		r.[Description],
		FORMAT(r.[OpenDate], 'dd-MM-yyyy') AS [OpenDate]
	FROM [Reports] AS r
	WHERE r.[EmployeeId] IS NULL
	ORDER BY r.[OpenDate], r.[Description]

--06 Reports & Categories
SELECT
		r.[Description],
		c.[Name]
	FROM [Reports] AS r
	JOIN [Categories] AS c ON r.[CategoryId] = c.[Id]
	ORDER BY r.[Description], c.[Name]

--07 Most Reported Category
SELECT TOP(5)
		c.[Name] AS [CategoryName],
		COUNT(c.[Id]) AS [ReportsNumber]
	FROM [Categories] AS c
	JOIN [Reports] AS r ON c.[Id] = r.[CategoryId]
	GROUP BY c.[Name]
	ORDER BY [ReportsNumber] DESC, [CategoryName]

--08 Birthday Report
SELECT
		u.[Username],
		c.[Name] AS [CategoryName]
	FROM [Users] AS u
	JOIN [Reports] AS r ON u.[Id] = r.[UserId]
	JOIN [Categories] AS c ON r.[CategoryId] = c.[Id]
	WHERE MONTH(u.[Birthdate]) = MONTH(r.[OpenDate]) AND 
		DAY(u.[Birthdate]) = DAY(r.[OpenDate])
	ORDER BY u.[Username], c.[Name]
	
--09 User per Employee
SELECT
		CONCAT(e.[FirstName], ' ', e.[LastName]) AS [FullName],
		COUNT(r.[UserId]) AS [UsersCount]
	FROM [Employees] AS e
	LEFT JOIN [Reports] AS r ON e.[Id] = r.[EmployeeId]
	GROUP BY e.[FirstName], e.[LastName]
	ORDER BY [UsersCount] DESC, [FullName]
	
--10 Full Info
SELECT
		CASE
			WHEN e.[FirstName] IS NULL THEN 'None'
			ELSE CONCAT(e.[FirstName], ' ', e.[LastName])
		END AS [Employee],
		
		CASE
			WHEN d.[Name] IS NULL THEN 'None'
			ELSE d.[Name]
		END AS [Department],

		c.[Name] AS [Category],
		r.[Description],
		FORMAT(r.[OpenDate], 'dd.MM.yyyy') AS [OpenDate],
		s.[Label] AS [Status],
		u.[Name] AS [User]
	FROM [Reports] AS r
	left JOIN [Employees] AS e ON r.[EmployeeId] = e.[Id]
	left JOIN [Departments] AS d ON e.[DepartmentId] = d.[Id]
	left JOIN [Categories] AS c ON r.[CategoryId] = c.[Id]
	JOIN [Status] AS s ON r.[StatusId] = s.[Id]
	left JOIN [Users] AS u ON r.[UserId] = u.[Id]
	ORDER BY e.[FirstName] DESC, e.[LastName] DESC, [Department],
		[Category], r.[Description], [OpenDate], [Status], [User]