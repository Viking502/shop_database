CREATE TABLE "User"
    (
     id INTEGER IDENTITY (1,1),
     name VARCHAR(64) NOT NULL,
     surname VARCHAR(64) NOT NULL,
     email VARCHAR(64) NOT NULL,
     password VARCHAR(64) NOT NULL,
     CONSTRAINT UserPK PRIMARY KEY(id)
    )
GO

CREATE TABLE Worker
    (
     user_id INTEGER,
     salary MONEY NOT NULL,
     employed_since DATETIME NOT NULL,
     position VARCHAR(64) NOT NULL,
     CONSTRAINT WorkerPK PRIMARY KEY(user_id),
     CONSTRAINT WorkerFK FOREIGN KEY (user_id) REFERENCES "User"(id),
     CONSTRAINT WorkerSalary CHECK (salary > 0)
    )
GO

CREATE TABLE Client
    (
     user_id INTEGER,
     register_date DATETIME NOT NULL,
     policy_accepted BIT NOT NULL,
     CONSTRAINT ClientPK PRIMARY KEY(user_id),
     CONSTRAINT ClientFK FOREIGN KEY (user_id) REFERENCES "User"(id)
    )
GO

CREATE TABLE ClientLog
    (
     id INTEGER IDENTITY (1,1),
     date DATETIME NOT NULL,
     category VARCHAR(32) NOT NULL,
     message VARCHAR(512),
     client_id INTEGER NOT NULL,
     CONSTRAINT ClientLogPK PRIMARY KEY (id),
     CONSTRAINT ClientLogFK FOREIGN KEY (client_id) REFERENCES Client(user_id)
    )
GO

CREATE TABLE ClientActivity
    (
     id INTEGER IDENTITY (1,1),
     transactions_num INTEGER NOT NULL,
     total_expenses MONEY NOT NULL,
     client_id INTEGER NOT NULL,
     CONSTRAINT ClientActivityPK PRIMARY KEY (id),
     CONSTRAINT ClientActivityFK FOREIGN KEY (client_id) REFERENCES Client(user_id)
    )
GO

CREATE TABLE Address
    (
     id INTEGER IDENTITY (1,1),
     country VARCHAR(64) NOT NULL,
     state VARCHAR(64) NOT NULL,
     city VARCHAR(64) NOT NULL,
     street VARCHAR(64),
     number INTEGER NOT NULL,
     flat_number INTEGER,
     zip_code INTEGER NOT NULL,
     user_id INTEGER NOT NULL,
     CONSTRAINT AddressPK PRIMARY KEY(id),
     CONSTRAINT AddressFK FOREIGN KEY(user_id) REFERENCES Client(user_id)
    )
GO

CREATE TABLE Blacklist
    (
     id INTEGER IDENTITY (1,1),
     ip_address VARCHAR(32) UNIQUE,
     note VARCHAR(512),
     CONSTRAINT BlacklistPK PRIMARY KEY(id)
    )
GO

CREATE TABLE ProductCategory
    (
     id INTEGER IDENTITY (1,1),
     name VARCHAR(64) NOT NULL,
	 default_amount INTEGER NOT NULL,
     tax FLOAT NOT NULL,
     CONSTRAINT ProductCategoryPK PRIMARY KEY(id)
    )
GO

CREATE TABLE ProductImage
    (
     id INTEGER IDENTITY (1,1),
     name VARCHAR(64),
     path VARCHAR(128) NOT NULL,
     width INTEGER NOT NULL,
     height INTEGER NOT NULL,
     CONSTRAINT ProductImagePK PRIMARY KEY (id)
    )
GO

CREATE TABLE Product
    (
     id INTEGER IDENTITY (1,1),
     name VARCHAR(64) NOT NULL,
     category_id INTEGER NOT NULL,
     image_id INTEGER NOT NULL,
     price DECIMAL (10, 2) NOT NULL,
	 amount INTEGER NOT NULL,
	 status VARCHAR(32) NOT NULL,
     CONSTRAINT ProductPK PRIMARY KEY(id),
     CONSTRAINT ProductFKCategory FOREIGN KEY (category_id) REFERENCES ProductCategory(id),
     CONSTRAINT ProductFKImage FOREIGN KEY (image_id) REFERENCES ProductImage(id)
    )
GO

CREATE TABLE ProductPrice
    (
     id INTEGER IDENTITY (1,1),
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
     id INTEGER IDENTITY (1,1),
     date DATETIME NOT NULL,
     payment_date DATETIME,
	 client_id INTEGER NOT NULL,
     CONSTRAINT OrderPK PRIMARY KEY (id),
	 CONSTRAINT OrderFKClient FOREIGN KEY (client_id) REFERENCES Client(user_id)
    )
GO

CREATE TABLE OrderDetails
    (
     id INTEGER IDENTITY (1,1),
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
     id INTEGER IDENTITY (1,1),
     status VARCHAR(64) NOT NULL,
     date DATETIME NOT NULL,
     note VARCHAR(512),
     order_id INTEGER NOT NULL,
     CONSTRAINT OrderHistoryPK PRIMARY KEY (id),
     CONSTRAINT OrderHistoryFK FOREIGN KEY (order_id) REFERENCES "Order"(id)
    )
GO

CREATE TABLE ConversationCategories
    (
     id INTEGER IDENTITY (1,1),
     name VARCHAR(64) NOT NULL,
     priority INTEGER NOT NULL,
     CONSTRAINT ConversationCategoriesPK PRIMARY KEY (id)
    )
GO

CREATE TABLE Conversation
    (
     id INTEGER IDENTITY (1,1),
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
     id INTEGER IDENTITY (1,1),
     author_category VARCHAR(64) NOT NULL,
     message VARCHAR(512),
     date DATETIME NOT NULL,
     conversation_id INTEGER NOT NULL
     CONSTRAINT MessagePK PRIMARY KEY (id),
     CONSTRAINT MessageFK FOREIGN KEY (conversation_id) REFERENCES Conversation(id)
    )
GO

CREATE TABLE Attachment
    (
     id INTEGER IDENTITY (1,1),
     url VARCHAR(64) NOT NULL,
     size INTEGER,
     data_type VARCHAR(64),
     message_id INTEGER NOT NULL,
     CONSTRAINT AttachmentPK PRIMARY KEY (id),
     CONSTRAINT AttachmentFK FOREIGN KEY (message_id) REFERENCES Message(id)
    )
GO
