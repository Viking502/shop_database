DROP TRIGGER IF EXISTS clients_activity
GO

CREATE TRIGGER clients_activity
ON OrderDetails
AFTER INSERT
AS
BEGIN
    DECLARE iterator CURSOR
		FOR SELECT inserted.quantity,
		           Product.price, [Order].client_id
		    FROM inserted
            JOIN Product ON inserted.product_id = Product.id
            JOIN [Order] ON inserted.order_id = [Order].id
    DECLARE @quantity INTEGER
    DECLARE @price DECIMAL (10,2)
    DECLARE @client_id INTEGER
    OPEN iterator
    FETCH iterator INTO @quantity, @price, @client_id
    WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE ClientActivity
        SET total_expenses = total_expenses + @Quantity * @Price
        WHERE ClientActivity.client_id = @client_id
        FETCH iterator INTO @quantity, @price, @client_id
    END
    CLOSE iterator
    DEALLOCATE iterator
END
GO
