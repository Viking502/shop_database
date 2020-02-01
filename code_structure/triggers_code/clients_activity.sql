IF OBJECT_ID('clients_activity', 'tr') IS NOT NULL
	DROP TRIGGER clients_activity
GO

CREATE TRIGGER clients_activity
ON OrderDetails
AFTER INSERT
AS
BEGIN
    DECLARE iterator CURSOR
		FOR SELECT * FROM inserted
    DECLARE @id INTEGER
    DECLARE @order_id INTEGER
    DECLARE @quantity INTEGER
    DECLARE @product_id INTEGER
    OPEN iterator
    FETCH iterator INTO @id, @order_id, @quantity, @product_id
    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @price DECIMAL (10,2)
        SET @Price = (SELECT price FROM inserted JOIN Product ON inserted.product_id = Product.id)
        DECLARE @client_id INTEGER
        SET @client_id = (SELECT client_id
        FROM inserted JOIN Product ON inserted.product_id = Product.id JOIN [Order] ON inserted.order_id = [Order].id)
        IF EXISTS
        (
            SELECT * FROM ClientActivity WHERE client_id = (SELECT client_id
                FROM inserted JOIN Product ON inserted.product_id = Product.id JOIN [Order] ON inserted.order_id = [Order].id)
        )
        BEGIN
            UPDATE ClientActivity
            SET transactions_num = transactions_num + 1
            WHERE ClientActivity.client_id = @client_id
            UPDATE ClientActivity
            SET total_expenses = total_expenses + @Quantity * @Price
            WHERE ClientActivity.client_id = @client_id
        END
        ELSE
        BEGIN
            INSERT INTO ClientActivity
            VALUES (1, @Quantity * @Price, @client_id)
        END
        FETCH iterator INTO @id, @order_id, @quantity, @product_id
    END
    CLOSE iterator
    DEALLOCATE iterator
END
GO