--Secttion 02
--02 Insert
INSERT INTO [Files] VALUES('Trade.idk', 2598.0, 1, 1)
INSERT INTO [Files] VALUES('menu.net', 9238.31, 2, 2)
INSERT INTO [Files] VALUES('Administrate.soshy', 1246.93, 3, 3)
INSERT INTO [Files] VALUES('Controller.php', 7353.15, 4, 4)
INSERT INTO [Files] VALUES('Find.java', 9957.86, 5, 5)
INSERT INTO [Files] VALUES('Controller.json', 14034.87, 3, 6)
INSERT INTO [Files] VALUES('Operate.xix', 7662.92, 7, 7)

INSERT INTO [Issues] VALUES('Critical Problem with HomeController.cs file', 'open', 1, 4)
INSERT INTO [Issues] VALUES('Typo fix in Judge.html', 'open', 4, 3)
INSERT INTO [Issues] VALUES('Implement documentation for UsersService.cs', 'closed', 8, 2)
INSERT INTO [Issues] VALUES('Unreachable code in Index.cs', 'open', 9, 8)

--03 Update
UPDATE [Issues]
SET [IssueStatus] = 'closed'
WHERE [AssigneeId] = 6

--04 Delete
DELETE FROM [RepositoriesContributors]
	WHERE [RepositoryId] = 
	(
		SELECT r.[Id]
		FROM [Repositories] AS r
		WHERE r.[Name] = 'Softuni-Teamwork'
	)

DELETE FROM [Issues]
	WHERE [RepositoryId] = 
	(
		SELECT r.[Id]
		FROM [Repositories] AS r
		WHERE r.[Name] = 'Softuni-Teamwork'
	)
