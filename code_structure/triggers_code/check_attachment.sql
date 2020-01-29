if object_id('check_attachment', 'tr') is not null
	drop trigger check_attachemnt
go
create trigger check_attachment 
on [dbo].[Attachment] 
instead of insert
as
	declare iterator cursor
		for select * from inserted

	declare @id int
	declare @url varchar(64)
	declare @size int
	declare @data_type varchar(64)
	declare @msg_id int

	open iterator

	fetch iterator into @id, @url, @size, @data_type, @msg_id
	while @@FETCH_STATUS = 0
	begin

		declare @err_flag bit = 0

		if (UPPER(@data_type) not in('JPG', 'PNG', 'GIF'))
		begin
			raiserror('data type of attachemnt is not supported', 16, 1)
			set @err_flag = 1
		end
		if @size < 0
		begin
			raiserror('wrong attachment size' ,16, 1)
			set @err_flag = 1
		end
		else if @size > 536870912 --512MB in bytes
		begin
			raiserror('attachment have too big size' ,16, 1)
			set @err_flag = 1
		end

		if @err_flag = 0
			insert into Attachment (url, size, data_type, message_id)
			values(@url, @size, @data_type, @msg_id)

		fetch iterator into @id, @url, @size, @data_type, @msg_id
	end

	close iterator
	deallocate iterator
go

