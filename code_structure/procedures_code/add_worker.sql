DROP PROCEDURE IF EXISTS add_worker
GO

CREATE PROCEDURE add_worker
(
    @name VARCHAR(64),
    @surname VARCHAR(64),
    @email VARCHAR(64),
    @password VARCHAR(64),
    @salary MONEY,
    @employed_since DATETIME,
    @position VARCHAR(64)
)
AS
BEGIN
    INSERT INTO [User] (name, surname, email, password)
    VALUES (@name, @surname, @email, @password)

    INSERT INTO Worker (user_id, salary, employed_since, position)
    VALUES (@@IDENTITY, @salary, @employed_since, @position)
END
GO
