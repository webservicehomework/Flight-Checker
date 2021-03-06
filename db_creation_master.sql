
USE [master]
GO
/****** Object:  Database [FlightInformation]    Script Date: 03/21/2016 11:43:19 ******/
CREATE DATABASE [FlightInformation] ON  PRIMARY 
( NAME = N'FlightInformation', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\DATA\FlightInformationDB.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'FlightInformation_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\DATA\FlightInformationDB_log.ldf' , SIZE = 15360KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
EXEC dbo.sp_dbcmptlevel @dbname=N'FlightInformation', @new_cmptlevel=90
GO
ALTER DATABASE [FlightInformation] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FlightInformation] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FlightInformation] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FlightInformation] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FlightInformation] SET ARITHABORT OFF 
GO
ALTER DATABASE [FlightInformation] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FlightInformation] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [FlightInformation] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FlightInformation] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FlightInformation] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FlightInformation] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FlightInformation] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FlightInformation] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FlightInformation] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FlightInformation] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FlightInformation] SET  ENABLE_BROKER 
GO
ALTER DATABASE [FlightInformation] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FlightInformation] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FlightInformation] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FlightInformation] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FlightInformation] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FlightInformation] SET  READ_WRITE 
GO
ALTER DATABASE [FlightInformation] SET RECOVERY FULL 
GO
ALTER DATABASE [FlightInformation] SET  MULTI_USER 
GO
ALTER DATABASE [FlightInformation] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FlightInformation] SET DB_CHAINING OFF 
Go

-- Create the login for yyc
USE [master]
GO
CREATE LOGIN [yycreadonly] WITH PASSWORD=N'assignment', DEFAULT_DATABASE=[FlightInformation], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO

-- Create user yyc
USE [FlightInformation]
GO
/****** Object:  User [yycreadonly]    Script Date: 03/21/2016 11:53:31 ******/
CREATE USER [yycreadonly] FOR LOGIN [yycreadonly] WITH DEFAULT_SCHEMA=[dbo]
GO

-- Create tables
/****** Object:  Table [dbo].[Airline]    Script Date: 03/21/2016 11:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Airline](
	[airline_id] [int] IDENTITY(1,1) NOT NULL,
	[airline_name] [text] NOT NULL,
 CONSTRAINT [PK_Airline] PRIMARY KEY CLUSTERED 
(
	[airline_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gate]    Script Date: 03/21/2016 11:53:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gate](
	[gate_id] [int] IDENTITY(1,1) NOT NULL,
	[gate_name] [text] NOT NULL,
 CONSTRAINT [PK_Gate] PRIMARY KEY CLUSTERED 
(
	[gate_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Airport]    Script Date: 03/21/2016 11:53:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Airport](
	[airport_id] [int] IDENTITY(1,1) NOT NULL,
	[airport_name] [text] NOT NULL,
	[airport_location] [text] NOT NULL,
 CONSTRAINT [PK_Airport] PRIMARY KEY CLUSTERED 
(
	[airport_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FlightData]    Script Date: 03/21/2016 11:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FlightData](
	[flight_id] [int] IDENTITY(1,1) NOT NULL,
	[airline_id] [int] NOT NULL,
	[gate_id] [int] NOT NULL,
	[destination_airport_id] [int] NULL,
	[takeoff_airport_id] [int] NULL,
	[departure_time] [datetime] NOT NULL,
	[flight_number] [varchar](max) NOT NULL,
 CONSTRAINT [PK_FlightData] PRIMARY KEY CLUSTERED 
(
	[flight_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF

-- Add Select Permission
GO
GRANT SELECT ON [dbo].[Airline] TO [yycreadonly]
GO
GRANT SELECT ON [dbo].[Airport] TO [yycreadonly]
GO
GRANT SELECT ON [dbo].[FlightData] TO [yycreadonly]
GO
GRANT SELECT ON [dbo].[Gate] TO [yycreadonly]
GO

-- Insert data
Go
IF  EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'dbo.airline') AND type in (N'U'))
Begin
Insert into airline(airline_name)
Values
('air canada')
Insert into airline(airline_name)
Values
('west jet')
Insert into airline(airline_name)
Values
('air canada jazz')
Insert into airline(airline_name)
Values
('cool runnings')
Insert into airline(airline_name)
Values
('end to end')
Insert into airline(airline_name)
Values
('air germany')
end

Go
IF  EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'dbo.gate') AND type in (N'U'))
Begin
Insert into gate(gate_name)
Values
('A')
Insert into gate(gate_name)
Values
('B')
Insert into gate(gate_name)
Values
('C')
Insert into gate(gate_name)
Values
('D')
Insert into gate(gate_name)
Values
('E')
end

Go
IF  EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'dbo.airport') AND type in (N'U'))
Begin
Insert into airport(airport_name,airport_location)
Values
('YYC','Calgary')
Insert into airport(airport_name,airport_location)
Values
('LAX','Los Angeles')
Insert into airport(airport_name,airport_location)
Values
('ATL','Atlanta')
Insert into airport(airport_name,airport_location)
Values
('NYC','New York City')
Insert into airport(airport_name,airport_location)
Values
('DDD','D Block D')
end

Go
IF  EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'dbo.FlightData') AND type in (N'U'))
Begin
INSERT INTO [FlightInformation].[dbo].[FlightData]
           ([airline_id]
           ,[gate_id]
           ,[destination_airport_id]
           ,[takeoff_airport_id]
           ,[departure_time]
           ,[flight_number])
     VALUES
           (1
           ,3
           ,2
           ,1
           ,'2016-03-21 02:30:00.000'
           ,'FN1')

INSERT INTO [FlightInformation].[dbo].[FlightData]
           ([airline_id]
           ,[gate_id]
           ,[destination_airport_id]
           ,[takeoff_airport_id]
           ,[departure_time]
           ,[flight_number])
     VALUES
           (3
           ,2
           ,3
           ,1
           ,'2016-03-21 10:10:00.000'
           ,'FN2')
INSERT INTO [FlightInformation].[dbo].[FlightData]
           ([airline_id]
           ,[gate_id]
           ,[destination_airport_id]
           ,[takeoff_airport_id]
           ,[departure_time]
           ,[flight_number])
     VALUES
           (2
           ,1
           ,4
           ,1
           ,'2016-03-21 04:44:00.000'
           ,'FN3')
INSERT INTO [FlightInformation].[dbo].[FlightData]
           ([airline_id]
           ,[gate_id]
           ,[destination_airport_id]
           ,[takeoff_airport_id]
           ,[departure_time]
           ,[flight_number])
     VALUES
           (1
           ,2
           ,2
           ,1
           ,'2016-03-21 07:47:00.000'
           ,'FN4')
End