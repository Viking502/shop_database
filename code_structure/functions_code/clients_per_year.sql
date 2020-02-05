DROP FUNCTION IF EXISTS ClientsPerYear
GO

CREATE FUNCTION ClientsPerYear
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