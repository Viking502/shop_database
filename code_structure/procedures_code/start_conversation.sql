IF OBJECT_ID('start_conversation') IS NOT NULL
	DROP PROCEDURE start_conversation
GO
CREATE PROCEDURE start_conversation(@user_id INTEGER, @category_id INTEGER)
AS
BEGIN

	DECLARE @worker INTEGER = NULL
	DECLARE @message VARCHAR(32) = 'Your conversation has been started'

	DECLARE @online_worker INTEGER = (SELECT TOP 1 user_id FROM Worker WHERE is_online = 1)
	IF @online_worker IS NOT NULL
		BEGIN
		SET @worker = @online_worker
		SET @message += ' one of our consultant will response you'
		END
	ELSE
		BEGIN
		SET @worker = (SELECT TOP 1 user_id FROM Worker)
		SET @message += ' but no administrator is online. Someone will response for your problem soon'
		END

	INSERT INTO Conversation (start_date, is_closed, category_id, user_id, worker_id)
	VALUES(CURRENT_TIMESTAMP, 0, @category_id, @user_id, @worker)

END
GO
