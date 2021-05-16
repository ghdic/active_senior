
CREATE database active_senior;
use active_senior;
/* user 테이블 생성 */
create table user (
                      userID varchar (30) not null PRIMARY KEY,
                      userPW varchar (255) not null, /* ID + 솔트 +해쉬64자리 */
                      userName varchar (30) not null unique,
                      userGender varchar (20) default '성별',
                      userEmail varchar (100) default '',
                      userProfile varchar (50) default 'default_profile.png',
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


create table hire_bbs
(
    bbsID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userName varchar(20) not null,
    bbsDate datetime default now(),
    bbsTitle text, /* 64kb */
    bbsContent mediumtext, /* ~ 16mb */
    bbsSummary text,
    bbsAvailable int not null default 1, /* 0: 비활성화, 1: 활성화 */
    bbsView int not null default 0,
    bbsRecommend int not null default 0,
    bbsThumbnail varchar(50) not null default 'default_thumbnail.png',
    bbsState int not null default 0, /* 0: 아무것도아님 1: 종료 2: 진행중 3: 마감 4: 공지  */
    recruit_num int,
    agency varchar (50),
    department varchar (50),
    recruit_start datetime,
    recruit_end datetime,
    edu_start datetime,
    edu_end datetime,
    active_start datetime,
    active_end datetime,
    files text
);

insert into hire_bbs (bbsTitle, userID, bbsContent, eventState, bbsAvailable) values ("test_title", "test", "<h1>My first post</h1>", 0, 1);


create table hire_event (
    userID varchar (30),
    bbsID int,
    registerDate datetime default now(),
    eventState int not null default 1, /* 0: 비활성화, 1: 활성화 */
    foreign key userID references user(userID) on delete cascade on update cascade,
    foreign key bbsID references hire_bbs(bbsID) on delete cascade on update cascade
)



create table edu_bbs
(
    bbsID        int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    bbsTitle     text, /* 64kb */
    userID       varchar(20) not null,
    bbsDate      datetime default now(),
    bbsContent   mediumtext, /* ~ 16mb */
    eventState   int not null default 0, /* 0: 아무것도아님 1: 종료 2: 진행중 3: 마감 4: 공지  */
    bbsAvailable int not null default 1, /* 0: 비활성화, 1: 활성화 */
    bbsView int not null default 0,
    bbsRecommend int not null default 0,
    bbsThumbnail varchar(50) not null default 'default_thumbnail.png'
);