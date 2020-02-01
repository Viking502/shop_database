DROP VIEW IF EXISTS ConversationsPerCategory
GO

CREATE VIEW ConversationsPerCategory
AS
	SELECT CC.name [Category name], COUNT(*) [Amount]
	FROM Conversation C
	JOIN ConversationCategories CC ON C.id = CC.id
	GROUP BY CC.name
GO