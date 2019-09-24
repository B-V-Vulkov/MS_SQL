--02 Find All Information About Departments
SELECT *
	FROM [Departments]

--03 Find all Department Names
SELECT [Name]
	FROM [Departments]

--04 Find Salary of Each Employee
SELECT [FirstName], [LastName], [Salary]
	FROM [Employees]

--05 Find Full Name of Each Employee
SELECT [FirstName], [MiddleName], [LastName]
	FROM [Employees]

--06 Find Email Address of Each Employee
SELECT ([FirstName] + '.' + [LastName] + '@softuni.bg') AS [Full Email Address]
	FROM [Employees]

--07 Find All Different Employee�s Salaries
SELECT DISTINCT([Salary])
	FROM [Employees]

--08 Find all Information About Employees
SELECT *
	FROM [Employees]
	WHERE [JobTitle] = 'Sales Representative'