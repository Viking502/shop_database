IF OBJECT_ID('date_part') IS NOT NULL
	DROP FUNCTION date_part
GO
CREATE FUNCTION date_part(@date DATETIME, @dmy_flag INT) 

-- dmy_flag is a binary flag
-- first bit [1] -> year
-- second_bit [2] -> month
-- third bit [4] -> day

RETURNS VARCHAR(16)
AS
BEGIN	
	DECLARE @result_date VARCHAR(16) = ''

	DECLARE @day INT = 0
	DECLARE @month INT = 0
	DECLARE @year INT = 0

	IF @dmy_flag & 4 = 4
		BEGIN
		SET @day = DAY(@date)
		IF @day < 10
			SET @result_date = @result_date + '0'
		SET @result_date = @result_date + CONVERT(VARCHAR(2), @day)
		IF @dmy_flag & 2 = 2
			SET @result_date = @result_date + '-'
		END
	IF @dmy_flag & 2 = 2
		BEGIN
		SET @month = MONTH(@date)
		IF @month < 10
			SET @result_date = @result_date + '0'
		SET @result_date = @result_date + CONVERT(VARCHAR(2), @month)
		IF @dmy_flag & 1 = 1
			SET @result_date = @result_date + '-'
		END
	IF @dmy_flag & 1 = 1
		BEGIN
		SET @year = YEAR(@date)
		IF @year < 1000
			SET @result_date = @result_date + '000'
		SET @result_date = @result_date + CONVERT(VARCHAR(4), @year)
		END

	RETURN @result_date
END

GO
IF OBJECT_ID('logs_intensity') IS NOT NULL
	DROP VIEW logs_intensity
GO
CREATE VIEW logs_intensity 
AS(
	SELECT dbo.date_part(date, 1 + 2) AS "date", COUNT(*) AS "logs_count"
	FROM ClientLog
	GROUP BY dbo.date_part(date, 1 + 2)
)
GO
