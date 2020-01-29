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
	declare @url varchar
	declare @size int
	declare @data_type varchar
	declare @msg_id varchar

	open iterator

	fetch iterator into @id, @url, @size, @data_type, @msg_id
	while @@FETCH_STATUS = 0
	begin
		print(convert(varchar, @id) + ', ' +  @url + ', ' +  convert(varchar, @size) + ', ' +  @data_type + ', ' +  @msg_id)
		
		insert into Attachment (url, size, data_type, message_id)
		values(@url, @size, @data_type, @msg_id)

		fetch iterator into @id, @url, @size, @data_type, @msg_id
	end

	close iterator
	deallocate iterator
go

