--author
CREATE TABLE author (
    author_id       NUMBER(10),
    author_name     VARCHAR2(100)   NOT NULL,
    author_desc     VARCHAR2(500),
    PRIMARY KEY(author_id)
);

CREATE SEQUENCE seq_author_id
INCREMENT BY 1 
START WITH 1 
nocache;
--book
CREATE TABLE book (
    book_id     NUMBER(10),
    title       VARCHAR2(100)   NOT NULL,
    pubs        VARCHAR2(100),
    pub_date    DATE,
    author_id   NUMBER(10),
PRIMARY KEY(book_id),
CONSTRAINT book_fk FOREIGN KEY (author_id)
REFERENCES author(author_id)
);

CREATE SEQUENCE seq_book_id
INCREMENT BY 1 
START WITH 1 
nocache;

insert into author
values (seq_author_id.nextval, '이문열', '경북 영양');

insert into author
values (seq_author_id.nextval, '박경리', '경상남도 통영');

insert into author
values (seq_author_id.nextval, '유시민', '17대 국회의원');

insert into author
values (seq_author_id.nextval, '기안84', '기안동에서 산 84년생');

insert into author
values (seq_author_id.nextval, '강풀', '온라인 만화가 1세대');

insert into author
values (seq_author_id.nextval, '김영하', '알쓸신잡');



--book
insert into book
values (seq_book_id.nextval, '우리들의 일그러진 영웅', '다림','1998-02-22',1);

insert into book
values (seq_book_id.nextval, '삼국지', '민음사','2002-03-01',1);

insert into book
values (seq_book_id.nextval, '토지', '마로니에북스','2012-08-15',2);

insert into book
values (seq_book_id.nextval, '유시민의 글쓰기 특강', '생각의길','2015-04-01',3);

insert into book
values (seq_book_id.nextval, '패션왕', '중앙북스(books)','2012-02-22',4);

insert into book
values (seq_book_id.nextval, '순정만화', '재미주의','2011-08-03',5);

insert into book
values (seq_book_id.nextval, '오직두사람', '문학동네','2017-05-04',6);

insert into book
values (seq_book_id.nextval, '26년', '재미주의','2012-02-04',5);

SELECT
    b.book_id,
    b.title,
    b.pubs,
    to_char(b.pub_date,'YYYY-MM-DD'),
    a.author_id,
    a.author_name,
    a.author_desc
FROM book b, author a
where b.author_id = a.author_id;

UPDATE author SET author_desc = '서울특별시'
WHERE author_id = 5 ;

DELETE FROM author
WHERE author_id = 4 ; //삭제가 안되는 이유:book이라는 테이블때문에 author가 삭제가안됨



