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
	disk_name nvarchar(100) not null,
	release_date datetime not null,
	status_id int not null foreign key references diskStatus(status_id),
	genre_id int not null foreign key references genre(genre_id),
	disk_type_id int not null foreign key references diskType(disk_type_id)
	)
GO

CREATE TABLE diskHasBorrower
	(
	disk_id int NOT NULL references disk(disk_id),
	borrower_id int NOT NULL references borrower(borrower_id),
	borrowed_date datetime not null,
	returned_date datetime null,
	primary key(disk_id, borrower_id, borrowed_date) 
	)
GO

CREATE TABLE diskHasArtist
	(
	disk_id int NOT NULL references disk(disk_id),
	artist_id int NOT NULL references artist(artist_id),
	primary key(disk_id, artist_id)
	)
GO


use master
go
if Suser_id('diskUserAS') is not null
	drop login diskUserAS
go
create login diskUserAS with password = 'Pa$$w0rd',
		default_database = diskInventoryAS;
go
use diskInventoryAS
go
if User_id('diskUserAS') is not null
	drop user diskUserAS
go
create user diskUserAS
go
alter role db_datareader add member diskUserAS
go