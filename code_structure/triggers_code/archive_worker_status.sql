DROP TRIGGER IF EXISTS archive_worker_status
GO

CREATE TRIGGER archive_worker_status
ON Worker
AFTER INSERT, UPDATE
AS

	DECLARE iterator CURSOR
			FOR SELECT user_id, position, salary FROM inserted

	DECLARE @worker_id INTEGER
	DECLARE @position VARCHAR(64)
	DECLARE @salary MONEY
	
	DECLARE @current_time DATETIME = CURRENT_TIMESTAMP

	OPEN iterator
	FETCH iterator INTO @worker_id, @position, @salary

	WHILE @@FETCH_STATUS = 0
	BEGIN
		UPDATE WorkerHistory
		SET valid_to = @current_time
		WHERE worker_id = @worker_id 
			AND valid_from = (SELECT MAX(valid_from) FROM WorkerHistory WHERE worker_id = @worker_id)

		INSERT INTO WorkerHistory (position, salary, valid_from, worker_id)
		VALUES (@position, @salary, @current_time, @worker_id)

		FETCH iterator INTO @worker_id, @position, @salary
	END
	CLOSE iterator
	DEALLOCATE iterator
GO
