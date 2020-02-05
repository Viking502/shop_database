DROP FUNCTION IF EXISTS ClientsPerMonth
GO

CREATE FUNCTION ClientsPerMonth
(
        @month INTEGER,
        @year INTEGER
)
RETURNS INTEGER
AS
BEGIN
    DECLARE @val INTEGER = (SELECT COUNT(DISTINCT C.user_id)
                            FROM Client C
                            JOIN [Order] O on C.user_id = O.client_id
                            WHERE DATEPART(MONTH, O.date) = @month AND DATEPART(YEAR, O.date) = @year)
	RETURN  @val
END
GO