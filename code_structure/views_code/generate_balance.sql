IF OBJECT_ID('generate_balance') IS NOT NULL
	DROP VIEW generate_balance
GO
CREATE VIEW generate_balance
AS
BEGIN

WITH
income as(
	SELECT SUM(price * quantity) as orders
	FROM Product AS pro
	JOIN OrderDetails AS ord 
		ON pro.id = ord.product_id
),
loss as(
	SELECT SUM(salary) as salary FROM Worker
)

SELECT orders - salary
FROM income, loss

END
GO