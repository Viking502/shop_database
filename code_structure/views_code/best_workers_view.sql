IF OBJECT_ID('BestWorkers', 'v') IS NOT NULL
	DROP VIEW BestWorkers
GO

CREATE VIEW BestWorkers
AS
	SELECT TOP 10 CONCAT(U.name, ' ', U.surname) [Worker name], COUNT(*) [Amount of conversations]
	FROM Worker W
	JOIN Conversation C ON W.user_id = C.worker_id
	JOIN "User" U ON W.user_id = U.id
	GROUP BY CONCAT(U.name, ' ', U.surname)
	ORDER BY COUNT(*) DESC
GO