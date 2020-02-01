DROP VIEW IF EXISTS ClientsPerCountry
GO

CREATE VIEW ClientsPerCountry
AS
	SELECT A.country [Country], COUNT(*) [Clients]
	FROM Address A
    GROUP BY A.country
GO