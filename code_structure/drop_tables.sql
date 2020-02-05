USE [online_shop]
GO
ALTER TABLE [dbo].[Worker] DROP CONSTRAINT [WorkerFK]
GO
ALTER TABLE [dbo].[ProductPrice] DROP CONSTRAINT [ProductPriceFK]
GO
ALTER TABLE [dbo].[Product] DROP CONSTRAINT [ProductFKImage]
GO
ALTER TABLE [dbo].[Product] DROP CONSTRAINT [ProductFKCategory]
GO
ALTER TABLE [dbo].[OrderHistory] DROP CONSTRAINT [OrderHistoryFK]
GO
ALTER TABLE [dbo].[OrderDetails] DROP CONSTRAINT [OrderDetailsFKProduct]
GO
ALTER TABLE [dbo].[OrderDetails] DROP CONSTRAINT [OrderDetailsFKOrder]
GO
ALTER TABLE [dbo].[Order] DROP CONSTRAINT [OrderFKClient]
GO
ALTER TABLE [dbo].[Message] DROP CONSTRAINT [MessageFK]
GO
ALTER TABLE [dbo].[Conversation] DROP CONSTRAINT [ConversationFKWorker]
GO
ALTER TABLE [dbo].[Conversation] DROP CONSTRAINT [ConversationFKClient]
GO
ALTER TABLE [dbo].[Conversation] DROP CONSTRAINT [ConversationFKCategory]
GO
ALTER TABLE [dbo].[ClientLog] DROP CONSTRAINT [ClientLogFK]
GO
ALTER TABLE [dbo].[ClientActivity] DROP CONSTRAINT [ClientActivityFK]
GO
ALTER TABLE [dbo].[Client] DROP CONSTRAINT [ClientFK]
GO
ALTER TABLE [dbo].[Attachment] DROP CONSTRAINT [AttachmentFK]
GO
ALTER TABLE [dbo].[Address] DROP CONSTRAINT [AddressFK]
GO
/****** Object:  Table [dbo].[Worker]    Script Date: 2/5/2020 5:28:46 PM ******/
DROP TABLE [dbo].[Worker]
GO
/****** Object:  Table [dbo].[User]    Script Date: 2/5/2020 5:28:46 PM ******/
DROP TABLE [dbo].[User]
GO
/****** Object:  Table [dbo].[ProductPrice]    Script Date: 2/5/2020 5:28:46 PM ******/
DROP TABLE [dbo].[ProductPrice]
GO
/****** Object:  Table [dbo].[ProductImage]    Script Date: 2/5/2020 5:28:46 PM ******/
DROP TABLE [dbo].[ProductImage]
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 2/5/2020 5:28:46 PM ******/
DROP TABLE [dbo].[ProductCategory]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 2/5/2020 5:28:46 PM ******/
DROP TABLE [dbo].[Product]
GO
/****** Object:  Table [dbo].[OrderHistory]    Script Date: 2/5/2020 5:28:46 PM ******/
DROP TABLE [dbo].[OrderHistory]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 2/5/2020 5:28:46 PM ******/
DROP TABLE [dbo].[OrderDetails]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 2/5/2020 5:28:46 PM ******/
DROP TABLE [dbo].[Order]
GO
/****** Object:  Table [dbo].[Message]    Script Date: 2/5/2020 5:28:46 PM ******/
DROP TABLE [dbo].[Message]
GO
/****** Object:  Table [dbo].[ConversationCategories]    Script Date: 2/5/2020 5:28:46 PM ******/
DROP TABLE [dbo].[ConversationCategories]
GO
/****** Object:  Table [dbo].[Conversation]    Script Date: 2/5/2020 5:28:46 PM ******/
DROP TABLE [dbo].[Conversation]
GO
/****** Object:  Table [dbo].[ClientLog]    Script Date: 2/5/2020 5:28:46 PM ******/
DROP TABLE [dbo].[ClientLog]
GO
/****** Object:  Table [dbo].[ClientActivity]    Script Date: 2/5/2020 5:28:46 PM ******/
DROP TABLE [dbo].[ClientActivity]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 2/5/2020 5:28:46 PM ******/
DROP TABLE [dbo].[Client]
GO
/****** Object:  Table [dbo].[Blacklist]    Script Date: 2/5/2020 5:28:46 PM ******/
DROP TABLE [dbo].[Blacklist]
GO
/****** Object:  Table [dbo].[Attachment]    Script Date: 2/5/2020 5:28:46 PM ******/
DROP TABLE [dbo].[Attachment]
GO
/****** Object:  Table [dbo].[Address]    Script Date: 2/5/2020 5:28:46 PM ******/
DROP TABLE [dbo].[Address]
GO
USE [master]
GO
/****** Object:  Database [online_shop]    Script Date: 2/5/2020 5:28:46 PM ******/
DROP DATABASE [online_shop]
GO
