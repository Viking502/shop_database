IF OBJECT_ID('auto_response') IS NOT NULL
	DROP TRIGGER auto_response
GO
CREATE TRIGGER auto_response
ON Message
AFTER INSERT
AS
	DECLARE @conversation INTEGER = (SELECT DISTINCT conversation_id FROM inserted)

	INSERT INTO Message (author_category, message, date, conversation_id)
	VALUES('Bot', 'Hello, fuck off!', CURRENT_TIMESTAMP, @conversation)

go

