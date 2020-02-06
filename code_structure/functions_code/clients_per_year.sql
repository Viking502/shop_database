DROP FUNCTION IF EXISTS clients_per_year
GO

CREATE FUNCTION clients_per_year
(
        @year INTEGER
)
RETURNS INTEGER
AS
BEGIN
    DECLARE @val INTEGER = (SELECT COUNT(DISTINCT C.user_id)
                            FROM Client C
                            JOIN [Order] O on C.user_id = O.client_id
                            WHERE DATEPART(YEAR, O.date) = @year)
	RETURN  @val
END
GO