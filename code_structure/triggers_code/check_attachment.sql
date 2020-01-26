if object_id('check_attachment', 'tr') is not null
	drop trigger check_attachemnt
go
create trigger check_attachment 
on [dbo].[Attachment] 
instead of insert
as
	declare iterator cursor
		for select * from inserted
		for read only

	declare @id int
	declare @url varchar
	declare @size int
	declare @data_type varchar

	fetch iterator into @id, @url, @size, @data_type
	while @@FETCH_STATUS = 1
	begin
		select @id, @url, @size, @data_type
		fetch iterator into @id, @url, @size, @data_type
	end
go

