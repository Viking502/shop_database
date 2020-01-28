CREATE TABLE "User"
    (
     id INTEGER NOT NULL,
     name VARCHAR NOT NULL,
     surname VARCHAR NOT NULL,
     email VARCHAR NOT NULL,
     password VARCHAR NOT NULL,
     register_date DATETIME NOT NULL,
     policy_accepted BIT NOT NULL,
     CONSTRAINT UserPK PRIMARY KEY(id)
    )
GO

CREATE TABLE Worker
    (
     user_id INTEGER NOT NULL,
     salary MONEY NOT NULL,
     employed_since DATETIME NOT NULL,
     position VARCHAR NOT NULL,
     CONSTRAINT WorkerPK PRIMARY KEY(user_id),
     CONSTRAINT WorkerFK FOREIGN KEY (user_id) REFERENCES "User"(id)
    )
GO

CREATE TABLE Client
    (
     user_id INTEGER NOT NULL,
     register_date DATETIME NOT NULL,
     policy_accepted BIT NOT NULL,
     CONSTRAINT ClientPK PRIMARY KEY(user_id),
     CONSTRAINT ClientFK FOREIGN KEY (user_id) REFERENCES "User"(id)
    )
GO

CREATE TABLE ClientLog
    (
     id INTEGER NOT NULL,
     date DATETIME NOT NULL,
     category VARCHAR NOT NULL,
     message VARCHAR,
     client_id INTEGER NOT NULL,
     CONSTRAINT ClientLogPK PRIMARY KEY (id),
     CONSTRAINT ClientLogFK FOREIGN KEY (client_id) REFERENCES Client(user_id)
    )
GO

CREATE TABLE ClientActivity
    (
     id INTEGER NOT NULL,
     transactions_num INTEGER NOT NULL,
     last_login DATETIME NOT NULL,
     total_expenses MONEY NOT NULL,
     client_id INTEGER NOT NULL,
     CONSTRAINT ClientActivityPK PRIMARY KEY (id),
     CONSTRAINT ClientActivityFK FOREIGN KEY (client_id) REFERENCES Client(user_id)
    )
GO

CREATE TABLE Address
    (
     id INTEGER NOT NULL,
     country VARCHAR NOT NULL,
     state VARCHAR NOT NULL,
     street VARCHAR,
     number INTEGER NOT NULL,
     flat_number INTEGER,
     zip_code INTEGER NOT NULL,
     user_id INTEGER NOT NULL,
     CONSTRAINT AddressPK PRIMARY KEY(id),
     CONSTRAINT AddressFK FOREIGN KEY(user_id) REFERENCES Client(user_id)
    )
GO

CREATE TABLE Balance
    (
     id INTEGER NOT NULL,
     month DATETIME NOT NULL,
     income MONEY NOT NULL,
     expense MONEY NOT NULL,
     balance MONEY NOT NULL,
     CONSTRAINT BalancePK PRIMARY KEY (id)
    )
GO

CREATE TABLE Blacklist
    (
     id INTEGER,
     ip_address VARCHAR,
     note VARCHAR,
     CONSTRAINT BlacklistPK PRIMARY KEY(id)
    )
GO

CREATE TABLE ProductCategory
    (
     id INTEGER NOT NULL,
     name VARCHAR NOT NULL,
     tax FLOAT NOT NULL,
     CONSTRAINT ProductCategoryPK PRIMARY KEY(id)
    )
GO

CREATE TABLE ProductImage
    (
     id INTEGER NOT NULL,
     name VARCHAR,
     path VARCHAR NOT NULL,
     width INTEGER NOT NULL,
     height INTEGER NOT NULL,
     CONSTRAINT ProductImagePK PRIMARY KEY (id)
    )
GO

