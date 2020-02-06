DROP VIEW IF EXISTS best_workers
GO

CREATE VIEW best_workers
AS
	SELECT TOP 10 CONCAT(U.name, ' ', U.surname) WorkerName, COUNT(*) Amountofconversations
	FROM Worker W
	JOIN Conversation C ON W.user_id = C.worker_id
	JOIN [User] U ON W.user_id = U.id
	GROUP BY CONCAT(U.name, ' ', U.surname)
	ORDER BY COUNT(*) DESC
GO