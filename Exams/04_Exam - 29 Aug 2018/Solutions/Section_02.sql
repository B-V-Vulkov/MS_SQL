--Section 02
--02 Insert

INSERT INTO [Employees] 
VALUES('Stoyan', 'Petrov', '888-785-8573', 500.25)

INSERT INTO [Employees] 
VALUES('Stamat', 'Nikolov', '789-613-1122', 999995.25)

INSERT INTO [Employees] 
VALUES('Evgeni', 'Petkov', '645-369-9517', 1234.51)

INSERT INTO [Employees] 
VALUES('Krasimir', 'Vidolov', '321-471-9982', 50.25)

INSERT INTO [Items] 
VALUES('Tesla battery', 154.25, 8)

INSERT INTO [Items] 
VALUES('Chess', 30.25, 8)

INSERT INTO [Items] 
VALUES('Juice', 5.32, 1)

INSERT INTO [Items] 
VALUES('Glasses', 10, 8)

INSERT INTO [Items] 
VALUES('Bottle of water', 1, 1)

--03 Update
UPDATE [Items]
SET [Price] = [Price] + [Price] * 0.27
WHERE [CategoryId] BETWEEN 1 AND 3

--04 Delete
DELETE FROM [OrderItems]
WHERE [OrderId] = 48

DELETE FROM [Orders]
WHERE [Id] = 48