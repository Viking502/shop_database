DROP FUNCTION IF EXISTS ShowConversation
GO

CREATE FUNCTION ShowConversation (
	@conversation_id INTEGER
)
RETURNS TABLE
AS
RETURN
	SELECT M.author_category [Author], M.message [Message]
	FROM Message M
	WHERE M.conversation_id = @conversation_id
GO

SELECT * FROM ShowConversation(1)