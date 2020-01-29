IF OBJECT_ID('LastPriceExpirationDate', 'fn') IS NOT NULL
	DROP FUNCTION LastPriceExpirationDate
GO

CREATE FUNCTION LastPriceExpirationDate ()
RETURNS DATETIME
AS
BEGIN
    DECLARE @Result DATETIME
    IF NOT EXISTS (SELECT * FROM ProductPrice)
    BEGIN
        SET @Result = GETDATE()
    END
    ELSE
    BEGIN
        SET @Result = (SELECT MAX(valid_to) FROM ProductPrice)
    END
    RETURN @Result
END
GO

IF OBJECT_ID('archive_price', 'tr') IS NOT NULL
	DROP TRIGGER archive_price
GO

CREATE TRIGGER archive_price
ON Product
AFTER UPDATE
AS
    BEGIN
        INSERT INTO ProductPrice(price, valid_from, valid_to, product_id)
        SELECT price, (SELECT dbo.[LastPriceExpirationDate]()), GETDATE(), id
        FROM DELETED
    END

