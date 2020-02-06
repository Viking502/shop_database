DROP TRIGGER IF EXISTS include_order
GO

CREATE TRIGGER include_order
ON [Order]
AFTER INSERT
AS
BEGIN
    DECLARE @client_id INTEGER
    SET @client_id = (SELECT client_id from inserted)
    IF NOT EXISTS(SELECT * FROM ClientActivity WHERE ClientActivity.client_id = @client_id)
    BEGIN
        INSERT INTO ClientActivity
        VALUES (1, 0, @client_id)
    END
    ELSE
    BEGIN
        UPDATE ClientActivity
        SET transactions_num += 1
        WHERE ClientActivity.client_id = @client_id
    END
END
GO