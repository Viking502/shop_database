INSERT INTO "User" (name, surname, email, password)
VALUES
('Adam', 'Kowalski', 'adam123@gmail.com', '1111'),
('Kamil', 'Norwid', 'Norwid@gmail.com', 'cyprianek1234'),
('Rafael', 'Kawiecki', 'rafkaw@gmail.com', 'zawa4321'),
('Michael', 'Orwat', 'Master@gmail.com', '4321')

INSERT INTO Client (user_id, register_date, policy_accepted)
VALUES
(1, '2020-02-01 19:12:08.573', 1),
(3, '2020-01-30 20:13:08.573', 1)

INSERT INTO Worker (user_id, salary, employed_since, position, is_online)
VALUES
(2, 1000000, '2020-01-29 19:12:08.573', 'Poeta/Administrator', 1),
(4, 200000, '2020-02-01 12:12:08.573', 'Administrator', 0)

INSERT INTO ConversationCategories (name, priority)
VALUES('technical problems', 100)

INSERT INTO Conversation (start_date, is_closed, category_id, user_id, worker_id)
VALUES('14:30:02 01.01.2019', 0, 1, 1, 2)

INSERT INTO Message (author_category, message, date, conversation_id)
VALUES('client', 'Hello, I have a technical problem.', '2020-01-29 12:28:17.297', 1)

INSERT INTO Message (author_category, message, date, conversation_id)
VALUES('client', '...', '2020-01-29 12:36:17.297', 1)

INSERT INTO Address (country, state, city, street, number, zip_code, user_id)
VALUES
('Poland', 'Malopolskie', 'Krakow', 'Lojasiewicza', 6, '30348', 1),
('Poland', 'Mazowieckie', 'krakow', 'Lojasiewicza', 7, '30348', 1),
('Poland', 'Mazowieckie', 'Warszawa', 'Marszalkowska', 1108, '00026', 3)

INSERT INTO Attachment (url, size, data_type, message_id)
VALUES
('www.funny_images.pl/image1', 262144, 'pdf', 1),
('www.funny_images.pl/image2', 16777216, 'gif', 1)
