-- comment.sql
show tables;

SELECT * FROM tbl_board ORDER BY bno desc;

INSERT INTO tbl_board(bno,title,content,writer)
VALUES(1,'제목-test','내용-test','작성자');

CREATE TABLE IF NOT EXISTS tbl_comment(
	cno INT PRIMARY KEY AUTO_INCREMENT,				-- 댓글번호
	bno INT NOT NULL,								-- 댓글 작성 게시글 번호
	commentText TEXT NOT NULL,						-- 댓글 내용
	commentAuthor VARCHAR(10) NOT NULL,				-- 작성자
	regdate TIMESTAMP NOT NULL DEFAULT now(),		-- 작성시간
	updatedate TIMESTAMP NOT NULL DEFAULT now(),	-- 수정시간
	CONSTRAINT fk_tbl_bno FOREIGN KEY(bno)
	REFERENCES tbl_board(bno),
	INDEX(bno)
); 

SELECT * FROM tbl_comment WHERE bno = 1;

DESC tbl_comment;

SHOW INDEXES FROM tbl_comment;

-- 외래키 정보 확인
SELECT * FROM information_schema.REFERENTIAL_CONSTRAINTS
WHERE table_name =  'tbl_comment';

-- 댓글 삽입
INSERT INTO tbl_comment(bno,commentText,commentAuthor)
VALUES(2,'2번 게시글의 댓글','최기근');

select * from tbl_comment where bno = 2;

DELETE FROM tbl_board WHERE bno = 2;

-- 기존 제약 조건 삭제
ALTER TABLE tbl_comment DROP CONSTRAINT fk_tbl_bno;


-- CASCADE 가 추가된 제약조건 추가
ALTER TABLE tbl_comment ADD CONSTRAINT fk_tbl_bno FOREIGN KEY(bno)
REFERENCES tbl_board(bno) ON DELETE CASCADE;