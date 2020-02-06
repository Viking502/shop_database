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
    DECLARE @last_status_id INTEGER
    SET @last_status_id = (SELECT OrderHistory.id
        FROM OrderHistory
        WHERE order_id = @id AND id = (SELECT MAX(id) FROM OrderHistory
                                        WHERE order_id = @id GROUP BY order_id)
        GROUP BY OrderHistory.id)
    DECLARE @last_status VARCHAR(64)
    SET @last_status = (SELECT status FROM OrderHistory WHERE id = @last_status_id)
    IF @last_status != @status
    BEGIN
        INSERT INTO OrderHistory
        VALUES (@status, GETDATE(), @note, @id)
    END
    ELSE
    BEGIN
        RAISERROR('Status cannot be updated', 1, 1)
    END
END
GO
