DROP PROCEDURE IF EXISTS create_backup
GO

CREATE PROCEDURE create_backup
(
    @path VARCHAR(256)
)
AS
    BACKUP DATABASE shop_datebase
    TO DISK = @path
GO