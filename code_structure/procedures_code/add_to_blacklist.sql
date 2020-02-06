DROP PROCEDURE IF EXISTS add_to_blacklist
GO

CREATE PROCEDURE add_to_blacklist
(
    @ip_address VARCHAR(32),
    @note VARCHAR(512)
)
AS
    IF @ip_address <> ''
    BEGIN
        INSERT INTO Blacklist
        VALUES (@ip_address, @note)
        IF @@ERROR <> 0
        BEGIN
            RAISERROR('Adding new record to BlackList failed.', 1, 1)
        END
    END
RETURN
GO