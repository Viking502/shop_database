DROP TRIGGER IF EXISTS update_product_status
GO

CREATE TRIGGER update_product_status
ON Product
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE iterator CURSOR
		FOR SELECT inserted.id, inserted.category_id, inserted.amount
		    FROM inserted

    DECLARE @id INTEGER
    DECLARE @category_id INTEGER
    DECLARE @amount INTEGER

	OPEN iterator

	FETCH iterator INTO @id, @category_id, @amount
	WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE @err_flag BIT = 0

		IF @amount < 0
		BEGIN
			RAISERROR('Amount of %d must be non negative', 16, 1, @id)
			SET @err_flag = 1
		END

		IF @err_flag = 0
		BEGIN
            DECLARE @limit INTEGER = (  SELECT PC.default_amount
                                        FROM ProductCategory PC
                                        WHERE PC.id = @category_id)
		    DECLARE @percent FLOAT = (100 * @amount) / @limit
            DECLARE @value VARCHAR(32)

            IF @percent >= 100
		    BEGIN
                SET @value = 'Full'
            END
		    ELSE IF @percent >= 67
		    BEGIN
                SET @value = 'High amount'
            END
		    ELSE IF @percent >= 33
		    BEGIN
                SET @value = 'Medium amount'
            END
		    ELSE IF @percent > 0
		    BEGIN
                SET @value = 'Last units'
            END
		    ELSE IF @percent = 0
		    BEGIN
                SET @value = 'Depleted'
            END

		    UPDATE Product
		    SET status = @value
		    WHERE id = @id
        END

		FETCH iterator INTO @id, @category_id, @amount
	END

	CLOSE iterator
	DEALLOCATE iterator
END
GO

