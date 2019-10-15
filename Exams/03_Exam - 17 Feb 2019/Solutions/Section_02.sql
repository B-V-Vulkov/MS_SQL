--Section 02
--02 Insert
INSERT INTO [Teachers] 
VALUES('Ruthanne', 'Bamb', '84948 Mesta Junction', '3105500146', 6)

INSERT INTO [Teachers] 
VALUES('Gerrard', 'Lowin', '370 Talisman Plaza', '3324874824', 2)

INSERT INTO [Teachers] 
VALUES('Merrile', 'Lambdin', '81 Dahle Plaza', '4373065154', 5)

INSERT INTO [Teachers] 
VALUES('Bert', 'Ivie', '2 Gateway Circle', '4409584510', 4)

INSERT INTO [Subjects] VALUES('Geometry', 12)
INSERT INTO [Subjects] VALUES('Health', 10)
INSERT INTO [Subjects] VALUES('Drama', 7)
INSERT INTO [Subjects] VALUES('Sports', 9)

--03 Update
UPDATE [StudentsSubjects]
	SET [Grade] = 6.00
	WHERE [SubjectId] BETWEEN 1 AND 2 AND [Grade] >= 5.5

--04 Delete
DELETE FROM [StudentsTeachers]
	WHERE [TeacherId] IN (
		SELECT t.[Id]
		FROM [Teachers] AS t
		WHERE t.[Phone] LIKE('%72%'))

DELETE FROM [Teachers]
	WHERE [Phone] LIKE('%72%')