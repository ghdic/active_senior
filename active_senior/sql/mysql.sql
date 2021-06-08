
CREATE database active_senior;
use active_senior;
/* user 테이블 생성 */
create table user (
      userID varchar (30) not null PRIMARY KEY,
      userPW varchar (255) not null, /* ID + 솔트 +해쉬64자리 */
      userName varchar (30) not null unique,
      userGender varchar (20) default '',
      userEmail varchar (100) default '',
      userProfile varchar (50) default '',
      userAuthority int default 1 not null /* 0: 관리자, 1: 일반유저 */
);

insert into user values('test', 'test', 'testname', '남자', 'test@test.com', 'sample_profile.png', 1);

/* 특정 행 삭제 */
-- delete from user where userID="test"

/* 컬럼 추가 */
-- alter table user add userAuthority int not null default 1;

/*
/* 컬럼 추가 */
alter table [테이블명] add [컬럼명] [타입] [옵션];
ex) alter table [테이블명] add [컬럼명] varchar(100) not null default '0';

/* 컬럼 삭제 */
alter table [테이블명] drop [컬럼명];

/* 컬럼명 변경 및 타입 변경 */
alter table [테이블명] change [컬럼명] [변경할컬럼명] varchar(12);

/* 컬럼 타입 수정 */
alter table [테이블명] modify [컬럼명] varchar(14);

/* 테이블명 수정 */
alter table [테이블명] rename [변경할테이블명];

/* 테이블 삭제 */
drop table [테이블명];
*/


create table hireBbs
(
    bbsID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userID varchar(20) not null,
    userName varchar(20) default '',
    bbsDate datetime default now(),
    bbsTitle text, /* 64kb */
    bbsContent mediumtext, /* ~ 16mb */
    bbsAvailable int not null default 1, /* 0: 비활성화, 1: 활성화 */
    bbsView int not null default 0,
    bbsRecommend int not null default 0,
    bbsThumbnail varchar(50) not null default '',
    bbsState varchar(20) not null default "", /* 종료, 신청·접수중, 마감, 공지  */
    recruitNum int,
    agency varchar (50),
    department varchar (50),
    recruitStart datetime,
    recruitEnd datetime,
    eduStart datetime,
    eduEnd datetime,
    activeStart datetime,
    activeEnd datetime,
    realFileName text,
    originalFileName text
);

insert into hireBbs (userID, userName, bbsDate, bbsTitle, bbsContent, bbsThumbnail, bbsState, recruitNum, agency, department, recruitStart, recruitEnd, eduStart, eduEnd, activeStart, activeEnd, realFileName, originalFileName) values ('test', 'test', '2011-11-11', 'hi', 'hello', '111.png', 'rere', 3, 'aaa', 'department', '2012-11-01', '2012-11-03', '2012-12-12', '2012-12-13', '2015-12-11', '2015-12-12', '111', '111');

-- bbsSummary
create table hireEvent (
    userID varchar (30),
    bbsID int,
    registerDate datetime default now(),
    eventState int not null default 1, /* 0: 비활성화, 1: 활성화 */
    foreign key userID references user(userID) on delete cascade on update cascade,
    foreign key bbsID references hire_bbs(bbsID) on delete cascade on update cascade
)

create table eduBbs
(
    bbsID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userID varchar(20) not null,
    userName varchar(20) default '',
    bbsDate datetime default now(),
    bbsTitle text, /* 64kb */
    bbsContent mediumtext, /* ~ 16mb */
    summary text,
    bbsAvailable int not null default 1, /* 0: 비활성화, 1: 활성화 */
    bbsView int not null default 0,
    bbsRecommend int not null default 0,
    bbsThumbnail varchar(50) not null default '',
    bbsCategory int default 0, /* 0:교육영상, 1:교육후기 */
    tag text,
    keyword text,
    campus text
);

ALTER DATABASE [DB명] CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
ALTER TABLE [column명] CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


create table infoBbs
(
    bbsID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userID varchar(20) not null,
    userName varchar(20) default '',
    bbsDate datetime default now(),
    bbsTitle text, /* 64kb */
    bbsContent mediumtext, /* ~ 16mb */
    summary text,
    bbsAvailable int not null default 1, /* 0: 비활성화, 1: 활성화 */
    bbsView int not null default 0,
    bbsRecommend int not null default 0,
    bbsThumbnail varchar(50) not null default '',
    bbsCategory int default 0, /* 0:공지/채용정보, 1:지원사업, 2:이벤트 */
    tag text,
    keyword text,
    realFileName text,
    originalFileName text
);

create table hobbyBbs
(
    bbsID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userID varchar(20) not null,
    userName varchar(20) default '',
    bbsDate datetime default now(),
    bbsTitle text, /* 64kb */
    bbsContent mediumtext, /* ~ 16mb */
    summary text,
    bbsAvailable int not null default 1, /* 0: 비활성화, 1: 활성화 */
    bbsView int not null default 0,
    bbsRecommend int not null default 0,
    bbsThumbnail varchar(50) not null default '',
    bbsCategory int default 0, /* 0:사람책, 1:여행, 2:건강 3:재무 4:문화라이프*/
    tag text,
    keyword text
);



create table communityBbs
(
    bbsID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userID varchar(20) not null,
    userName varchar(20) default '',
    bbsDate datetime default now(),
    bbsTitle text, /* 64kb */
    bbsContent mediumtext, /* ~ 16mb */
    summary text,
    bbsAvailable int not null default 1, /* 0: 비활성화, 1: 활성화 */
    bbsView int not null default 0,
    bbsRecommend int not null default 0,
    bbsThumbnail varchar(50) not null default '',
    bbsCategory int default 0,
    tag text,
    keyword text,
    realFileName text,
    originalFileName text
);

create table communityComment
(
    commentID int AUTO_INCREMENT primary key,
    bbsID int,
    userID varchar(20) not null,
    userName varchar(20) default '',
    parentID int default 0,
    commentDate datetime default now(),
    comment text
);

create table recommendTable(
    bbsID int,
    userID varchar(20) not null
);