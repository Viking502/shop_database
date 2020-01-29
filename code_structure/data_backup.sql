insert into "User" (name, surname, email, password)
values
('Adam', 'Kowalski', 'adam123@gmail.com', '1111'),
('Kamil', 'Norwid', 'Norwid@gmail.com', 'cyprianek1234')

insert into Client (user_id, register_date, policy_accepted)
values(1, '02.12.2020', 1)

insert into Worker (user_id, salary, employed_since, position)
values(2, 1000000, '02.12.2020', 'Poeta/Administrator')

insert into ConversationCategories (name, priority)
values('technical problems', 100)

insert into Conversation (start_date, is_closed, category_id, user_id, worker_id)
values('01.01.2019', 0, 1, 1, 2)

insert into Message (author_category, message, date, conversation_id)
values('client', 'Hello, I have a technical problem.', '04.02.2021', 1)

insert into Attachment (url, size, data_type, message_id)
values
('www.funny_images.pl/image1', 262144, 'png', 1),
('www.funny_images.pl/image2', 536870912, 'jpg', 1)
