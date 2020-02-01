DROP VIEW IF EXISTS best_clients
GO

CREATE VIEW best_clients
AS
	SELECT TOP 10 CONCAT(U.name, ' ', U.surname) AS ClientName, A.total_expenses AS TotalExpenses
	FROM Client C
	JOIN ClientActivity A ON C.user_id = A.client_id
	JOIN "User" U ON C.user_id = U.id
	ORDER BY total_expenses DESC
GO