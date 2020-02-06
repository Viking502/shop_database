DROP VIEW IF EXISTS clients_per_country
GO

CREATE VIEW clients_per_country
AS
	SELECT A.country Country, COUNT(*) Clients
	FROM Address A
    GROUP BY A.country
GO