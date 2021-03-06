USE [master]
GO
/****** Object:  Database [CupBoards]    Script Date: 1/11/2021 4:32:02 p. m. ******/
CREATE DATABASE [CupBoards]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CupBoards', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\CupBoards.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CupBoards_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\CupBoards_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CupBoards] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CupBoards].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CupBoards] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CupBoards] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CupBoards] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CupBoards] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CupBoards] SET ARITHABORT OFF 
GO
ALTER DATABASE [CupBoards] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CupBoards] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CupBoards] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CupBoards] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CupBoards] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CupBoards] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CupBoards] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CupBoards] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CupBoards] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CupBoards] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CupBoards] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CupBoards] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CupBoards] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CupBoards] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CupBoards] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CupBoards] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CupBoards] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CupBoards] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CupBoards] SET  MULTI_USER 
GO
ALTER DATABASE [CupBoards] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CupBoards] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CupBoards] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CupBoards] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CupBoards] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CupBoards] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [CupBoards] SET QUERY_STORE = OFF
GO
USE [CupBoards]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 1/11/2021 4:32:03 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[idCategory] [varchar](50) NOT NULL,
	[category] [varchar](100) NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[idCategory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoriesXProduct]    Script Date: 1/11/2021 4:32:03 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoriesXProduct](
	[idCategoryXProduct] [varchar](50) NOT NULL,
	[idCategory] [varchar](50) NULL,
	[idProduct] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[idCategoryXProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CupBoardDetail]    Script Date: 1/11/2021 4:32:03 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CupBoardDetail](
	[idCupboardDeatail] [varchar](50) NOT NULL,
	[idCupBoard] [varchar](50) NULL,
	[idProduct] [varchar](50) NULL,
	[amount] [int] NULL,
	[entryDate] [datetime] NULL,
	[exitDate] [datetime] NULL,
	[expirationDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idCupboardDeatail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CupBoards]    Script Date: 1/11/2021 4:32:03 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CupBoards](
	[idCupBoard] [varchar](50) NOT NULL,
	[nameCupBoard] [varchar](50) NULL,
	[isDefault] [bit] NULL,
	[creationDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idCupBoard] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 1/11/2021 4:32:03 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[idProduct] [varchar](50) NOT NULL,
	[idMark] [varchar](50) NULL,
	[nameProduct] [varchar](100) NULL,
	[expirationDate] [datetime2](7) NULL,
	[barCode] [varchar](300) NULL,
PRIMARY KEY CLUSTERED 
(
	[idProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShoppingList]    Script Date: 1/11/2021 4:32:03 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShoppingList](
	[idShopping] [varchar](50) NOT NULL,
	[idProduct] [varchar](50) NULL,
	[amount] [int] NULL,
	[value_] [decimal](18, 0) NULL,
	[expirationDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idShopping] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trademarks]    Script Date: 1/11/2021 4:32:03 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trademarks](
	[idTrademark] [varchar](50) NOT NULL,
	[mark] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[idTrademark] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 1/11/2021 4:32:03 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[idUser] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserXCupBoard]    Script Date: 1/11/2021 4:32:03 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserXCupBoard](
	[idUserXCupboard] [varchar](50) NOT NULL,
	[idUser] [varchar](50) NULL,
	[idCupBoard] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[idUserXCupboard] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserXShoppingList]    Script Date: 1/11/2021 4:32:03 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserXShoppingList](
	[idUserXShopping] [varchar](50) NOT NULL,
	[idUser] [varchar](50) NULL,
	[idShopping] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[idUserXShopping] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CategoriesXProduct]  WITH CHECK ADD  CONSTRAINT [FK_Category_CategoryXProduct] FOREIGN KEY([idCategory])
REFERENCES [dbo].[Categories] ([idCategory])
GO
ALTER TABLE [dbo].[CategoriesXProduct] CHECK CONSTRAINT [FK_Category_CategoryXProduct]
GO
ALTER TABLE [dbo].[CategoriesXProduct]  WITH CHECK ADD  CONSTRAINT [FK_Product_CategoryXProduct] FOREIGN KEY([idProduct])
REFERENCES [dbo].[Products] ([idProduct])
GO
ALTER TABLE [dbo].[CategoriesXProduct] CHECK CONSTRAINT [FK_Product_CategoryXProduct]
GO
ALTER TABLE [dbo].[CupBoardDetail]  WITH CHECK ADD  CONSTRAINT [FK_CupBoard_Detail] FOREIGN KEY([idCupBoard])
REFERENCES [dbo].[CupBoards] ([idCupBoard])
GO
ALTER TABLE [dbo].[CupBoardDetail] CHECK CONSTRAINT [FK_CupBoard_Detail]
GO
ALTER TABLE [dbo].[CupBoardDetail]  WITH CHECK ADD  CONSTRAINT [FK_CupBoard_Products] FOREIGN KEY([idProduct])
REFERENCES [dbo].[Products] ([idProduct])
GO
ALTER TABLE [dbo].[CupBoardDetail] CHECK CONSTRAINT [FK_CupBoard_Products]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Mark_Products] FOREIGN KEY([idMark])
REFERENCES [dbo].[Trademarks] ([idTrademark])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Mark_Products]
GO
ALTER TABLE [dbo].[ShoppingList]  WITH CHECK ADD  CONSTRAINT [FK_User_Shopping] FOREIGN KEY([idProduct])
REFERENCES [dbo].[Products] ([idProduct])
GO
ALTER TABLE [dbo].[ShoppingList] CHECK CONSTRAINT [FK_User_Shopping]
GO
ALTER TABLE [dbo].[UserXCupBoard]  WITH CHECK ADD  CONSTRAINT [FK_CupBoard_UserCupBoard] FOREIGN KEY([idCupBoard])
REFERENCES [dbo].[CupBoards] ([idCupBoard])
GO
ALTER TABLE [dbo].[UserXCupBoard] CHECK CONSTRAINT [FK_CupBoard_UserCupBoard]
GO
ALTER TABLE [dbo].[UserXCupBoard]  WITH CHECK ADD  CONSTRAINT [FK_User_CupBoard] FOREIGN KEY([idUser])
REFERENCES [dbo].[Users] ([idUser])
GO
ALTER TABLE [dbo].[UserXCupBoard] CHECK CONSTRAINT [FK_User_CupBoard]
GO
ALTER TABLE [dbo].[UserXShoppingList]  WITH CHECK ADD  CONSTRAINT [FK_Shopping_UserXShopping] FOREIGN KEY([idShopping])
REFERENCES [dbo].[ShoppingList] ([idShopping])
GO
ALTER TABLE [dbo].[UserXShoppingList] CHECK CONSTRAINT [FK_Shopping_UserXShopping]
GO
ALTER TABLE [dbo].[UserXShoppingList]  WITH CHECK ADD  CONSTRAINT [FK_User_UserXShopping] FOREIGN KEY([idUser])
REFERENCES [dbo].[Users] ([idUser])
GO
ALTER TABLE [dbo].[UserXShoppingList] CHECK CONSTRAINT [FK_User_UserXShopping]
GO
USE [master]
GO
ALTER DATABASE [CupBoards] SET  READ_WRITE 
GO
