DROP PROCEDURE IF EXISTS register_client
GO

CREATE PROCEDURE register_client
(
    @name VARCHAR(64),
    @surname VARCHAR(64),
    @email VARCHAR(64),
    @password VARCHAR(64),
    @register_date DATETIME,
    @policy_accepted BIT
)
AS
BEGIN
    IF @policy_accepted = 1
    BEGIN
        INSERT INTO [User] (name, surname, email, password)
        VALUES (@name, @surname, @email, @password)

        INSERT INTO Client (user_id, register_date, policy_accepted)
        VALUES (@@IDENTITY, @register_date, @policy_accepted)
    END
    ELSE
    BEGIN
       RAISERROR('Policy not accepted', 16, 1)
    END
END
GO
