IF OBJECT_ID('auto_response') IS NOT NULL
	DROP TRIGGER auto_response
GO
CREATE TRIGGER auto_response
ON Message
AFTER INSERT
AS
	DECLARE @conversation INTEGER = (SELECT DISTINCT conversation_id FROM inserted)
	DECLARE @last_msg DATETIME = (SELECT MAX(date) FROM Message where conversation_id = @conversation
									AND date < (SELECT MAX(date) FROM inserted))

	if DATEDIFF(DAY, @last_msg, CURRENT_TIMESTAMP) > 1 OR @last_msg IS NULL
		INSERT INTO Message (author_category, message, date, conversation_id)
		VALUES('Bot', 'Hello, our consultant will contact you as soon as possible.', CURRENT_TIMESTAMP, @conversation)
go

