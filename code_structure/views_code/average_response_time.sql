IF OBJECT_ID('average_response_time') IS NOT NULL
	DROP VIEW average_response_time
GO
CREATE VIEW average_response_time
AS

WITH pairs AS(
	SELECT id,
			LEAD(id) OVER(order by date) AS 'next'
	FROM Message
), 
response_in_sec AS(
	SELECT	DATEDIFF(SECOND, msg.date, response.date) AS 'response_time' -- in seconds
	FROM pairs AS pair
	JOIN Message AS msg ON (msg.id = pair.id)
	JOIN Message AS response ON (pair."next" = response.id)
	WHERE msg.author_category = 'client' AND response.author_category = 'admin'
),avg_time AS(
	SELECT AVG(response_time) as 'avg_response_time_in_sec'
	FROM response_in_sec 
)
select msg.author_category,
		msg.date,
		response.author_category,
		response.date
FROM pairs AS pair
	JOIN Message AS msg ON (msg.id = pair.id)
	JOIN Message AS response ON (pair."next" = response.id)

SELECT * FROM avg_time
GO
