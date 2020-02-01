INSERT INTO "User" (name, surname, email, password)
VALUES
('Adam', 'Kowalski', 'adam123@gmail.com', '1111'),
('Kamil', 'Norwid', 'Norwid@gmail.com', 'cyprianek1234')

INSERT INTO Client (user_id, register_date, policy_accepted)
VALUES(1, '02.12.2020', 1)

INSERT INTO Worker (user_id, salary, employed_since, position)
VALUES(2, 1000000, '02.12.2020', 'Poeta/Administrator')

INSERT INTO ConversationCategories (name, priority)
VALUES('technical problems', 100)

INSERT INTO Conversation (start_date, is_closed, category_id, user_id, worker_id)
VALUES('14:30:02 01.01.2019', 0, 1, 1, 2)

INSERT INTO Message (author_category, message, date, conversation_id)
VALUES('client', 'Hello, I have a technical problem.', '2020-01-29 12:28:17.297', 1)

INSERT INTO Message (author_category, message, date, conversation_id)
VALUES('client', '...', '2020-01-29 12:36:17.297', 1)

INSERT INTO Attachment (url, size, data_type, message_id)
VALUES
('www.funny_images.pl/image1', 262144, 'pdf', 1),
('www.funny_images.pl/image2', 16777216, 'gif', 1)
