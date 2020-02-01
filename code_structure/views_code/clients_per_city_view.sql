DROP VIEW IF EXISTS ClientsPerCity
GO

CREATE VIEW ClientsPerCity
AS
	SELECT A.city [City], COUNT(*) [Clients]
	FROM Address A
    GROUP BY A.city
GO