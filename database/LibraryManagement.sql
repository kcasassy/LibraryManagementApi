USE [master]
GO
/****** Object:  Database [LibraryManagementDb]    Script Date: 10/05/2026 1:47:54 PM ******/
CREATE DATABASE [LibraryManagementDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LibraryManagementDb', FILENAME = N'C:\Users\COLLEGELAB-05\LibraryManagementDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LibraryManagementDb_log', FILENAME = N'C:\Users\COLLEGELAB-05\LibraryManagementDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [LibraryManagementDb] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LibraryManagementDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LibraryManagementDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LibraryManagementDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LibraryManagementDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LibraryManagementDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LibraryManagementDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [LibraryManagementDb] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [LibraryManagementDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LibraryManagementDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LibraryManagementDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LibraryManagementDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LibraryManagementDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LibraryManagementDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LibraryManagementDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LibraryManagementDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LibraryManagementDb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [LibraryManagementDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LibraryManagementDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LibraryManagementDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LibraryManagementDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LibraryManagementDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LibraryManagementDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LibraryManagementDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LibraryManagementDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [LibraryManagementDb] SET  MULTI_USER 
GO
ALTER DATABASE [LibraryManagementDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LibraryManagementDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LibraryManagementDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LibraryManagementDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LibraryManagementDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LibraryManagementDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [LibraryManagementDb] SET QUERY_STORE = OFF
GO
USE [LibraryManagementDb]
GO
/****** Object:  Table [dbo].[Books]    Script Date: 10/05/2026 1:47:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Author] [nvarchar](150) NOT NULL,
	[ISBN] [nvarchar](50) NOT NULL,
	[Category] [nvarchar](100) NOT NULL,
	[TotalCopies] [int] NOT NULL,
	[AvailableCopies] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Loans]    Script Date: 10/05/2026 1:47:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Loans](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BookId] [int] NOT NULL,
	[MemberId] [int] NOT NULL,
	[BorrowedDate] [datetime2](7) NOT NULL,
	[DueDate] [datetime2](7) NOT NULL,
	[ReturnedDate] [datetime2](7) NULL,
	[Status] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Members]    Script Date: 10/05/2026 1:47:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Members](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](150) NOT NULL,
	[Email] [nvarchar](150) NOT NULL,
	[MembershipType] [nvarchar](20) NOT NULL,
	[DateJoined] [datetime2](7) NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Books] ON 
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [ISBN], [Category], [TotalCopies], [AvailableCopies]) VALUES (1, N'The 48 Laws of Power', N'Robert Greene', N'9780143039693', N'Self-help', 5, 5)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [ISBN], [Category], [TotalCopies], [AvailableCopies]) VALUES (2, N'The Art of Seduction', N'Robert Greene', N'9780143039556', N'Psychology', 4, 4)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [ISBN], [Category], [TotalCopies], [AvailableCopies]) VALUES (3, N'Mastery', N'Robert Greene', N'9780156012195', N'Strategy', 3, 3)
GO
INSERT [dbo].[Books] ([Id], [Title], [Author], [ISBN], [Category], [TotalCopies], [AvailableCopies]) VALUES (4, N'The Laws of Human Nature', N'Robert Greene', N'9780132350884', N'Personal Development', 3, 3)
GO
SET IDENTITY_INSERT [dbo].[Books] OFF
GO
SET IDENTITY_INSERT [dbo].[Loans] ON 
GO
INSERT [dbo].[Loans] ([Id], [BookId], [MemberId], [BorrowedDate], [DueDate], [ReturnedDate], [Status]) VALUES (1, 1, 1, CAST(N'2026-10-01T00:00:00.0000000' AS DateTime2), CAST(N'2026-10-08T00:00:00.0000000' AS DateTime2), CAST(N'2026-10-07T00:00:00.0000000' AS DateTime2), N'Returned')
GO
INSERT [dbo].[Loans] ([Id], [BookId], [MemberId], [BorrowedDate], [DueDate], [ReturnedDate], [Status]) VALUES (2, 2, 2, CAST(N'2026-09-10T00:00:00.0000000' AS DateTime2), CAST(N'2026-09-12T00:00:00.0000000' AS DateTime2), NULL, N'Borrowed')
GO
SET IDENTITY_INSERT [dbo].[Loans] OFF
GO
SET IDENTITY_INSERT [dbo].[Members] ON 
GO
INSERT [dbo].[Members] ([Id], [FullName], [Email], [MembershipType], [DateJoined], [IsActive]) VALUES (1, N'Lhanz Carlos', N'lhanz.carlos@email.com', N'Student', CAST(N'2026-01-03T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[Members] ([Id], [FullName], [Email], [MembershipType], [DateJoined], [IsActive]) VALUES (2, N'Kim Santos', N'kim.santos@email.com', N'Student', CAST(N'2026-02-04T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[Members] ([Id], [FullName], [Email], [MembershipType], [DateJoined], [IsActive]) VALUES (3, N'john Rabino', N'john.rabino@email.com', N'Faculty', CAST(N'2026-03-05T00:00:00.0000000' AS DateTime2), 1)
GO
INSERT [dbo].[Members] ([Id], [FullName], [Email], [MembershipType], [DateJoined], [IsActive]) VALUES (4, N'Rene Baterbonia', N'rene.baterbonia@email.com', N'Student', CAST(N'2026-04-06T00:00:00.0000000' AS DateTime2), 1)
GO
SET IDENTITY_INSERT [dbo].[Members] OFF
GO
ALTER TABLE [dbo].[Loans]  WITH CHECK ADD  CONSTRAINT [FK_Loans_Books] FOREIGN KEY([BookId])
REFERENCES [dbo].[Books] ([Id])
GO
ALTER TABLE [dbo].[Loans] CHECK CONSTRAINT [FK_Loans_Books]
GO
ALTER TABLE [dbo].[Loans]  WITH CHECK ADD  CONSTRAINT [FK_Loans_Members] FOREIGN KEY([MemberId])
REFERENCES [dbo].[Members] ([Id])
GO
ALTER TABLE [dbo].[Loans] CHECK CONSTRAINT [FK_Loans_Members]
GO
ALTER TABLE [dbo].[Books]  WITH CHECK ADD  CONSTRAINT [CK_Books_AvailableCopies] CHECK  (([AvailableCopies]>=(0)))
GO
ALTER TABLE [dbo].[Books] CHECK CONSTRAINT [CK_Books_AvailableCopies]
GO
ALTER TABLE [dbo].[Books]  WITH CHECK ADD  CONSTRAINT [CK_Books_AvailableCopies_TotalCopies] CHECK  (([AvailableCopies]<=[TotalCopies]))
GO
ALTER TABLE [dbo].[Books] CHECK CONSTRAINT [CK_Books_AvailableCopies_TotalCopies]
GO
ALTER TABLE [dbo].[Books]  WITH CHECK ADD  CONSTRAINT [CK_Books_TotalCopies] CHECK  (([TotalCopies]>=(0)))
GO
ALTER TABLE [dbo].[Books] CHECK CONSTRAINT [CK_Books_TotalCopies]
GO
ALTER TABLE [dbo].[Loans]  WITH CHECK ADD  CONSTRAINT [CK_Loans_Status] CHECK  (([Status]='Overdue' OR [Status]='Returned' OR [Status]='Borrowed'))
GO
ALTER TABLE [dbo].[Loans] CHECK CONSTRAINT [CK_Loans_Status]
GO
ALTER TABLE [dbo].[Members]  WITH CHECK ADD  CONSTRAINT [CK_Members_MembershipType] CHECK  (([MembershipType]='Faculty' OR [MembershipType]='Student'))
GO
ALTER TABLE [dbo].[Members] CHECK CONSTRAINT [CK_Members_MembershipType]
GO
USE [master]
GO
ALTER DATABASE [LibraryManagementDb] SET  READ_WRITE 
GO
