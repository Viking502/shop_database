DROP VIEW IF EXISTS most_frequently_bought_products
GO

CREATE VIEW most_frequently_bought_products
AS
	SELECT TOP 10 P.id, P.name, SUM(OD.quantity) as quantity
    FROM [Order] O
        JOIN OrderDetails OD on O.id = OD.order_id
        JOIN Product P on OD.product_id = P.id
	GROUP BY P.id, P.name
    ORDER BY quantity DESC
GO