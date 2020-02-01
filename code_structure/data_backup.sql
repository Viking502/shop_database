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

INSERT INTO ProductCategory(name, default_amount, tax)
VALUES
('RTV', 15, 10)

INSERT INTO ProductImage(name, path, width, height)
VALUES
('Plazma Funai', '/images/funai.jpg', 100, 100),
('HyperX Cloud Alpha HX-HSCA-RD/EM', '/images/Cloud_Alpha.jpg', 100, 100)

INSERT INTO Product(name, category_id, image_id, price, amount, status)
VALUES
('Plazma Funai', 1, 1, 1000, 15, 'Full'),
('HyperX Cloud Alpha HX-HSCA-RD/EM', 1, 2, 250, 900, 'Full')

INSERT INTO "Order"(date, payment_date, client_id)
VALUES
('2020-01-29 12:40:12.237', '2020-01-29 12:48:11.197', 1),
('2020-01-30 23:15:12.231', '2020-02-01 09:49:12.127', 3)

INSERT INTO OrderDetails(order_id, quantity, product_id)
VALUES
(1, 1, 1),
(1, 20, 2),
(2, 1, 2)
