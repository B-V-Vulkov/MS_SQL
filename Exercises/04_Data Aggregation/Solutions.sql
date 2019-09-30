--01 Records’ Count
SELECT COUNT(*) AS 'Count'
	FROM [WizzardDeposits]

--02 Longest Magic Wand
SELECT MAX(w.[MagicWandSize]) AS 'LongestMagicWand'
	FROM [WizzardDeposits] AS w

--03 Longest Magic Wand per Deposit Groups
SELECT w.[DepositGroup], MAX(w.[MagicWandSize]) AS 'LongestMagicWand'
	FROM [WizzardDeposits] AS w
	GROUP BY w.[DepositGroup]

--04 Smallest Deposit Group per Magic Wand Size
SELECT TOP(2) w.[DepositGroup]
	FROM [WizzardDeposits] AS w
	GROUP BY w.[DepositGroup]
	ORDER BY AVG(w.[MagicWandSize])

--05 Deposits Sum
SELECT w.[DepositGroup], SUM(w.[DepositAmount]) AS 'TotalSum'
	FROM [WizzardDeposits] AS w
	GROUP BY w.[DepositGroup]

--06 Deposits Sum for Ollivander Family
SELECT w.[DepositGroup], SUM(w.[DepositAmount]) AS 'TotalSum'
	FROM [WizzardDeposits] AS w
	WHERE w.[MagicWandCreator] = 'Ollivander family'
	GROUP BY w.[DepositGroup]

--07 Deposits Filter
SELECT w.[DepositGroup], SUM(w.[DepositAmount]) AS [TotalSum]
	FROM [WizzardDeposits] AS w
	WHERE w.[MagicWandCreator] = 'Ollivander family'
	GROUP BY w.[DepositGroup]
	HAVING SUM(w.[DepositAmount]) < 150000
	ORDER BY [TotalSum] DESC

--08 Deposit Charge
SELECT w.[DepositGroup], w.[MagicWandCreator], MIN(w.[DepositCharge])
	FROM [WizzardDeposits] AS w
	GROUP BY w.[DepositGroup], w.[MagicWandCreator]
	ORDER BY w.[MagicWandCreator]

--09 Age Groups
SELECT ut.[AgeGroup], COUNT(ut.[AgeGroup]) AS [Count]
	FROM (
		SELECT 
			CASE
				WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
				WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
				WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
				WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
				WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
				WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
				ELSE '[61+]'
			END AS [AgeGroup]
			FROM [WizzardDeposits] AS w
	) AS ut
	GROUP BY ut.[AgeGroup]

--10 First Letter
SELECT SUBSTRING(w.[FirstName], 1, 1) AS [FirstLetter]
	FROM [WizzardDeposits] AS w
	WHERE w.[DepositGroup] = 'Troll Chest'
	GROUP BY SUBSTRING(w.[FirstName], 1, 1)
	ORDER BY [FirstLetter]

--11 Average Interest
SELECT w.[DepositGroup], w.[IsDepositExpired], AVG(w.[DepositInterest])
	FROM [WizzardDeposits] AS w
	WHERE w.[DepositStartDate] > '01/01/1985'
	GROUP BY w.[DepositGroup], w.[IsDepositExpired]
	ORDER BY w.[DepositGroup] DESC, w.[IsDepositExpired]

--12 Rich Wizard, Poor Wizard
SELECT SUM(ut.[Difference])
	FROM
		(SELECT 
			w.[FirstName] AS [Host Wizard],
			w.[DepositAmount] AS [Host Wizard Deposit],
			LEAD(w.[FirstName]) OVER(ORDER BY w.[id]) AS [Guest Wizard],
			LEAD(w.[DepositAmount]) OVER(ORDER BY w.[id]) AS [Guest Wizard Deposit],
			w.[DepositAmount] - LEAD(w.[DepositAmount]) OVER(ORDER BY w.[id]) AS [Difference]
		FROM [WizzardDeposits] AS w
		) AS ut

--13 Departments Total Salaries
SELECT e.[DepartmentID], SUM(e.[Salary]) AS [TotalSalary]
	FROM [Employees] AS e
	GROUP BY e.[DepartmentID]
	ORDER BY e.[DepartmentID]

--14 Employees Minimum Salaries
SELECT e.[DepartmentID], MIN(e.[Salary])
	FROM [Employees] AS e
	WHERE e.[HireDate] > '01/01/2000' AND (e.[DepartmentID] = 2 OR e.[DepartmentID] = 5 OR e.[DepartmentID] = 7)
	GROUP BY e.[DepartmentID]

--15 Employees Average Salaries
SELECT *
	INTO [NewEmployees]
	FROM [Employees] AS e
	WHERE e.[Salary] > 30000

DELETE
	FROM [NewEmployees]
	WHERE [ManagerID] = 42

UPDATE [NewEmployees]
	SET [Salary] = [Salary] + 5000
	WHERE [DepartmentID] = 1

SELECT NE.[DepartmentID] ,AVG(ne.[Salary]) [AverageSalary]
	FROM [NewEmployees] AS ne
	GROUP BY ne.[DepartmentID]

--16 Employees Maximum Salaries
SELECT e.[DepartmentID], MAX(e.[Salary]) AS [MaxSalary]
	FROM [Employees] AS e
	GROUP BY E.[DepartmentID]
	HAVING MAX(e.[Salary]) NOT BETWEEN 30000 AND 70000

--17 Employees Count Salaries
SELECT COUNT(*) AS [Count]
	FROM [Employees] AS e
	WHERE e.[ManagerID] IS NULL

--18 3rd Highest Salary
SELECT DISTINCT ut.DepartmentID, ut.[Salary] AS [ThirdHighestSalary]
	FROM(
		SELECT 
			e.[DepartmentID],
			e.[Salary],
			DENSE_RANK() OVER(PARTITION BY e.[DepartmentID] ORDER BY e.[Salary] DESC) AS [Rank]
		FROM [Employees] AS e
	) AS ut
	WHERE ut.[Rank] = 3

--19 Salary Challenge
SELECT TOP(10) e.[FirstName], e.[LastName], e.[DepartmentID]
	FROM [Employees] AS e,
		(
			SELECT e.[DepartmentID], AVG(e.[Salary]) AS [AvgSalary]
				FROM [Employees] AS e
				GROUP BY e.[DepartmentID]
		) AS ut
		WHERE e.DepartmentID = ut.[DepartmentID] AND e.[Salary] > ut.[AvgSalary]
		ORDER BY e.[DepartmentID]
















