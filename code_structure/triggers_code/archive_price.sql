DROP FUNCTION IF EXISTS last_price_expiration_date
GO

CREATE FUNCTION last_price_expiration_date ()
RETURNS DATETIME
AS
BEGIN
    DECLARE @result DATETIME
    IF NOT EXISTS (SELECT * FROM ProductPrice)
    BEGIN
        SET @result = GETDATE()
    END
    ELSE
    BEGIN
        SET @result = (SELECT MAX(valid_to) FROM ProductPrice)
    END
    RETURN @result
END
GO

DROP TRIGGER IF EXISTS archive_price
GO

CREATE TRIGGER archive_price
ON Product
AFTER UPDATE
AS
    BEGIN
        INSERT INTO ProductPrice(price, valid_from, valid_to, product_id)
        SELECT price, (SELECT dbo.[last_price_expiration_date]()), GETDATE(), id
        FROM deleted
    END
GO

