#### itstagram
##### 인스타그램

***

#### 팀원
##### 이보름, 최민준

***

####역할
##### 이보름 : 회원가입, 로그인, 게시물 등록/수정/삭제
##### 최민준 : 메인페이지, 좋아요, 팔로우, 댓글

***

#### DB
```
CREATE USER itstargram IDENTIFIED BY 1111

GRANT CONNECT, RESOURCE, DBA TO itstargram;

-- SEQUENCE 생성
CREATE SEQUENCE seq_member;
CREATE SEQUENCE seq_board;
CREATE SEQUENCE seq_comment;
```

#### 회원
```
CREATE TABLE member(
	num NUMBER(4) PRIMARY KEY, -- 고유 번호
	id VARCHAR2(15) NOT NULL, -- ID
	pwd VARCHAR2(30) NOT NULL, -- 비밀번호
	name VARCHAR2(15), -- 이름(닉네임)
	email VARCHAR2(50) NOT NULL, -- 이메일
	tel VARCHAR2(11), -- 전화번호
	profile VARCHAR2(100), -- 프로필 사진(파일명)
	follow_json CLOB DEFAULT '', -- 팔로워 목록(JSON)
	saved_list CLOB DEFAULT '', -- 저장한 글 목록
	tagged_list CLOB DEFAULT '' -- 태그된 글 목록
);
```

#### 게시물
```
CREATE TABLE board(
	num NUMBER(4) PRIMARY KEY, -- 고유 번호
	member_num NUMBER(4) NOT NULL, -- 글쓴이_고유 번호
	content CLOB NOT NULL, -- 본문 내용
	photos CLOB DEFAULT '', -- 사진(파일명) 목록
	regdate TIMESTAMP NOT NULL, -- 작성일
	hearts CLOB DEFAULT '' -- 좋아요 목록(JSON)
);
```

#### 댓글
```
CREATE TABLE comment_b(
	num NUMBER(4) PRIMARY KEY, -- 고유 번호
	member_num NUMBER(4) NOT NULL, -- 글쓴이_고유 번호
	ref_board NUMBER(4) NOT NULL, -- 참조 게시글_고유 번호
	ref_comment NUMBER(4), -- 참조 댓글_고유 번호
	content CLOB NOT NULL, -- 댓글 내용
	regdate TIMESTAMP NOT NULL, -- 작성일
	hearts NUMBER(4) DEFAULT 0 -- 좋아요 갯수
);
```
