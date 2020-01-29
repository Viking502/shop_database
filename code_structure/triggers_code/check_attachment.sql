IF OBJECT_ID('check_attachment', 'tr') IS NOT NULL
	DROP TRIGGER check_attachemnt
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

		IF (UPPER(@data_type) NOT IN('JPG', 'PNG', 'GIF'))
		BEGIN
			RAISERROR('data type of attachemnt is not supported', 16, 1)
			SET @err_flag = 1
		END
		IF @size < 0
		BEGIN
			RAISERROR('wrong attachment size' ,16, 1)
			SET @err_flag = 1
		END
		ELSE IF @size > 536870912 --512MB in bytes
		BEGIN
			RAISERROR('attachment have too big size' ,16, 1)
			SET @err_flag = 1
		END

		IF @err_flag = 0
			INSERT INTO Attachment (url, size, data_type, message_id)
			VALUES(@url, @size, @data_type, @msg_id)

		FETCH iterator INTO @id, @url, @size, @data_type, @msg_id
	END

	CLOSE iterator
	DEALLOCATE iterator
GO

