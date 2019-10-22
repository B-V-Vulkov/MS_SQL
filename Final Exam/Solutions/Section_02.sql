--Section 02
--02 Insert
INSERT INTO [Employees]([FirstName], [LastName], [Birthdate], [DepartmentId])
VALUES('Marlo', 'O''Malley', '1958-9-21', 1)

INSERT INTO [Employees]([FirstName], [LastName], [Birthdate], [DepartmentId])
VALUES('Niki', 'Stanaghan', '1969-11-26', 4)

INSERT INTO [Employees]([FirstName], [LastName], [Birthdate], [DepartmentId])
VALUES('Ayrton', 'Senna', '1960-03-21', 9)

INSERT INTO [Employees]([FirstName], [LastName], [Birthdate], [DepartmentId])
VALUES('Ronnie', 'Peterson', '1944-02-14', 9)

INSERT INTO [Employees]([FirstName], [LastName], [Birthdate], [DepartmentId])
VALUES('Giovanna', 'Amati', '1959-07-20', 9)

INSERT INTO [Reports]([CategoryId], [StatusId], [OpenDate], [CloseDate], [Description], [UserId], [EmployeeId])
VALUES(1, 1, '2017-04-13', NULL, 'Stuck Road on Str.133', 6, 2)

INSERT INTO [Reports]([CategoryId], [StatusId], [OpenDate], [CloseDate], [Description], [UserId], [EmployeeId])
VALUES(6, 3, '2015-09-05', '2015-12-06', 'Charity trail running', 3, 5)

INSERT INTO [Reports]([CategoryId], [StatusId], [OpenDate], [CloseDate], [Description], [UserId], [EmployeeId])
VALUES(14, 2, '2015-09-07', NULL, 'Falling bricks on Str.58', 5, 2)

INSERT INTO [Reports]([CategoryId], [StatusId], [OpenDate], [CloseDate], [Description], [UserId], [EmployeeId])
VALUES(4, 3, '2017-07-03', '2017-07-06', 'Cut off streetlight on Str.11', 1, 1)

--03 Update
UPDATE [Reports]
SET [CloseDate] = GETDATE()
WHERE [CloseDate] IS NULL

--04 Delete
DELETE FROM [Reports]
WHERE [StatusId] = 4