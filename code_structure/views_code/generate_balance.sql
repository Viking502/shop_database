IF OBJECT_ID('generate_balance') IS NOT NULL
	DROP VIEW generate_balance
GO
CREATE VIEW generate_balance
AS
BEGIN

	WITH
	income as(
		SELECT dbo.date_part(payment_date, 3) as "month", SUM(price * quantity) as orders
		FROM Product AS p
		JOIN OrderDetails AS od 
			ON p.id = od.product_id
		JOIN "Order" AS o
			ON od.order_id = o.id
		GROUP BY dbo.date_part(payment_date, 3)
	),
	loss as(
		SELECT SUM(salary) as salary
		FROM Worker
	)

	SELECT "month", orders - salary
	FROM income, loss

END
GO
