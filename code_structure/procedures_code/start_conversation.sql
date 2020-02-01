IF OBJECT_ID('start_conversation') IS NOT NULL
	DROP PROCEDURE start_conversation
GO
CREATE PROCEDURE start_conversation(@user_id INTEGER, @category_id INTEGER)
AS
BEGIN

	DECLARE @worker INTEGER = NULL
	DECLARE @message VARCHAR(128) = 'Your conversation has been started'

	DECLARE @online_worker INTEGER = (SELECT TOP 1 user_id FROM Worker WHERE is_online = 1)
	IF @online_worker IS NOT NULL
		BEGIN
		SET @worker = @online_worker
		SET @message += ' and one of our consultant will respond you shortly'
		END
	ELSE
		BEGIN
		SET @worker = (SELECT TOP 1 user_id FROM Worker)
		SET @message += ', but no administrator is online. Someone will respond for your problem soon'
		END

	INSERT INTO Conversation (start_date, is_closed, category_id, user_id, worker_id)
	VALUES(CURRENT_TIMESTAMP, 0, @category_id, @user_id, @worker)

	INSERT INTO Message (author_category, message, date, conversation_id)
	VALUES('Bot', @message, CURRENT_TIMESTAMP, @@IDENTITY)

END
GO
