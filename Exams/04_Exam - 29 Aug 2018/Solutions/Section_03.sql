--Section 03
--05 Richest People
SELECT
		e.[Id],
		e.[FirstName]
	FROM [Employees] AS e
	WHERE e.[Salary] > 6500
	ORDER BY e.[FirstName], e.[Id]

--06 Cool Phone Numbers
SELECT
		CONCAT(E.[FirstName], ' ', e.[LastName]) AS [Full Name],
		e.[Phone] AS [Phone Number]
	FROM [Employees] AS e
	WHERE e.[Phone] LIKE('3%')
	ORDER BY e.[FirstName], e.[Phone]

--07 Employee Statistics
SELECT
		e.[FirstName],
		e.[LastName],
		COUNT(e.[Id]) AS [Count]
	FROM [Employees] AS e
	JOIN [Orders] AS o ON e.[Id] = o.[EmployeeId]
	GROUP BY e.[FirstName], e.[LastName]
	ORDER BY [Count] DESC, e.[FirstName]

--08 Hard Workers Club
SELECT
		e.[FirstName],
		e.[LastName],
		AVG(DATEDIFF(HOUR, s.[CheckIn], s.[CheckOut])) AS [Work hours]
	FROM [Employees] AS e
	JOIN [Shifts] AS s ON e.[Id] = s.[EmployeeId]
	GROUP BY e.[FirstName], e.[LastName], e.[Id]
	HAVING AVG(DATEDIFF(HOUR, s.[CheckIn], s.[CheckOut])) > 7
	ORDER BY [Work hours] DESC, e.[Id]

--09 The Most Expensive Order
SELECT TOP(1)
		ut.[OrderId],
		SUM(ut.[Price]) AS [TotalPrice]
FROM(
	SELECT
			oi.[OrderId],
			(oi.[Quantity] * i.[Price]) AS [Price]
		FROM [OrderItems] AS oi
		JOIN [Items] AS i ON oi.ItemId = i.[Id]
	) AS ut
	GROUP BY ut.[OrderId]
	ORDER BY [TotalPrice] DESC
	
--10 Rich Item, Poor Item
SELECT TOP(10)
		oi.[OrderId],
		MAX(i.[Price]) AS [ExpensivePrice],
		MIN(i.[Price]) AS [CheapPrice]
	FROM [OrderItems] AS oi
	JOIN [Items] AS i ON oi.[ItemId] = i.[Id]
	GROUP BY oi.[OrderId]
	ORDER BY [ExpensivePrice] DESC, oi.[OrderId]

--11 Cashiers
SELECT DISTINCT
		e.[Id],
		e.[FirstName],
		e.[LastName]
	FROM [Employees] AS e
	JOIN [Orders] AS o ON e.[Id] = o.[EmployeeId]
	ORDER BY e.[Id]

--12 Lazy Employees
SELECT DISTINCT
		e.[Id],
		CONCAT(e.[FirstName], ' ', e.[LastName]) AS [Full Name]
	FROM [Employees] AS e
	JOIN [Shifts] AS s ON e.[Id] =s.[EmployeeId]
	WHERE DATEDIFF(HOUR, s.[CheckIn], s.[CheckOut]) < 4
	ORDER BY e.[Id]

--13 Sellers
SELECT TOP(10)
		CONCAT(e.[FirstName], ' ', e.[LastName]) AS [Full Name],
		SUM(i.[Price] * oi.[Quantity]) AS [Total Price],
		SUM(oi.[Quantity]) AS [Items]
	FROM [Employees] AS e
	JOIN [Orders] AS o ON e.[Id] = o.[EmployeeId]
	JOIN [OrderItems] AS oi ON o.[Id] = oi.[OrderId]
	JOIN [Items] AS i ON oi.[ItemId] = i.[Id]
	WHERE o.[DateTime] < '2018-06-15'
	GROUP BY e.[FirstName], e.[LastName]
	ORDER BY [Total Price] DESC, [Items] DESC

--14 Tough Days
SELECT
		CONCAT(e.[FirstName], ' ', e.[LastName]) AS [Full Name],
		FORMAT(s.[CheckIn], 'dddd') AS [Day of week]
	FROM [Employees] AS e
	LEFT JOIN [Orders] AS o ON e.[Id] = o.[EmployeeId]
	JOIN [Shifts] AS s ON e.[Id] = s.[EmployeeId]
	WHERE o.[Id] IS NULL AND DATEDIFF(HOUR, s.[CheckIn], s.[CheckOut]) > 12
	ORDER BY e.[Id]

--15 Top Order per Employee
SELECT emp.FirstName + ' ' + emp.LastName AS FullName, DATEDIFF(HOUR, s.CheckIn, s.CheckOut) AS WorkHours, e.TotalPrice AS TotalPrice FROM 
 (
    SELECT o.EmployeeId, SUM(oi.Quantity * i.Price) AS TotalPrice, o.DateTime,
	ROW_NUMBER() OVER (PARTITION BY o.EmployeeId ORDER BY o.EmployeeId, SUM(i.Price * oi.Quantity) DESC ) AS Rank
    FROM Orders AS o
    JOIN OrderItems AS oi ON oi.OrderId = o.Id
    JOIN Items AS i ON i.Id = oi.ItemId
GROUP BY o.EmployeeId, o.Id, o.DateTime
) AS e 
JOIN Employees AS emp ON emp.Id = e.EmployeeId
JOIN Shifts AS s ON s.EmployeeId = e.EmployeeId
WHERE e.Rank = 1 AND e.DateTime BETWEEN s.CheckIn AND s.CheckOut
ORDER BY FullName, WorkHours DESC, TotalPrice DESC

--16 Average profit per day
SELECT
DATEPART(DAY, o.DateTime)  AS [DayOfMonth],
CAST(AVG(i.Price * oi.Quantity)  AS decimal(15, 2)) AS TotalPrice
FROM Orders AS o
JOIN OrderItems AS oi ON oi.OrderId = o.Id
JOIN Items AS i ON i.Id = oi.ItemId
GROUP BY DATEPART(DAY, o.DateTime)
ORDER BY DayOfMonth ASC

--17 Top Products
SELECT
  i.Name,
  c.Name,
  SUM(oi.Quantity)  As [Count],
  SUM(i.Price * oi.Quantity) AS TotalPrice
FROM Orders AS o
  JOIN OrderItems AS oi ON oi.OrderId = o.Id
  RIGHT JOIN Items AS i ON i.Id = oi.ItemId
  JOIN Categories AS c ON c.Id = i.CategoryId
GROUP BY i.Name, c.Name
ORDER BY TotalPrice DESC, [Count] DESC