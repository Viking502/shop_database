DROP PROCEDURE IF EXISTS change_order_status
GO

CREATE PROCEDURE change_order_status
(
    @id INTEGER,
    @status VARCHAR(64),
    @note VARCHAR(256)
)
AS
BEGIN
    INSERT INTO OrderHistory
    VALUES (@status, GETDATE(), @note, @id)
END
GO
