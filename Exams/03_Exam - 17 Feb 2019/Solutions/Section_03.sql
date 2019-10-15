--Section 03
--05 Teen Students
SELECT 
		s.[FirstName],
		s.[LastName],
		s.[Age]
	FROM [Students] AS s
	WHERE S.[Age] >= 12
	ORDER BY s.[FirstName], s.[LastName]

--06 Cool Addresses
SELECT 
		CONCAT(s.[FirstName], ' ', s.[MiddleName], ' ', s.[LastName]) AS [Full Name],
		s.[Address]
	FROM [Students] AS s
	WHERE s.[Address] LIKE('%road%')
	ORDER BY s.[FirstName], s.[LastName], s.[Address]

--07 42 Phones
SELECT 
		s.[FirstName],
		s.[Address],
		s.[Phone]
	FROM [Students] AS s
	WHERE s.[Phone] LIKE('42%') AND s.[MiddleName] IS NOT NULL
	ORDER BY s.[FirstName], s.[Address], s.[Phone]

--08 Students Teachers
SELECT 
		s.[FirstName],
		s.[LastName],
		COUNT(s.[Id]) AS [TeachersCount]
	FROM [Students] AS s
	JOIN [StudentsTeachers] AS st ON s.[Id] = st.[StudentId]
	GROUP BY s.[FirstName], s.[LastName]
	ORDER BY s.[LastName]

--09 Subjects with Students
SELECT 
		CONCAT(t.[FirstName], ' ', t.[LastName]) AS [FullName],
		CONCAT(s.[Name], '-', s.[Lessons]) AS [Subjects],
		COUNT(t.[Id]) AS [Students]
	FROM [Subjects] AS s
	JOIN [Teachers] AS t ON s.[Id] = t.[SubjectId]
	JOIN [StudentsTeachers] AS st ON t.[Id] = st.[TeacherId]
	GROUP BY t.[FirstName], t.[LastName], s.[Name], s.[Lessons]
	ORDER BY [Students] DESC, [FullName], [Subjects]

--10 Students to Go
SELECT
		CONCAT(s.[FirstName], ' ', s.[LastName]) AS [Full Name]
	FROM [Students] AS s
	LEFT JOIN [StudentsExams] AS se ON s.[Id] = se.[StudentId]
	WHERE se.[StudentId] IS NULL
	ORDER BY [Full Name]

--11 Busiest Teachers
SELECT TOP(10)
		t.[FirstName],
		t.[LastName],
		COUNT(t.[Id]) AS [StudentsCount]
	FROM [Subjects] AS s
	JOIN [Teachers] AS t ON s.[Id] = t.[SubjectId]
	JOIN [StudentsTeachers] AS st ON t.[Id] = st.[TeacherId]
	GROUP BY t.[FirstName], t.[LastName], s.[Name], s.[Lessons]
	ORDER BY [StudentsCount] DESC, t.[FirstName], t.[LastName]

--12 Top Students
SELECT TOP(10)
		s.[FirstName],
		s.[LastName],
		CONVERT(DECIMAL(3,2), AVG(se.[Grade])) AS [Grade]
	FROM [Students] AS s
	JOIN [StudentsExams] AS se ON s.[Id] = se.[StudentId]
	GROUP BY s.[FirstName], s.[LastName]
	ORDER BY [Grade] DESC, s.[FirstName], s.[LastName]

--13 Second Highest Grade
SELECT DISTINCT
		ut.[FirstName],
		ut.[LastName],
		ut.[Grade]
	FROM(SELECT 
			s.[FirstName],
			s.[LastName],
			ss.[Grade],
			ROW_NUMBER() OVER(PARTITION BY s.[Id] ORDER BY ss.[Grade] DESC) AS [Rank]
		FROM [Students] AS s
		JOIN [StudentsSubjects] AS ss ON s.[Id] = ss.[StudentId]) AS ut
	WHERE ut.[Rank] = 2
	ORDER BY ut.[FirstName], ut.[LastName]

--14 Not So In The Studying
SELECT 
	(CASE
		WHEN s.[MiddleName] IS NOT NULL THEN 
			CONCAT(s.[FirstName], ' ', s.[MiddleName], ' ', s.[LastName])
		ELSE CONCAT(s.[FirstName], ' ', s.[LastName])
	END) AS [Full Name]
	FROM [Students] AS s
	LEFT JOIN [StudentsSubjects] AS ss ON s.[Id] = ss.[StudentId]
	WHERE ss.[Id] IS NULL
	ORDER BY [Full Name]

--15 Top Student per Teacher
SELECT 
		ut2.[Teacher Full Name],
		ut2.[Subject Name],
		ut2.[Student Full Name],
		FORMAT(ut2.[AVG Grade], 'N2') AS [Grade]
	FROM(
		SELECT 
			ut1.[Teacher Full Name],
			ut1.[Subject Name],
			ut1.[Student Full Name],
			ut1.[AVG Grade],
			ROW_NUMBER() OVER(PARTITION BY ut1.[Teacher Full Name]
				ORDER BY ut1.[AVG Grade] DESC) AS [Row]
		FROM(
			SELECT
					CONCAT(t.[FirstName], ' ', t.[LastName]) AS [Teacher Full Name],
					su.[Name] AS [Subject Name],
					CONCAT(s.[FirstName], ' ', s.[LastName]) AS [Student Full Name],
					AVG(ss.[Grade]) AS [AVG Grade]
				FROM [Teachers] AS t 
				JOIN [StudentsTeachers] AS st ON st.[TeacherId] = t.[Id]
				JOIN [Students] AS s ON s.Id = st.[StudentId]
				JOIN [StudentsSubjects] AS ss ON ss.[StudentId] = s.[Id]
				JOIN [Subjects] AS su ON su.Id = ss.[SubjectId] AND su.[Id] = t.[SubjectId]
				GROUP BY t.[FirstName], t.[LastName], su.[Name], s.[FirstName], s.[LastName]) AS ut1) as ut2
	WHERE ut2.[Row] = 1
	ORDER BY ut2.[Subject Name], ut2.[Teacher Full Name], [Grade] DESC

--16 Average Grade per Subject
SELECT 
		s.[Name],
		AVG(ss.[Grade]) AS [AverageGrade]
	FROM [Subjects] AS s
	JOIN [StudentsSubjects] AS ss ON s.[Id] = ss.[SubjectId]
	GROUP BY s.[Name], s.[Id]
	ORDER BY s.[Id]
	
--17 Exams Information
SELECT 
		ut.[Quarter],
		ut.[SubjectName],
		COUNT(ut.[StudentId]) AS [StudentsCount]
	FROM (
	SELECT
		CASE
			WHEN e.[Date] IS NULL THEN 'TBA'
			WHEN MONTH(E.[Date]) BETWEEN 1 AND 3 THEN 'Q1'
			WHEN MONTH(E.[Date]) BETWEEN 4 AND 6 THEN 'Q2'
			WHEN MONTH(E.[Date]) BETWEEN 7 AND 9 THEN 'Q3'
			WHEN MONTH(E.[Date]) BETWEEN 10 AND 12 THEN 'Q4'
		END AS [Quarter],
		s.[Name] AS [SubjectName],
		se.[StudentId]
		FROM [Subjects] AS s
		JOIN [Exams] AS e ON s.[Id] = e.[SubjectId]
		JOIN [StudentsExams] AS se ON e.[Id] = se.[ExamId]
		WHERE se.[Grade] >= 4) AS ut
	GROUP BY ut.[Quarter], ut.[SubjectName]
	ORDER BY [Quarter]