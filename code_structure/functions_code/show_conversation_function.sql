DROP FUNCTION IF EXISTS ShowConversation
GO

CREATE FUNCTION ShowConversation (
	@conversation_id INTEGER
)
RETURNS TABLE
AS
RETURN
	SELECT M.author_category [Author], M.message [Message], M.date [Timestamp]
	FROM Message M
	WHERE M.conversation_id = @conversation_id
GO