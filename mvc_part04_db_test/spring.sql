CREATE DATABASE digital_spring;

USE digital_spring;

CREATE TABLE IF NOT EXISTS tbl_member(
	uno int PRIMARY KEY AUTO_INCREMENT,
	userid VARCHAR(50) NOT NULL UNIQUE,
	userpw VARCHAR(50) NOT NULL,
	username VARCHAR(45) NOT NULL,
	regdate TIMESTAMP default now(),
	updatedate TIMESTAMP default now()
);

drop table tbl_member;
select * from tbl_member;
desc tbl_member;