create database StarSecurity
go

use StarSecurity
go

create table Role
(
	roleID int identity not null,
	nameRole varchar(100) not null,

	constraint PK_Role primary key (roleID)
)
go

create table Status
(
	statusID int identity not null,
	statusName varchar(50) not null,

	constraint PK_Status primary key (statusID)
)
go

create table SocialNetwork
(
	socialNetworkID int identity not null,
	socialNetworkName varchar(100) not null

	constraint PK_SocialNetwork primary key (socialNetworkID),
)
go

create table StatusAccount
(
	statusAccountID int identity not null,
	statusAccountName varchar(50) not null,

	constraint PK_StatusAccount primary key (statusAccountID)
)
go

create table Account
(
	userName varchar(50) not null,
	password varchar(max) not null,
	name nvarchar(100) not null,
	address nvarchar(500),
	dayOfBirth date,
	phoneNumber varchar(20),
	email varchar(500) not null,
	gender bit not null,
	imageURL varchar(max),
	role int not null,
	statusAccountID int not null,

	constraint PK_Account primary key (userName),

	-- constraint FR_Account_Status foreign key (status) references Status (statusID),
	constraint FR_Account_Role foreign key (role) references Role (roleID),
	constraint FR_Account_StatusAccount foreign key (statusAccountID) references StatusAccount (statusAccountID)
)
go

create table SocialNetworkAccount
(
	accountID varchar(300) not null,
	userName varchar(50) not null,
	socialNetworkID int not null

	constraint PK_SocialNetworkAccount primary key (accountID),

	constraint FR_SocialNetworkAccount_Account foreign key (userName) references Account (userName),
	constraint FR_SocialNetworkAccount_SocialNetwork foreign key (socialNetworkID) references SocialNetwork (socialNetworkID)
)
go

create table Team
(
	teamID int identity not null,
	nameTeam varchar(100) not null,
	supportCelebrity varchar(50) not null,
	createDate datetime not null,
	isActive bit not null

	constraint PK_Team primary key (teamID)

	constraint FR_Team_Account foreign key (supportCelebrity) references Account (userName)
)
go

create table TeamMember
(
	teamID int not null,
	userName varchar(50) not null,
	isTeamLeader bit not null

	constraint PK_TeamMember primary key (teamID, userName)

	constraint FR_TeamMember_Team foreign key (teamID) references Team (teamID),
	constraint FR_TeamMember_Account foreign key (userName) references Account (userName)
)
go

create table Issue
(
	issueID int identity not null,
	issueName varchar(300) not null,
	isActive bit not null,

	constraint PK_Issue primary key (issueID)

	-- constraint FR_Issue_Status foreign key (status) references Status (statusID),
)
go

create table Request
(
	requestID int not null identity,
	ownerRequest varchar(50) not null,
	teamResponse int,
	urlOfArticle varchar(300),
	imageURL varchar(300),
	issueID int,
	requestContent ntext,
	createDate datetime not null,
	status int not null

	constraint PK_Request primary key (requestID)

	constraint FR_Request_Status foreign key (status) references Status (statusID),
	constraint FR_Request_Issue foreign key (issueID) references Issue (issueID),
	constraint FR_Request_Account foreign key (ownerRequest) references Account (userName),
	constraint FR_Request_Team foreign key (teamResponse) references Team (teamID)
)
go

create table FanPage
(
	fanpageID varchar(300) not null,
	fanpageURL varchar(300) not null,
	name nvarchar(100) not null,
	owner varchar(50),
	socialNetworkID int,
	isAnti bit not null,
	isActive bit not null

	constraint PK_FanPage primary key (fanpageID)

	constraint FR_FanPage_Account foreign key (owner) references Account (userName),
	constraint FR_FanPage_SocialNetwork foreign key (socialNetworkID) references SocialNetwork (socialNetworkID)
)
go

create table SocialNetworkGroup
(
	groupID varchar(300) not null,
	groupURL varchar(300) not null,
	name nvarchar(100) not null,
	owner varchar(50),
	socialNetworkID int,
	isAnti bit not null,
	isActive bit not null

	constraint PK_SocialNetworkGroup primary key (groupID)

	constraint FR_FanPage_SocialNetworkGroup foreign key (owner) references Account (userName),
	constraint FR_SocialNetworkGroup_SocialNetwork foreign key (socialNetworkID) references SocialNetwork (socialNetworkID)
)
go

create table Article
(
	articleID varchar(300) not null,
	articleURL varchar(300) not null,
	imageURL varchar(300),
	articleContent ntext,
	createDate datetime not null,
	accountID varchar(300),
	fanpageID varchar(300),
	groupID varchar(300)

	constraint PK_Article primary key (articleID)

	constraint FR_Article_SocialNetworkAccount foreign key (accountID) references SocialNetworkAccount (accountID),
	constraint FR_Article_Account foreign key (fanpageID) references FanPage (fanpageID),
	constraint FR_Article_SocialNetworkGroup foreign key (groupID) references SocialNetworkGroup (groupID)
)
go

--create table CelebrityArticle
--(
--	articleID varchar(300) not null,
--	accountID varchar(300) not null

--	constraint PK_CelebrityArticle primary key (articleID)

--	constraint FR_CelebrityArticle_Article foreign key (articleID) references Article (articleID),
--	constraint FR_CelebrityArticle_SocialNetworkAccount foreign key (accountID) references SocialNetworkAccount (accountID)
--)
--go

--create table FanpageArticle
--(
--	articleID varchar(300) not null,
--	fanpageID varchar(300) not null

--	constraint PK_FanpageArticle primary key (articleID)

--	constraint FR_FanpageArticle_Article foreign key (articleID) references Article (articleID),
--	constraint FR_FanpageArticle_FanPage foreign key (fanpageID) references FanPage (fanpageID)
--)
--go

--create table GroupArticle
--(
--	articleID varchar(300) not null,
--	groupID varchar(300) not null

--	constraint PK_GroupArticle primary key (articleID)

--	constraint FR_GroupArticle_Article foreign key (articleID) references Article (articleID),
--	constraint FR_GroupArticle_SocialNetworkGroup foreign key (groupID) references SocialNetworkGroup (groupID)
--)
--go

create table ResultRequest
(
	resultRequestID int identity not null,
	requestID int not null,
	resolver varchar(50) not null,
	resolveDate datetime not null

	constraint PK_ResultRequest primary key (resultRequestID)

	constraint FR_ResultRequest_Request foreign key (requestID) references Request (requestID),
	constraint FR_ResultRequest_Account foreign key (resolver) references Account (userName)
)
go

create table ResultProtect
(
	resultDailyProtectID int identity,
	articleID varchar(300) not null,
	resolver varchar(50) not null,
	resolveDate datetime not null,
	isDone bit not null

	constraint PK_ResultDailyProtect primary key (resultDailyProtectID)

	constraint FR_ResultDailyProtect_Request foreign key (articleID) references Article (articleID),
	constraint FR_ResultDailyProtect_Account foreign key (resolver) references Account (userName)
)
go

create table Job
(
	jobID int not null identity,
	jobContent ntext,
	requestID int not null,
	userName varchar(50) not null,
	assignDate datetime not null,
	isDone bit not null

	constraint PK_Job primary key (jobID)

	constraint FR_Job_Request foreign key (requestID) references Request (requestID),
	constraint FR_Job_Account foreign key (userName) references Account (userName)
)
go