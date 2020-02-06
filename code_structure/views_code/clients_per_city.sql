DROP VIEW IF EXISTS clients_per_city
GO

CREATE VIEW clients_per_city
AS
	SELECT A.city City, COUNT(*) Clients
	FROM Address A
    GROUP BY A.city
GO