DROP TRIGGER IF EXISTS check_attachment
GO

CREATE TRIGGER check_attachment 
ON [dbo].[Attachment] 
INSTEAD OF INSERT
AS
	DECLARE iterator CURSOR
		FOR SELECT * FROM inserted

	DECLARE @id INT
	DECLARE @url VARCHAR(64)
	DECLARE @size INT
	DECLARE @data_type VARCHAR(64)
	DECLARE @msg_id INT

	OPEN iterator

	FETCH iterator INTO @id, @url, @size, @data_type, @msg_id
	WHILE @@FETCH_STATUS = 0
	BEGIN

		DECLARE @err_flag BIT = 0

		IF UPPER(@data_type) NOT IN('JPG', 'PNG', 'GIF', 'PDF')
		BEGIN
			RAISERROR('Data type %s is not supported', 16, 1, @data_type)
			SET @err_flag = 1
		END
		IF @size < 0
		BEGIN
			RAISERROR('Wrong attachment size' ,16, 1)
			SET @err_flag = 1
		END
		ELSE IF @size > 16777216 --16MB in bytes
		BEGIN
			RAISERROR('Attachment size is too big' ,16, 1)
			SET @err_flag = 1
		END

		IF @err_flag = 0
			INSERT INTO Attachment (url, size, data_type, message_id)
			VALUES (@url, @size, @data_type, @msg_id)

		FETCH iterator INTO @id, @url, @size, @data_type, @msg_id
	END

	CLOSE iterator
	DEALLOCATE iterator
GO

