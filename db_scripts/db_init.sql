USE [master]
GO
/****** Object:  Database [ClientDB]    Script Date: 15/11/2019 5:35:24 PM ******/
CREATE DATABASE [ClientDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ClientDB', FILENAME = N'/var/opt/mssql/data/ClientDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ClientDB_log', FILENAME = N'/var/opt/mssql/data/ClientDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ClientDB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ClientDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ClientDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ClientDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ClientDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ClientDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ClientDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ClientDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ClientDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ClientDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ClientDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ClientDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ClientDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ClientDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ClientDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ClientDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ClientDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ClientDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ClientDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ClientDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ClientDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ClientDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ClientDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ClientDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ClientDB] SET RECOVERY FULL 
GO
ALTER DATABASE [ClientDB] SET  MULTI_USER 
GO
ALTER DATABASE [ClientDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ClientDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ClientDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ClientDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ClientDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ClientDB', N'ON'
GO
ALTER DATABASE [ClientDB] SET QUERY_STORE = OFF
GO
USE [ClientDB]
GO
/****** Object:  Table [dbo].[client]    Script Date: 15/11/2019 5:35:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[client](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[clientname] [nvarchar](100) NULL,
	[clientno] [nvarchar](20) NULL,
	[birthdate] [date] NULL,
	[createdby] [nvarchar](20) NULL,
	[createddate] [date] NULL,
	[updatedby] [nvarchar](20) NULL,
	[updateddate] [date] NULL,
 CONSTRAINT [PK_client] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[client] ON 
GO
INSERT [dbo].[client] ([id], [clientname], [clientno], [birthdate], [createdby], [createddate], [updatedby], [updateddate]) VALUES (1, N'Margret Wheless', N'UEF-28635', CAST(N'1974-05-09' AS Date), N'system', CAST(N'2019-09-15' AS Date), N'system', CAST(N'2019-09-15' AS Date))
GO
INSERT [dbo].[client] ([id], [clientname], [clientno], [birthdate], [createdby], [createddate], [updatedby], [updateddate]) VALUES (2, N'Vergie Sidhu', N'UQT-42458', CAST(N'1982-10-11' AS Date), N'system', CAST(N'2019-09-15' AS Date), N'system', CAST(N'2019-09-15' AS Date))
GO
INSERT [dbo].[client] ([id], [clientname], [clientno], [birthdate], [createdby], [createddate], [updatedby], [updateddate]) VALUES (3, N'Elsa Matos', N'DZP-08416', CAST(N'1975-06-27' AS Date), N'system', CAST(N'2019-09-15' AS Date), N'system', CAST(N'2019-09-15' AS Date))
GO
INSERT [dbo].[client] ([id], [clientname], [clientno], [birthdate], [createdby], [createddate], [updatedby], [updateddate]) VALUES (4, N'Kemberly Schack', N'GSW-98542', CAST(N'1976-05-08' AS Date), N'system', CAST(N'2019-09-15' AS Date), N'system', CAST(N'2019-09-15' AS Date))
GO
INSERT [dbo].[client] ([id], [clientname], [clientno], [birthdate], [createdby], [createddate], [updatedby], [updateddate]) VALUES (5, N'Marni Scurlock', N'IPU-01295', CAST(N'1973-09-06' AS Date), N'system', CAST(N'2019-09-15' AS Date), N'system', CAST(N'2019-09-15' AS Date))
GO
INSERT [dbo].[client] ([id], [clientname], [clientno], [birthdate], [createdby], [createddate], [updatedby], [updateddate]) VALUES (6, N'Armand Rumph', N'DDF-25082', CAST(N'1986-07-05' AS Date), N'system', CAST(N'2019-09-15' AS Date), N'system', CAST(N'2019-09-15' AS Date))
GO
INSERT [dbo].[client] ([id], [clientname], [clientno], [birthdate], [createdby], [createddate], [updatedby], [updateddate]) VALUES (7, N'Elana Viloria', N'JLT-74567', CAST(N'1984-08-29' AS Date), N'system', CAST(N'2019-09-15' AS Date), N'system', CAST(N'2019-09-15' AS Date))
GO
INSERT [dbo].[client] ([id], [clientname], [clientno], [birthdate], [createdby], [createddate], [updatedby], [updateddate]) VALUES (8, N'Maria Nakamura', N'GKA-76727', CAST(N'1989-05-21' AS Date), N'system', CAST(N'2019-09-15' AS Date), N'system', CAST(N'2019-09-15' AS Date))
GO
INSERT [dbo].[client] ([id], [clientname], [clientno], [birthdate], [createdby], [createddate], [updatedby], [updateddate]) VALUES (9, N'Tatum Pearce', N'YIU-25199', CAST(N'1985-02-12' AS Date), N'system', CAST(N'2019-09-15' AS Date), N'system', CAST(N'2019-09-15' AS Date))
GO
INSERT [dbo].[client] ([id], [clientname], [clientno], [birthdate], [createdby], [createddate], [updatedby], [updateddate]) VALUES (10, N'Delta Lanni', N'ZVA-56861', CAST(N'1990-01-20' AS Date), N'system', CAST(N'2019-09-15' AS Date), N'system', CAST(N'2019-09-15' AS Date))
GO
INSERT [dbo].[client] ([id], [clientname], [clientno], [birthdate], [createdby], [createddate], [updatedby], [updateddate]) VALUES (11, N'Suzanna Tacey', N'KUV-33193', CAST(N'1979-04-05' AS Date), N'system', CAST(N'2019-09-15' AS Date), N'system', CAST(N'2019-09-15' AS Date))
GO
INSERT [dbo].[client] ([id], [clientname], [clientno], [birthdate], [createdby], [createddate], [updatedby], [updateddate]) VALUES (12, N'Rhoda Penfold', N'PVI-13649', CAST(N'1980-10-26' AS Date), N'system', CAST(N'2019-09-15' AS Date), N'system', CAST(N'2019-09-15' AS Date))
GO
INSERT [dbo].[client] ([id], [clientname], [clientno], [birthdate], [createdby], [createddate], [updatedby], [updateddate]) VALUES (13, N'Loma Disalvo', N'ACO-00446', CAST(N'1989-01-02' AS Date), N'system', CAST(N'2019-09-15' AS Date), N'system', CAST(N'2019-09-15' AS Date))
GO
INSERT [dbo].[client] ([id], [clientname], [clientno], [birthdate], [createdby], [createddate], [updatedby], [updateddate]) VALUES (14, N'Emerita Leger', N'DNR-85002', CAST(N'1974-09-06' AS Date), N'system', CAST(N'2019-09-15' AS Date), N'system', CAST(N'2019-09-15' AS Date))
GO
INSERT [dbo].[client] ([id], [clientname], [clientno], [birthdate], [createdby], [createddate], [updatedby], [updateddate]) VALUES (15, N'Bridgette Paramo', N'CJU-33167', CAST(N'1978-11-04' AS Date), N'system', CAST(N'2019-09-15' AS Date), N'system', CAST(N'2019-09-15' AS Date))
GO
INSERT [dbo].[client] ([id], [clientname], [clientno], [birthdate], [createdby], [createddate], [updatedby], [updateddate]) VALUES (16, N'Clora Huntsman', N'DQY-02360', CAST(N'1974-12-05' AS Date), N'system', CAST(N'2019-09-15' AS Date), N'system', CAST(N'2019-09-15' AS Date))
GO
INSERT [dbo].[client] ([id], [clientname], [clientno], [birthdate], [createdby], [createddate], [updatedby], [updateddate]) VALUES (17, N'Vaughn Grosse', N'NAA-67487', CAST(N'1975-02-13' AS Date), N'system', CAST(N'2019-09-15' AS Date), N'system', CAST(N'2019-09-15' AS Date))
GO
INSERT [dbo].[client] ([id], [clientname], [clientno], [birthdate], [createdby], [createddate], [updatedby], [updateddate]) VALUES (18, N'Carlena Giorgi', N'EII-79687', CAST(N'1986-05-14' AS Date), N'system', CAST(N'2019-09-15' AS Date), N'system', CAST(N'2019-09-15' AS Date))
GO
INSERT [dbo].[client] ([id], [clientname], [clientno], [birthdate], [createdby], [createddate], [updatedby], [updateddate]) VALUES (19, N'Paul Felten', N'BQN-56303', CAST(N'1984-02-10' AS Date), N'system', CAST(N'2019-09-15' AS Date), N'system', CAST(N'2019-09-15' AS Date))
GO
INSERT [dbo].[client] ([id], [clientname], [clientno], [birthdate], [createdby], [createddate], [updatedby], [updateddate]) VALUES (20, N'Rosamaria Dixion', N'MTF-40374', CAST(N'1988-10-04' AS Date), N'system', CAST(N'2019-09-15' AS Date), N'system', CAST(N'2019-09-15' AS Date))
GO
SET IDENTITY_INSERT [dbo].[client] OFF
GO
USE [master]
GO
ALTER DATABASE [ClientDB] SET  READ_WRITE 
GO
