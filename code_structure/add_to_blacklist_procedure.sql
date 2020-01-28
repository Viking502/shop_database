CREATE PROCEDURE AddToBlacklist
(
    @IpAddress VARCHAR(32),
    @Note VARCHAR(512)
)
AS
    IF @IpAddress <> ''
    BEGIN
        INSERT INTO Blacklist
        VALUES (@IpAddress, @Note)
        IF @@ERROR <> 0
        BEGIN
            RAISERROR('Adding new record to BlackList failed.', 1, 1)
        END
    END
RETURN