DROP VIEW IF EXISTS orders_in_progress
GO

CREATE VIEW orders_in_progress
AS
    WITH finalized_orders_ids
    AS
    (
        SELECT DISTINCT order_id
        FROM OrderHistory
        WHERE status = 'finalized'
    ),
    not_finalized_orders_last_ids
    AS
    (
        SELECT order_id, MAX(id) AS id
        FROM OrderHistory
        WHERE order_id NOT IN (SELECT * FROM finalized_orders_ids)
        GROUP BY order_id
    )

    SELECT not_finalized_orders_last_ids.order_id, CONCAT(U.name, ' ', U.surname) as client_name,
           H.status, O.date AS since_when
    FROM not_finalized_orders_last_ids
        JOIN OrderHistory H on H.id = not_finalized_orders_last_ids.id
        JOIN [Order] O ON O.id = not_finalized_orders_last_ids.order_id
        JOIN [User] U ON U.id = O.client_id
GO
