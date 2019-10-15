--Section 04
--18 Exam Grades
CREATE FUNCTION udf_ExamGradesToUpdate(
	@studentId INT,
	@grade DECIMAL(3, 2)
)
RETURNS NVARCHAR(100)
AS
BEGIN
	DECLARE @studentIsExist BIT;
	SET @studentIsExist = (
		SELECT COUNT(*)
		FROM [Students] AS s
		WHERE s.[Id] = @studentId);

	IF(@studentIsExist = 0)
	BEGIN
		RETURN 'The student with provided id does not exist in the school!'
	END

	IF(@grade > 6)
	BEGIN
		RETURN 'Grade cannot be above 6.00!'
	END

	DECLARE @count INT;
	DECLARE @studentName NVARCHAR(30);
	SET @count = (
		SELECT COUNT(*)
		FROM [Students] AS s
		JOIN [StudentsExams] AS se ON s.[Id] = se.[StudentId]
		WHERE s.[Id] = @studentId AND se.[Grade] BETWEEN @grade AND @grade + 0.5);

	SET @studentName = (
		SELECT S.[FirstName]
		FROM [Students] AS s
		WHERE s.[Id] = @studentId )

	RETURN CONCAT('You have to update ', @count, ' grades for the student ', @studentName);
END
GO

--19 Exclude From School
CREATE PROCEDURE usp_ExcludeFromSchool(@StudentId INT)
AS
BEGIN
	DECLARE @TargetStudentId INT = (SELECT Id FROM Students WHERE Id = @StudentId)

	IF (@TargetStudentId IS NULL)
	BEGIN
		RAISERROR('This school has no student with the provided id!', 16, 1)
		RETURN
	END


	DELETE FROM [StudentsExams]
	WHERE [StudentId] = @StudentId;

	DELETE FROM [StudentsTeachers]
	WHERE [StudentId] = @StudentId;

	DELETE FROM [StudentsSubjects]
	WHERE [StudentId] = @StudentId;

	DELETE FROM [Students]
	WHERE [Id] = @StudentId;
END
GO

--20 Deleted Students
CREATE TABLE [ExcludedStudents](
	[StudentId]		INT NOT NULL,
	[StudentName]	NVARCHAR(30) NOT NULL,
	CONSTRAINT PK_ExcludedStudents
	PRIMARY KEY([StudentId])
)
GO

CREATE TRIGGER tr_onExcludedStudents ON [Students] FOR DELETE
AS
BEGIN
	INSERT INTO [ExcludedStudents]
	SELECT d.[Id], CONCAT(d.[FirstName], ' ', D.[LastName])
	FROM [deleted] AS d
END