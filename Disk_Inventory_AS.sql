/******************************************************
* Name				Date				Description
* Aaron Smith		2/28/19				Initial development of disk_inventory
******************************************************/
use master
go

IF DB_ID('DiskInventoryAS') IS NOT NULL
	DROP DATABASE DiskInventoryAS
GO

create database diskInventoryAS
go

use diskInventoryAS
go

CREATE TABLE genre
	(
	genre_id int NOT NULL identity Primary key,
	description nvarchar(100) not null
	)
GO

CREATE TABLE diskStatus
	(
	status_id int NOT NULL identity Primary key,
	description nvarchar(100) not null
	)
GO

CREATE TABLE diskType
	(
	disk_type_id int NOT NULL identity Primary key,
	description nvarchar(100) not null
	)
GO

CREATE TABLE artistType
	(
	artist_type_id int NOT NULL identity Primary key,
	description nvarchar(100) not null
	)
GO

CREATE TABLE borrower
	(
	borrower_id int NOT NULL identity Primary key,
	fname nvarchar(100) not null,
	lname nvarchar(100) not null,
	phoneNumber nvarchar(50) not null,
	)
GO

CREATE TABLE artist
	(
	artist_id int NOT NULL identity Primary key,
	fname nvarchar(100) not null,
	lname nvarchar(100) null,
	artist_type int not null foreign key references artistType(artist_type_id)
	)
GO

CREATE TABLE disk
	(
	disk_id int NOT NULL identity Primary key,
	description nvarchar(100) not null
	)
GO

CREATE TABLE diskHasBorrower
	(
	DownloadDate datetime NOT NULL
	)
GO
CREATE TABLE diskHasArtist
	(
	disk_id int NOT NULL identity Primary key,
	description nvarchar(100) not null
	)
GO
