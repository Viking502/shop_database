DROP FUNCTION IF EXISTS date_part
GO

-- dmy_flag is a binary flag
-- first bit [1] -> year
-- second_bit [2] -> month
-- third bit [4] -> day
CREATE FUNCTION date_part(@date DATETIME, @dmy_flag INT)
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
		SET @result_date = @result_date + CONVERT(VARCHAR(4), @year)
	END

	RETURN @result_date
END
GO

DROP VIEW IF EXISTS logs_intensity
GO

CREATE VIEW logs_intensity 
AS
(
	SELECT dbo.date_part(date, 1 + 2) AS Date, COUNT(*) AS LogsCount
	FROM ClientLog
	GROUP BY dbo.date_part(date, 1 + 2)
)
GO
