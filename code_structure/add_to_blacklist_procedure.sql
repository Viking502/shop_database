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
            RAISERROR('Dodanie nowego rekordu do czarnej listy nie powiodło się.', 1, 1)
        END
    END
RETURN