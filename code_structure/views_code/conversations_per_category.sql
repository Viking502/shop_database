DROP VIEW IF EXISTS conversations_per_category
GO

CREATE VIEW conversations_per_category
AS
	SELECT CC.name CategoryName, COUNT(*) Amount
	FROM Conversation C
	JOIN ConversationCategories CC ON C.id = CC.id
	GROUP BY CC.name
GO