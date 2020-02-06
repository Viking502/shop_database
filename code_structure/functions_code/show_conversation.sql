DROP FUNCTION IF EXISTS show_conversation
GO

CREATE FUNCTION show_conversation
(
	@conversation_id INTEGER
)
RETURNS TABLE
AS
RETURN
	SELECT M.author_category Author, M.message Message, M.date Timestamp
	FROM Message M
	WHERE M.conversation_id = @conversation_id
GO