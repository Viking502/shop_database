DROP VIEW IF EXISTS most_frequently_bought_products
GO

CREATE VIEW most_frequently_bought_products
AS
	SELECT TOP 10 P.id, P.name, SUM(O.quantity) as quantity
        FROM OrderDetails O
        JOIN Product P on product_id = P.id
	GROUP BY P.id, P.name
    ORDER BY quantity DESC
GO