CREATE TABLE Product
    (
     id INTEGER NOT NULL,
     name VARCHAR NOT NULL,
     category_id INTEGER NOT NULL,
     image_id INTEGER NOT NULL,
     CONSTRAINT ProductPK PRIMARY KEY(id),
     CONSTRAINT ProductFKCategory FOREIGN KEY (category_id) REFERENCES ProductCategory(id),
     CONSTRAINT ProductFKImage FOREIGN KEY (image_id) REFERENCES ProductImage(id)
    )
GO

CREATE TABLE ProductPrice
    (
     id INTEGER NOT NULL,
     price MONEY NOT NULL,
     valid_from DATETIME NOT NULL,
     valid_to DATETIME,
     product_id INTEGER NOT NULL,
     CONSTRAINT ProductPricePK PRIMARY KEY (id),
     CONSTRAINT ProductPriceFK FOREIGN KEY (product_id) REFERENCES Product(id)
    )
GO

CREATE TABLE "Order"
    (
     id INTEGER NOT NULL,
     date DATETIME NOT NULL,
     payment_date DATETIME,
     client_id INTEGER NOT NULL,
     CONSTRAINT OrderPK PRIMARY KEY (id),
     CONSTRAINT OrderFKClient FOREIGN KEY (client_id) REFERENCES Client(user_id)
    )
GO

CREATE TABLE OrderDetails
    (
     id INTEGER NOT NULL,
     order_id INTEGER NOT NULL,
     quantity INTEGER NOT NULL,
     product_id INTEGER NOT NULL,
     CONSTRAINT OrderDetailsPK PRIMARY KEY (id),
     CONSTRAINT OrderDetailsFKOrder FOREIGN KEY (order_id) REFERENCES "Order"(id),
     CONSTRAINT OrderDetailsFKProduct FOREIGN KEY (product_id) REFERENCES Product(id)
    )
GO

CREATE TABLE OrderHistory
    (
     id INTEGER NOT NULL,
     status VARCHAR NOT NULL,
     date DATETIME NOT NULL,
     note VARCHAR,
     order_id INTEGER NOT NULL,
     CONSTRAINT OrderHistoryPK PRIMARY KEY (id),
     CONSTRAINT OrderHistoryFK FOREIGN KEY (order_id) REFERENCES "Order"(id)
    )
GO

CREATE TABLE ConversationCategories
    (
     id INTEGER NOT NULL,
     name VARCHAR NOT NULL,
     priority INTEGER NOT NULL,
     CONSTRAINT ConversationCategoriesPK PRIMARY KEY (id)
    )
GO

CREATE TABLE Conversation
    (
     id INTEGER NOT NULL,
     start_date DATETIME NOT NULL,
     is_closed BIT,
     category_id INTEGER NOT NULL,
     user_id INTEGER NOT NULL,
     worker_id INTEGER NOT NULL,
     CONSTRAINT ConversationPK PRIMARY KEY(id),
     CONSTRAINT ConversationFKClient FOREIGN KEY (user_id) REFERENCES Client(user_id),
     CONSTRAINT ConversationFKWorker FOREIGN KEY (worker_id) REFERENCES Worker(user_id),
     CONSTRAINT ConversationFKCategory FOREIGN KEY (category_id) REFERENCES ConversationCategories(id)
    )
GO

CREATE TABLE Message
    (
     id INTEGER NOT NULL,
     author_category VARCHAR NOT NULL,
     message VARCHAR,
     date DATETIME NOT NULL,
     conversation_id INTEGER NOT NULL
     CONSTRAINT MessagePK PRIMARY KEY (id),
     CONSTRAINT MessageFK FOREIGN KEY (conversation_id) REFERENCES Conversation(id)
    )
GO

CREATE TABLE Attachment
    (
     id INTEGER NOT NULL,
     url VARCHAR NOT NULL,
     size INTEGER,
     data_type VARCHAR,
     message_id INTEGER NOT NULL,
     CONSTRAINT AttachmentPK PRIMARY KEY (id),
     CONSTRAINT AttachmentFK FOREIGN KEY (message_id) REFERENCES Message(id)
    )
GO
