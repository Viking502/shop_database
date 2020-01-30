IF OBJECT_ID('clients_activity', 'tr') IS NOT NULL
	DROP TRIGGER clients_activity
GO

CREATE TRIGGER clients_activity
ON OrderDetails
AFTER INSERT
AS
BEGIN
    DECLARE @Quantity INTEGER
    SET @Quantity = (SELECT quantity FROM inserted)
    DECLARE @Price INTEGER
    SET @Price = (SELECT price FROM inserted JOIN Product ON inserted.product_id = Product.id)
    DECLARE @ClientId INTEGER
    SET @ClientId = (SELECT client_id
        FROM inserted JOIN Product ON inserted.product_id = Product.id JOIN [Order] ON inserted.order_id = [Order].id)
    IF EXISTS
    (
        SELECT * FROM ClientActivity WHERE client_id = (SELECT client_id
            FROM inserted JOIN Product ON inserted.product_id = Product.id JOIN [Order] ON inserted.order_id = [Order].id)
    )
    BEGIN
        UPDATE ClientActivity
        SET transactions_num = transactions_num + 1
        WHERE ClientActivity.client_id = @ClientId
        UPDATE ClientActivity
        SET total_expenses = total_expenses + @Quantity * @Price
        WHERE ClientActivity.client_id = @ClientId
    END
    ELSE
    BEGIN
        INSERT INTO ClientActivity
        VALUES (1, @Quantity * @Price, @ClientId)
    END
END

