--01 Employee Address
SELECT TOP(5) 
		e.[EmployeeID], 
		e.[JobTitle], 
		e.[AddressID], 
		a.[AddressText]
	FROM [Employees] AS e
	JOIN [Addresses] AS a ON e.[AddressID] = a.[AddressID]
	ORDER BY e.[AddressID]

--02 Addresses with Towns
SELECT TOP(50)
		e.[FirstName], 
		e.[LastName], 
		t.[Name] AS [Town], 
		a.[AddressText]
	FROM [Employees] AS e
	JOIN [Addresses] AS a ON e.[AddressID] = a.[AddressID]
	JOIN [Towns] AS t ON a.[TownID] = t.[TownID]
	ORDER BY e.[FirstName], e.[LastName]

--03 Sales Employees
SELECT 
		e.[EmployeeID],
		e.[FirstName],
		e.[LastName],
		d.[Name]
	FROM [Employees] AS e
	JOIN [Departments] AS d ON e.[DepartmentID] = d.[DepartmentID]
	WHERE d.[Name] = 'Sales'
	ORDER BY e.[EmployeeID]

--04 Employee Departments
SELECT TOP(5)
		e.[EmployeeID],
		e.[FirstName],
		e.[Salary],
		d.[Name] AS [DepartmentName]
	FROM [Employees] AS e
	JOIN [Departments] AS d ON e.[DepartmentID] = d.[DepartmentID]
	WHERE e.[Salary] > 15000
	ORDER BY e.[DepartmentID]

--05 Employees Without Projects
SELECT TOP(3)
		e.[EmployeeID],
		e.[FirstName]
	FROM [Employees] AS e
	LEFT JOIN [EmployeesProjects] AS ep ON e.[EmployeeID] = ep.[EmployeeID]
	WHERE ep.[EmployeeID] IS NULL
	ORDER BY e.[EmployeeID]

--06 Employees Hired After
SELECT 
		e.[FirstName],
		e.[LastName],
		e.[HireDate],
		d.[Name] AS [DeptName]
	FROM [Employees] AS e
	JOIN [Departments] AS d ON e.[DepartmentID] = d.[DepartmentID]
	WHERE e.[HireDate] > '1.1.1999' AND (d.[Name] = 'Sales' OR d.[Name] = 'Finance')
	ORDER BY e.[HireDate]

--07 Employees With Project
SELECT TOP(5)
		e.[EmployeeID],
		e.[FirstName],
		p.[Name]
	FROM [Employees] AS e
	JOIN [EmployeesProjects] AS ep ON e.[EmployeeID] = ep.[EmployeeID]
	JOIN [Projects] AS p ON ep.[ProjectID] = p.[ProjectID]
	WHERE p.[StartDate] > CONVERT(DATE, '13.08.2002', 103)
	ORDER BY e.[EmployeeID]

--08 Employee 24
SELECT 
		e.[EmployeeID],
		e.[FirstName],
		CASE
			WHEN YEAR(p.StartDate) >= 2005 THEN NULL
			ELSE p.[Name]
		END AS [ProjectName]
	FROM [Employees] AS e
	JOIN [EmployeesProjects] AS ep ON e.[EmployeeID] = ep.[EmployeeID]
	JOIN [Projects] AS p ON ep.[ProjectID] = p.[ProjectID]
	WHERE e.[EmployeeID] = 24

--09 Employee Manager
SELECT 
		e.[EmployeeID],
		e.[FirstName],
		e.[ManagerID],
		ee.[FirstName]
	FROM [Employees] AS e
	JOIN [Employees] AS ee ON e.ManagerID = ee.[EmployeeID]
	WHERE e.[ManagerID] = 3 OR e.[ManagerID] = 7
	ORDER BY e.[EmployeeID]

--10 Employee Summary
SELECT TOP(50)
		e.[EmployeeID],
		CONCAT(e.[FirstName], ' ', e.[LastName]) AS [EmployeeName],
		CONCAT(ee.[FirstName], ' ', ee.[LastName]) AS [ManagerName],
		d.[Name] AS [DepartmentName]
	FROM [Employees] AS e
	JOIN [Employees] AS ee ON e.[ManagerID] = ee.[EmployeeID]
	JOIN [Departments] AS d ON e.[DepartmentID] = d.[DepartmentID]
	ORDER BY e.[EmployeeID]

--11 Min Average Salary
SELECT TOP(1)
		AVG(e.[salary]) AS [MinAverageSalary]
	FROM [Employees] AS e
	GROUP BY e.[DepartmentID]
	ORDER BY [MinAverageSalary]

--12 Highest Peaks in Bulgaria
SELECT 
		mc.[CountryCode],
		m.[MountainRange],
		p.[PeakName],
		p.[Elevation]
	FROM [MountainsCountries] AS mc
	JOIN [Mountains] AS m ON mc.[MountainId] = m.[Id]
	JOIN [Peaks] AS p ON m.[Id] = p.[MountainId]
	WHERE mc.[CountryCode] = 'BG' AND p.[Elevation] > 2835
	ORDER BY p.[Elevation] DESC

--13 Count Mountain Ranges
SELECT 
		mc.[CountryCode],
		COUNT(*) AS [MountainRanges]
	FROM [MountainsCountries] AS mc
	JOIN [Mountains] AS m ON mc.[MountainId] = m.[Id]
	WHERE mc.[CountryCode] = 'BG' OR mc.[CountryCode] = 'RU' OR mc.[CountryCode] = 'US'
	GROUP BY mc.[CountryCode]

--14 Countries with Rivers
SELECT TOP(5)
		c.[CountryName],
		r.[RiverName]
	FROM [Countries] AS c
	LEFT JOIN [CountriesRivers] AS cr ON c.[CountryCode] = cr.[CountryCode]
	LEFT JOIN [Rivers] AS r ON cr.[RiverId] = r.[Id]
	WHERE c.[ContinentCode] = 'AF'
	ORDER BY c.[CountryName]

--15 Continents and Currencies
SELECT c.[CountryName],
	DENSE_RANK() OVER(PARTITION BY c.[ContinentCode] ORDER BY C.[CurrencyCode])
	FROM [Countries] AS c

SELECT c.[ContinentCode],

	FROM [Countries] AS c
	GROUP BY c.[ContinentCode]




