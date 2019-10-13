--11 User Total Commits
CREATE FUNCTION udf_UserTotalCommits(@username NVARCHAR(MAX))
RETURNS INT
AS
BEGIN
DECLARE @count INT;
SET @count = (SELECT COUNT(u.[Id]) AS [User Total Commits]
	FROM [Users] AS u
	JOIN [Commits] AS c ON u.[Id] = c.[ContributorId]
	WHERE u.[Username] = @username)
RETURN @count;
END
GO

--12 Find by Extensions
CREATE PROCEDURE usp_FindByExtension(@extension NVARCHAR(MAX))
AS
BEGIN
SELECT 
		f.[Id],
		f.[Name],
		CONCAT(f.[Size], 'KB') AS [Size]
	FROM [Files] AS f
	WHERE f.[Name] LIKE(CONCAT('%', @extension, '%'))
	ORDER BY f.[Id], f.[Name], f.[Size]
END