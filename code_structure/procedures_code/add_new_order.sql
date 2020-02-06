DROP PROCEDURE IF EXISTS add_new_order
GO

CREATE PROCEDURE add_new_order
(
    @client_id INTEGER,
    @note VARCHAR(512)
)
AS
BEGIN
    DECLARE @date DATETIME
    SET @date = GETDATE()
    INSERT INTO [Order]
    VALUES (@date, NULL, @client_id)
    IF @@ERROR <> 0
    BEGIN
        RAISERROR('Adding new order failed.', 1, 1)
    END
    INSERT INTO OrderHistory
    VALUES ('Started', @date, @note, @@IDENTITY)
    IF @@ERROR <> 0
    BEGIN
        RAISERROR('Adding new record to order history', 1, 1)
    END
END
RETURN
GO