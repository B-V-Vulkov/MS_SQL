--05 Commits
SELECT 
		c.[Id],
		c.[Message],
		c.[RepositoryId],
		c.[ContributorId]
	FROM [Commits] AS c
	ORDER BY c.[Id], c.[Message], c.[RepositoryId], c.[ContributorId]

--06 Heavy HTML
SELECT 
		f.[Id],
		f.[Name],
		f.[Size]
	FROM [Files] AS f
	WHERE f.[Size] > 1000 AND RIGHT(f.[Name], 4) = 'html'
	ORDER BY f.[Size] DESC, f.[Id], f.[Name]

--07 Issues and Users
SELECT 
		i.[Id],
		CONCAT(u.[Username], ' : ', i.[Title]) AS [IssueAssignee]
	FROM [Issues] AS i
	JOIN [Users] AS u ON i.[AssigneeId] = u.[Id]
	ORDER BY i.[Id] DESC, i.[AssigneeId]

--08 Non-Directory Files
SELECT 
		f.[Id],
		f.[Name],
		CONCAT(f.[Size], 'KB') AS [Size]
	FROM [Files] AS f
	LEFT JOIN [Files] AS ff ON f.[Id] = ff.[ParentId]
	WHERE ff.[ParentId] IS NULL
	ORDER BY f.[Id], f.[Name], f.[Size]
	
--09 Most Contributed Repositories

--10 User and Files
SELECT 
		u.[Username], 
		AVG(f.Size) AS [Size]
	FROM [Users] AS u
	JOIN [Commits] AS c ON u.[Id] = c.[ContributorId]
	JOIN [Files] AS f ON c.[Id] = f.[CommitId]
	GROUP BY u.[Username]
	ORDER BY [Size] DESC, u.[Username]