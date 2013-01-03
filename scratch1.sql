USE [master]
GO
/****** Object:  Database [Scratch]    Script Date: 1/3/2013 12:26:58 PM ******/
CREATE DATABASE [Scratch]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Scratch', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Scratch.mdf' , SIZE = 3328KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Scratch_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Scratch_log.LDF' , SIZE = 4224KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Scratch] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Scratch].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Scratch] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Scratch] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Scratch] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Scratch] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Scratch] SET ARITHABORT OFF 
GO
ALTER DATABASE [Scratch] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Scratch] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Scratch] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Scratch] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Scratch] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Scratch] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Scratch] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Scratch] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Scratch] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Scratch] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Scratch] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Scratch] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Scratch] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Scratch] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Scratch] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Scratch] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Scratch] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Scratch] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Scratch] SET RECOVERY FULL 
GO
ALTER DATABASE [Scratch] SET  MULTI_USER 
GO
ALTER DATABASE [Scratch] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Scratch] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Scratch] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Scratch] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Scratch]
GO
/****** Object:  StoredProcedure [dbo].[checkdeviceid]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[checkdeviceid]              
 (              
  @GUDID varchar(max),      
  @val int output              
 )              
AS              
              
IF EXISTS (SELECT GUDID FROM GuestUser WHERE GUDID = @GUDID)              
begin              
set @val=1              
return              
end              
              
else              
begin              
set @val=0              
end 
GO
/****** Object:  StoredProcedure [dbo].[checkusername]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[checkusername]          
 (          
  @UserName varchar(50),          
  @Email varchar(150),          
  @val int output          
 )          
AS          
          
IF EXISTS (SELECT UserName FROM Users WHERE UserName = @UserName)          
begin          
set @val=1          
return          
end          
          
else          
begin          
set @val=0          
end          
          
          
IF EXISTS (SELECT Email FROM Users WHERE Email = @Email)          
begin          
set @val=2          
return          
end          
else          
begin          
set @val=0          
end
GO
/****** Object:  StoredProcedure [dbo].[deviceidinfo]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

         
CREATE PROCEDURE [dbo].[deviceidinfo]            
(            
@GUDID as varchar(max),
 @val int output 
            
          
)            
             
AS            
BEGIN            


declare @maxuid int


INSERT INTO [dbo].[Users]
           ([UserName]
           ,[Email]
           ,[Password]
           )
     VALUES
           (null,
           null,
           null
           
           
           
           )
           set @maxuid=SCOPE_IDENTITY()
             set @val=@maxuid
             INSERT INTO [dbo].[UserStatus]
           ([UserId],[CurrentLevel],[CurrentBalance]
           )
     VALUES
           (
           @maxuid,1,20
           )
             
             INSERT INTO [dbo].[GuestUser]
           ([GUDID]
           ,[userId])
     VALUES
           (
           @GUDID
           ,@maxuid)
             
END 
GO
/****** Object:  StoredProcedure [dbo].[getprofileinfo]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
           
CREATE PROCEDURE [dbo].[getprofileinfo]              
(              
@UserId as int  
              
            
)              
               
AS              
BEGIN              
      
SELECT     Users.UserName, Users.UserId, Users.Email, Users.Password, UserStatus.CurrentLevel, UserStatus.CurrentBalance, UserStatus.Sound,   
                      UserStatus.Notifications, UserStatus.PictureInfo  
FROM         Users INNER JOIN  
                      UserStatus ON Users.UserId = UserStatus.UserId  
                      where  users.UserId=@UserId and users.IsActive=1 and Users.IsDeleted=0  
             
               
END 
GO
/****** Object:  StoredProcedure [dbo].[getthemes]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
           
CREATE PROCEDURE [dbo].[getthemes]              
           
               
AS              
BEGIN              
      
select * from Themes where IsActive=1 and Isdeleted=0

               
END 
GO
/****** Object:  StoredProcedure [dbo].[getticketinfo]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
           
CREATE PROCEDURE [dbo].[getticketinfo]              
(              
@Levelno as varchar(50)          
              
            
)              
               
AS              
BEGIN              
      
declare @levelid int      
set @levelid= (select LevelId from Levels where Levelno=@Levelno and IsActive=1 and IsDeleted=0)      
          
      
SELECT     Levels.Levelno, Levels.NumberofTicket, Tickets.TicketPrice, Tickets.ScratchPrice, Tickets.TicketId      
FROM         Levels INNER JOIN      
                      Tickets ON Levels.LevelId = Tickets.LevelId      
                      where Levels.LevelId=@levelid and Levels.IsActive=1 and Levels.IsDeleted=0      
--select * from Levels where Levelno=@Levelno and IsActive=1 and IsDeleted=0          
             
               
END 
GO
/****** Object:  StoredProcedure [dbo].[InsertBankdata]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertBankdata]
@price varchar(50),
@HorseShoes varchar(50)	
AS
BEGIN
	if Exists(select * from Bank where Price=@price and IsActive=1 and IsDeleted=0)
	Begin
	update Bank set Points=@HorseShoes where Price=@price and IsActive=1 and IsDeleted=0
	End
	Else
	Begin
	insert into Bank(Price,Points)values(@price,@HorseShoes)
	End
END

GO
/****** Object:  StoredProcedure [dbo].[InsertCollectionsData]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertCollectionsData]
@CollectionName varchar(150),
@CollectionPrize varchar(50),
@LevelId int	
AS
BEGIN
	if Exists(select * from Collections where CollectionName=@CollectionName and levelid=@LevelId and IsActive=1 and IsDeleted=0)
	Begin
	update Collections set CollectionPrize=@CollectionPrize where CollectionName=@CollectionName and levelid=@LevelId and IsActive=1 and IsDeleted=0
	End
	Else
	Begin
	insert into Collections(CollectionName,CollectionPrize,Levelid)values(@CollectionName,@CollectionPrize,@LevelId)
	End
END

GO
/****** Object:  StoredProcedure [dbo].[InsertLeveldata]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertLeveldata]
@Level varchar(50),
@Tickets varchar(50)	
AS
BEGIN
	if Exists(select * from Levels where Levelno=@Level and IsActive=1 and IsDeleted=0)
	Begin
	update Levels set NumberofTicket=@Tickets where Levelno=@Level and IsActive=1 and IsDeleted=0
	End
	Else
	Begin
	insert into Levels(Levelno,NumberofTicket)values(@Level,@Tickets)
	End
END



GO
/****** Object:  StoredProcedure [dbo].[insertTheme]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[insertTheme]
  @ThemeName varchar(100),
  @ThemeDesc varchar(max),
  @ImageName varchar(40)
  As
  Begin
  Insert into themes(ThemeName,ThemeDesc,ImageName)values(@ThemeName,@ThemeDesc,@ImageName)
  End
GO
/****** Object:  StoredProcedure [dbo].[InsertTicketdata]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[InsertTicketdata]    
@LevelId varchar(50),  
@ThemeId varchar(50),    
@Ticketprice varchar(50),     
@Scratchprize varchar(50),
@TicketTypeId varchar(50),
@ImageName varchar(50),
@RewardId varchar(50)
AS    
BEGIN    
 insert into Tickets(LevelId,ThemeId,TicketPrice,ScratchPrize,ImageName,reward_id,TicketTypeId)values(@LevelId,@ThemeId,@Ticketprice,@Scratchprize,@ImageName,@RewardId,@TicketTypeId)    
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateLevelData]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateLevelData]  
@LevelId varchar(50),  
@Tickets varchar(50)   
AS  
BEGIN  
  update Levels set NumberofTicket=@Tickets where LevelId=@LevelId
 End  
GO
/****** Object:  StoredProcedure [dbo].[userlogin]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- =============================================  
CREATE PROCEDURE [dbo].[userlogin]  
(  
@Email as varchar(150),  
  
@Password as varchar(150)
--@valname varchar output 
  
)  
   
AS  
BEGIN  
--declare @val int
SELECT * FROM Users WHERE Email=@Email AND Password=@password and IsActive=1 and IsDeleted=0  
  --set @val=  (SELECT UserId FROM Users WHERE Email=@Email AND Password=@password and IsActive=1 and IsDeleted=0  )
-- -set @valname=(SELECT UserName FROM Users WHERE Email=@Email AND Password=@password and IsActive=1 and IsDeleted=0  )
-- SELECT     UserStatus.CurrentLevel, UserStatus.CurrentBalance, UserStatus.Sound, UserStatus.Notifications, UserStatus.PictureInfo
--FROM         Users INNER JOIN
--                      UserStatus ON Users.UserId = UserStatus.UserId
--                      where UserStatus.UserId=@val 
 
   
END  
GO
/****** Object:  StoredProcedure [dbo].[usersigninfo]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usersigninfo]          
 (          
  @UserName varchar(50),          
  @Email varchar(150),          
  @Password varchar(150)         
 )          
AS          
declare @maxuid int  
          
   insert into Users(UserName,Email,Password) values(@UserName,@Email,@Password)     
        set @maxuid=SCOPE_IDENTITY()  
        INSERT INTO [UserStatus]  
           ([UserId]  
           ,[CurrentLevel]  
           ,[CurrentBalance]  
           ,[Sound]  
           ,[Notifications]  
           ,[PictureInfo]  
           )  
     VALUES  
           (  
           @maxuid,  
           1,  
           '20',  
           'yes',  
           'abc',  
           'image.jpg'  
             
           )  
GO
/****** Object:  StoredProcedure [dbo].[userstatusinfo]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- =============================================  
CREATE PROCEDURE [dbo].[userstatusinfo]  
(  
@UserId int
    
)  
   
AS  
BEGIN  
SELECT     UserStatus.CurrentLevel, UserStatus.CurrentBalance, UserStatus.Sound, UserStatus.Notifications, UserStatus.PictureInfo
FROM         Users INNER JOIN
                      UserStatus ON Users.UserId = UserStatus.UserId
                      where UserStatus.UserId=@UserId 
 
   
END  
GO
/****** Object:  Table [dbo].[AchievementsList]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AchievementsList](
	[AchieveId] [int] IDENTITY(1,1) NOT NULL,
	[AchievementName] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_AchievementsList] PRIMARY KEY CLUSTERED 
(
	[AchieveId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AdminRole]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AdminRole](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[Role] [varchar](50) NULL,
 CONSTRAINT [PK_AdminRole] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AdminUser]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AdminUser](
	[LoginId] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[LoginName] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[EMail] [varchar](50) NULL,
	[RoleId] [numeric](18, 0) NOT NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[LastActivityDate] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Bank]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Bank](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Price] [varchar](20) NULL,
	[Points] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[Date] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Collections]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Collections](
	[CollectionId] [int] IDENTITY(1,1) NOT NULL,
	[ThemeId] [int] NULL,
	[CollectedIcon] [int] NULL,
	[TotalIcon] [int] NULL,
	[UserId] [int] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GuestUser]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GuestUser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GUDID] [varchar](max) NULL,
	[userId] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Levels]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Levels](
	[LevelId] [int] IDENTITY(1,1) NOT NULL,
	[Levelno] [varchar](50) NULL,
	[NumberofTicket] [int] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_Levels] PRIMARY KEY CLUSTERED 
(
	[LevelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RewardType]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RewardType](
	[Reward_Id] [int] IDENTITY(1,1) NOT NULL,
	[RewardType] [varchar](100) NULL,
 CONSTRAINT [PK_RewardType] PRIMARY KEY CLUSTERED 
(
	[Reward_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Themes]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Themes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ThemeName] [varchar](50) NULL,
	[ThemeDesc] [varchar](max) NULL,
	[ImageName] [varchar](100) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_Themes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tickets]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tickets](
	[TicketId] [int] IDENTITY(1,1) NOT NULL,
	[TicketPrice] [varchar](20) NULL,
	[ScratchPrize] [varchar](20) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[LevelId] [int] NULL,
	[ThemeId] [int] NULL,
	[ImageName] [varchar](50) NULL,
	[TicketTypeId] [int] NULL,
	[Reward_Id] [int] NULL,
 CONSTRAINT [PK_Tickets] PRIMARY KEY CLUSTERED 
(
	[TicketId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TicketType]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TicketType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TicketType] [varchar](100) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserAchievements]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAchievements](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[AchieveId] [int] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[Date] [datetime] NULL,
 CONSTRAINT [PK_UserAchievements] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NULL,
	[Email] [varchar](150) NULL,
	[Password] [varchar](150) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[Date] [datetime] NULL,
	[IsRegister] [bit] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserStatus]    Script Date: 1/3/2013 12:26:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[CurrentLevel] [int] NULL,
	[CurrentBalance] [varchar](20) NULL,
	[Sound] [varchar](20) NULL,
	[Notifications] [varchar](50) NULL,
	[PictureInfo] [varchar](20) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[Date] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[AdminRole] ON 

INSERT [dbo].[AdminRole] ([RoleId], [Role]) VALUES (1, N'Admin')
INSERT [dbo].[AdminRole] ([RoleId], [Role]) VALUES (2, N'User')
SET IDENTITY_INSERT [dbo].[AdminRole] OFF
SET IDENTITY_INSERT [dbo].[AdminUser] ON 

INSERT [dbo].[AdminUser] ([LoginId], [LoginName], [Password], [FirstName], [LastName], [EMail], [RoleId], [IsActive], [IsDeleted], [LastActivityDate]) VALUES (CAST(1 AS Numeric(18, 0)), N'Admin', N'Admin', N'Naveen', N'Negi', N'Admin@siliconbiztech.com', CAST(1 AS Numeric(18, 0)), 1, 0, CAST(0x0000A0C301393DB4 AS DateTime))
SET IDENTITY_INSERT [dbo].[AdminUser] OFF
SET IDENTITY_INSERT [dbo].[Bank] ON 

INSERT [dbo].[Bank] ([Id], [Price], [Points], [IsActive], [IsDeleted], [Date]) VALUES (1, N'12', N'42', 1, 0, CAST(0x0000A0C401267F0A AS DateTime))
INSERT [dbo].[Bank] ([Id], [Price], [Points], [IsActive], [IsDeleted], [Date]) VALUES (2, N'14', N'121', 1, 0, CAST(0x0000A0C401269FE3 AS DateTime))
SET IDENTITY_INSERT [dbo].[Bank] OFF
SET IDENTITY_INSERT [dbo].[GuestUser] ON 

INSERT [dbo].[GuestUser] ([Id], [GUDID], [userId]) VALUES (1, N'a1209', 12)
INSERT [dbo].[GuestUser] ([Id], [GUDID], [userId]) VALUES (2, N'b1209', 13)
INSERT [dbo].[GuestUser] ([Id], [GUDID], [userId]) VALUES (3, N'abc334-ggg', 14)
INSERT [dbo].[GuestUser] ([Id], [GUDID], [userId]) VALUES (4, N'abc334-aabc', 15)
INSERT [dbo].[GuestUser] ([Id], [GUDID], [userId]) VALUES (5, N'abc334-aabc1d', 16)
INSERT [dbo].[GuestUser] ([Id], [GUDID], [userId]) VALUES (6, N'abc334-aabcdddd', 17)
SET IDENTITY_INSERT [dbo].[GuestUser] OFF
SET IDENTITY_INSERT [dbo].[Levels] ON 

INSERT [dbo].[Levels] ([LevelId], [Levelno], [NumberofTicket], [IsActive], [IsDeleted]) VALUES (1, N'1', 20, 1, 0)
INSERT [dbo].[Levels] ([LevelId], [Levelno], [NumberofTicket], [IsActive], [IsDeleted]) VALUES (2, N'2', 10, 1, 0)
INSERT [dbo].[Levels] ([LevelId], [Levelno], [NumberofTicket], [IsActive], [IsDeleted]) VALUES (3, N'3', 15, 1, 0)
SET IDENTITY_INSERT [dbo].[Levels] OFF
SET IDENTITY_INSERT [dbo].[RewardType] ON 

INSERT [dbo].[RewardType] ([Reward_Id], [RewardType]) VALUES (1, N'No Reward')
INSERT [dbo].[RewardType] ([Reward_Id], [RewardType]) VALUES (2, N'3 Icons')
INSERT [dbo].[RewardType] ([Reward_Id], [RewardType]) VALUES (3, N'Horseshoe Dollers')
SET IDENTITY_INSERT [dbo].[RewardType] OFF
SET IDENTITY_INSERT [dbo].[Themes] ON 

INSERT [dbo].[Themes] ([Id], [ThemeName], [ThemeDesc], [ImageName], [IsActive], [IsDeleted]) VALUES (1, N'Wild West', N'This is for test', N'origin.gif', 1, 0)
INSERT [dbo].[Themes] ([Id], [ThemeName], [ThemeDesc], [ImageName], [IsActive], [IsDeleted]) VALUES (2, N'Pirates', N'test2', N'tow.gif', 1, 0)
INSERT [dbo].[Themes] ([Id], [ThemeName], [ThemeDesc], [ImageName], [IsActive], [IsDeleted]) VALUES (3, N'Space', N'test3', N'rev.gif', 1, 0)
SET IDENTITY_INSERT [dbo].[Themes] OFF
SET IDENTITY_INSERT [dbo].[Tickets] ON 

INSERT [dbo].[Tickets] ([TicketId], [TicketPrice], [ScratchPrize], [IsActive], [IsDeleted], [LevelId], [ThemeId], [ImageName], [TicketTypeId], [Reward_Id]) VALUES (1, N'10', N'', 1, 0, 1, 1, N'dsa.gif', 1, 2)
INSERT [dbo].[Tickets] ([TicketId], [TicketPrice], [ScratchPrize], [IsActive], [IsDeleted], [LevelId], [ThemeId], [ImageName], [TicketTypeId], [Reward_Id]) VALUES (2, N'20', N'', 1, 0, 1, 1, N'dsa.gif', 1, 1)
INSERT [dbo].[Tickets] ([TicketId], [TicketPrice], [ScratchPrize], [IsActive], [IsDeleted], [LevelId], [ThemeId], [ImageName], [TicketTypeId], [Reward_Id]) VALUES (3, N'50', N'100', 1, 0, 1, 1, N'dsa.gif', 1, 3)
INSERT [dbo].[Tickets] ([TicketId], [TicketPrice], [ScratchPrize], [IsActive], [IsDeleted], [LevelId], [ThemeId], [ImageName], [TicketTypeId], [Reward_Id]) VALUES (4, N'8', N'10', 1, 0, 2, 1, N'Wild.jpg', 2, 3)
SET IDENTITY_INSERT [dbo].[Tickets] OFF
SET IDENTITY_INSERT [dbo].[TicketType] ON 

INSERT [dbo].[TicketType] ([Id], [TicketType], [IsActive], [IsDeleted]) VALUES (1, N'Match any 3 amounts and win that amount', 1, 0)
INSERT [dbo].[TicketType] ([Id], [TicketType], [IsActive], [IsDeleted]) VALUES (2, N'Match any 4 amounts and win double amount', 1, 0)
INSERT [dbo].[TicketType] ([Id], [TicketType], [IsActive], [IsDeleted]) VALUES (3, N'Match any 2 amounts and win 1/2 amount', 1, 0)
SET IDENTITY_INSERT [dbo].[TicketType] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [UserName], [Email], [Password], [IsActive], [IsDeleted], [Date], [IsRegister]) VALUES (1, N'naveen', N'naveen@info.com', N'naveen', 1, 0, CAST(0x0000A0C201405096 AS DateTime), NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Email], [Password], [IsActive], [IsDeleted], [Date], [IsRegister]) VALUES (2, N'mohan', N'mohan@info.com', N'mohan', 1, 0, CAST(0x0000A0C3011ED097 AS DateTime), NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Email], [Password], [IsActive], [IsDeleted], [Date], [IsRegister]) VALUES (7, N'davidson', N'david@info.com', N'dav', 1, 0, CAST(0x0000A0C4011765F8 AS DateTime), NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Email], [Password], [IsActive], [IsDeleted], [Date], [IsRegister]) VALUES (8, N'davidson1', N'david1@info.com', N'dav1', 1, 0, CAST(0x0000A0C40117B800 AS DateTime), NULL)
INSERT [dbo].[Users] ([UserId], [UserName], [Email], [Password], [IsActive], [IsDeleted], [Date], [IsRegister]) VALUES (9, NULL, NULL, NULL, 1, 0, CAST(0x0000A0C801092F66 AS DateTime), 0)
INSERT [dbo].[Users] ([UserId], [UserName], [Email], [Password], [IsActive], [IsDeleted], [Date], [IsRegister]) VALUES (10, NULL, NULL, NULL, 1, 0, CAST(0x0000A0C80109A7F5 AS DateTime), 0)
INSERT [dbo].[Users] ([UserId], [UserName], [Email], [Password], [IsActive], [IsDeleted], [Date], [IsRegister]) VALUES (11, NULL, NULL, NULL, 1, 0, CAST(0x0000A0C8010A1897 AS DateTime), 0)
INSERT [dbo].[Users] ([UserId], [UserName], [Email], [Password], [IsActive], [IsDeleted], [Date], [IsRegister]) VALUES (12, NULL, NULL, NULL, 1, 0, CAST(0x0000A0C8010CA2EE AS DateTime), 0)
INSERT [dbo].[Users] ([UserId], [UserName], [Email], [Password], [IsActive], [IsDeleted], [Date], [IsRegister]) VALUES (16, NULL, NULL, NULL, 1, 0, CAST(0x0000A0C801202AAE AS DateTime), 0)
INSERT [dbo].[Users] ([UserId], [UserName], [Email], [Password], [IsActive], [IsDeleted], [Date], [IsRegister]) VALUES (13, NULL, NULL, NULL, 1, 0, CAST(0x0000A0C8010E3865 AS DateTime), 0)
INSERT [dbo].[Users] ([UserId], [UserName], [Email], [Password], [IsActive], [IsDeleted], [Date], [IsRegister]) VALUES (14, NULL, NULL, NULL, 1, 0, CAST(0x0000A0C8010E4F29 AS DateTime), 0)
INSERT [dbo].[Users] ([UserId], [UserName], [Email], [Password], [IsActive], [IsDeleted], [Date], [IsRegister]) VALUES (15, NULL, NULL, NULL, 1, 0, CAST(0x0000A0C8011DFC4D AS DateTime), 0)
INSERT [dbo].[Users] ([UserId], [UserName], [Email], [Password], [IsActive], [IsDeleted], [Date], [IsRegister]) VALUES (17, NULL, NULL, NULL, 1, 0, CAST(0x0000A0C8012645D8 AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
SET IDENTITY_INSERT [dbo].[UserStatus] ON 

INSERT [dbo].[UserStatus] ([Id], [UserId], [CurrentLevel], [CurrentBalance], [Sound], [Notifications], [PictureInfo], [IsActive], [IsDeleted], [Date]) VALUES (1, 1, 1, N'20', N'yes', N'abc', N'image.jpg', 1, 0, CAST(0x0000A0C300FF2431 AS DateTime))
INSERT [dbo].[UserStatus] ([Id], [UserId], [CurrentLevel], [CurrentBalance], [Sound], [Notifications], [PictureInfo], [IsActive], [IsDeleted], [Date]) VALUES (6, 7, 1, N'20', N'yes', N'abc', N'image.jpg', 1, 0, CAST(0x0000A0C4011765F8 AS DateTime))
INSERT [dbo].[UserStatus] ([Id], [UserId], [CurrentLevel], [CurrentBalance], [Sound], [Notifications], [PictureInfo], [IsActive], [IsDeleted], [Date]) VALUES (7, 8, 1, N'20', N'yes', N'abc', N'image.jpg', 1, 0, CAST(0x0000A0C40117B800 AS DateTime))
INSERT [dbo].[UserStatus] ([Id], [UserId], [CurrentLevel], [CurrentBalance], [Sound], [Notifications], [PictureInfo], [IsActive], [IsDeleted], [Date]) VALUES (8, 9, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(0x0000A0C801092F66 AS DateTime))
INSERT [dbo].[UserStatus] ([Id], [UserId], [CurrentLevel], [CurrentBalance], [Sound], [Notifications], [PictureInfo], [IsActive], [IsDeleted], [Date]) VALUES (9, 10, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(0x0000A0C80109A7F5 AS DateTime))
INSERT [dbo].[UserStatus] ([Id], [UserId], [CurrentLevel], [CurrentBalance], [Sound], [Notifications], [PictureInfo], [IsActive], [IsDeleted], [Date]) VALUES (10, 11, 1, N'20', NULL, NULL, NULL, 1, 0, CAST(0x0000A0C8010A1897 AS DateTime))
INSERT [dbo].[UserStatus] ([Id], [UserId], [CurrentLevel], [CurrentBalance], [Sound], [Notifications], [PictureInfo], [IsActive], [IsDeleted], [Date]) VALUES (11, 12, 1, N'20', NULL, NULL, NULL, 1, 0, CAST(0x0000A0C8010CA2EE AS DateTime))
INSERT [dbo].[UserStatus] ([Id], [UserId], [CurrentLevel], [CurrentBalance], [Sound], [Notifications], [PictureInfo], [IsActive], [IsDeleted], [Date]) VALUES (15, 16, 1, N'20', NULL, NULL, NULL, 1, 0, CAST(0x0000A0C801202AAE AS DateTime))
INSERT [dbo].[UserStatus] ([Id], [UserId], [CurrentLevel], [CurrentBalance], [Sound], [Notifications], [PictureInfo], [IsActive], [IsDeleted], [Date]) VALUES (12, 13, 1, N'20', NULL, NULL, NULL, 1, 0, CAST(0x0000A0C8010E3865 AS DateTime))
INSERT [dbo].[UserStatus] ([Id], [UserId], [CurrentLevel], [CurrentBalance], [Sound], [Notifications], [PictureInfo], [IsActive], [IsDeleted], [Date]) VALUES (13, 14, 1, N'20', NULL, NULL, NULL, 1, 0, CAST(0x0000A0C8010E4F29 AS DateTime))
INSERT [dbo].[UserStatus] ([Id], [UserId], [CurrentLevel], [CurrentBalance], [Sound], [Notifications], [PictureInfo], [IsActive], [IsDeleted], [Date]) VALUES (14, 15, 1, N'20', NULL, NULL, NULL, 1, 0, CAST(0x0000A0C8011DFC4D AS DateTime))
INSERT [dbo].[UserStatus] ([Id], [UserId], [CurrentLevel], [CurrentBalance], [Sound], [Notifications], [PictureInfo], [IsActive], [IsDeleted], [Date]) VALUES (16, 17, 1, N'20', NULL, NULL, NULL, 1, 0, CAST(0x0000A0C8012645D8 AS DateTime))
SET IDENTITY_INSERT [dbo].[UserStatus] OFF
ALTER TABLE [dbo].[AchievementsList] ADD  CONSTRAINT [DF_AchievementsList_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[AchievementsList] ADD  CONSTRAINT [DF_AchievementsList_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[AdminUser] ADD  CONSTRAINT [DF_AdminUser_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[AdminUser] ADD  CONSTRAINT [DF_AdminUser_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[AdminUser] ADD  CONSTRAINT [DF_AdminUser_LastActivityDate]  DEFAULT (getdate()) FOR [LastActivityDate]
GO
ALTER TABLE [dbo].[Bank] ADD  CONSTRAINT [DF_Bank_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Bank] ADD  CONSTRAINT [DF_Bank_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Bank] ADD  CONSTRAINT [DF_Bank_Date]  DEFAULT (getdate()) FOR [Date]
GO
ALTER TABLE [dbo].[Collections] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Collections] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Levels] ADD  CONSTRAINT [DF_Levels_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Levels] ADD  CONSTRAINT [DF_Levels_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Themes] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Themes] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Tickets] ADD  CONSTRAINT [DF_Tickets_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Tickets] ADD  CONSTRAINT [DF_Tickets_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[TicketType] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[TicketType] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[UserAchievements] ADD  CONSTRAINT [DF_UserAchievements_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[UserAchievements] ADD  CONSTRAINT [DF_UserAchievements_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[UserAchievements] ADD  CONSTRAINT [DF_UserAchievements_Date]  DEFAULT (getdate()) FOR [Date]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_Date]  DEFAULT (getdate()) FOR [Date]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsRegister]  DEFAULT ((0)) FOR [IsRegister]
GO
ALTER TABLE [dbo].[UserStatus] ADD  CONSTRAINT [DF_UserStatus_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[UserStatus] ADD  CONSTRAINT [DF_UserStatus_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[UserStatus] ADD  CONSTRAINT [DF_UserStatus_Date]  DEFAULT (getdate()) FOR [Date]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_Levels] FOREIGN KEY([LevelId])
REFERENCES [dbo].[Levels] ([LevelId])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_Levels]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_RewardType] FOREIGN KEY([Reward_Id])
REFERENCES [dbo].[RewardType] ([Reward_Id])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_RewardType]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_Themes] FOREIGN KEY([ThemeId])
REFERENCES [dbo].[Themes] ([Id])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_Themes]
GO
USE [master]
GO
ALTER DATABASE [Scratch] SET  READ_WRITE 
GO
