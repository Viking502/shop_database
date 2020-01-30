IF OBJECT_ID('ConversationsPerCategory', 'v') IS NOT NULL
	DROP VIEW ConversationsPerCategory
GO

CREATE VIEW ConversationsPerCategory
AS
	SELECT CC.name [Category name], COUNT(*) [Amount]
	FROM Conversation C
	JOIN ConversationCategories CC ON C.id = CC.id
	GROUP BY CC.name
GO