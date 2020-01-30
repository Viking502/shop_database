DROP FUNCTION IF EXISTS ClientsPerCountryCity
GO

CREATE FUNCTION ClientsPerCountryCity (
	@country VARCHAR(64),
	@city VARCHAR(64)
)
RETURNS TABLE
AS
RETURN
	SELECT A.country [Country], S.city [City], S.amount [Per city],
			SUM(S.amount) OVER (PARTITION BY A.country) [Per country]
	FROM Address A
	JOIN (
		SELECT A.city [city], COUNT(*) [amount]
		FROM Address A
		WHERE A.city = @city
		GROUP BY A.city
	) AS S ON A.city = S.City
	WHERE A.country = @country
GO