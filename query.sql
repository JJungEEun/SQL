-- *****************1*****************
CREATE TABLE student(
sno NUMBER(5,0), 
pno NUMBER(5,0),
sname VARCHAR2(20),
year VARCHAR2(4),
dept VARCHAR2(4),
PRIMARY KEY (sno),
CONSTRAINT c_pno_fk FOREIGN KEY (pno) REFERENCES professor(pno) ON DELETE SET NULL
);
INSERT INTO student VALUES (1000, 1900, 'eun', 4.0, 'DT');
INSERT INTO student VALUES (1001, 1900, 'jenny', 4.0, 'DT');
INSERT INTO student VALUES (1002, 1901, 'jin', 4.0, 'DT');
INSERT INTO student VALUES (1003, 1901, 'alice', 3.0, 'DT');
INSERT INTO student VALUES (1004, 1257, 'jack', 4.0, 'IC');
INSERT INTO student VALUES (1005, 1257, 'min', 4.0, 'IC');
INSERT INTO student VALUES (1006, 1257, 'mihee', 4.0, 'IC');
INSERT INTO student VALUES (1007, 1900, 'bob', 4.0, 'DT');
INSERT INTO student VALUES (1008, 1534, 'ash', 4.0, 'CE');
INSERT INTO student VALUES (1009, 1534, 'jhon', 4.0, 'CE');

CREATE TABLE professor(
pno NUMBER(5,0),
pname VARCHAR2(20),
pmajor VARCHAR2(20),
pdept VARCHAR2(4),
PRIMARY KEY (pno)
);
insert into professor values (1900, 'jason', 'DT1', 'DT');
insert into professor values (1901, 'soheon', 'DT2', 'DT');
insert into professor values (1902, 'liam', 'DT3', 'DT');
insert into professor values (1903, 'noah', 'DT4', 'DT');
insert into professor values (1904, 'wiliam', 'CS6', 'CS');
insert into professor values (1905, 'lucas', 'CS7', 'CS');
insert into professor values (1906, 'ethan', 'CS8', 'CS');
insert into professor values (1907, 'lucas', 'EE6', 'EE');
insert into professor values (1908, 'julia', 'EE7', 'EE');
insert into professor values (1909, 'dan', 'DB', 'CE');
insert into professor values (1910, 'alex', 'DB', 'CE');
insert into professor values (1911, 'jisoo', 'DS', 'IC');

CREATE TABLE course(
cno VARCHAR2(10), 
cname VARCHAR2(50),
credit VARCHAR2(1),
sessions VARCHAR2(1),
PRIMARY KEY (cno)
);
insert into course values ('DT001', 'DataBase', 3, 1);
insert into course values ('DT002', 'Python', 3, 1);
insert into course values ('DT003', 'Machine Learning', 3, 1);
insert into course values ('DT004', 'Bigdata Programming', 3, 2);
insert into course values ('DT005', 'programming1', 3, 2);
insert into course values ('DT006', 'programming2', 3, 2);
insert into course values ('ME006', 'Korean', 3, 1);
insert into course values ('IC007', 'English2', 3, 2);
insert into course values ('SE007', 'baseball', 3, 2);
insert into course values ('CE014', 'math and science', 3, 1);

CREATE TABLE enroll(
sno NUMBER(5,0), 
cno VARCHAR2(10),
grade VARCHAR2(1),
exam NUMBER(3),
PRIMARY KEY(sno, cno),
CONSTRAINT c_cno2_fk  FOREIGN KEY (cno) REFERENCES course(cno) ON DELETE SET NULL,
CONSTRAINT c_sno2_fk FOREIGN KEY (sno) REFERENCES student(sno) ON DELETE SET NULL
);
insert into enroll values (1000, 'DT001', 'A', 100);
insert into enroll values (1001, 'DT001', 'A', 98);
insert into enroll values (1000,'DT002', 'A', 96);
insert into enroll values (1001, 'DT002', 'B', 78);
insert into enroll values (1000,'DT003', 'B', 80);
insert into enroll values (1002,'DT003', 'C', 65);
insert into enroll values (1000,'DT004', 'A', 90);
insert into enroll values (1002, 'DT004', 'A', 95);
insert into enroll values (1000,'DT005', 'B', 88);
insert into enroll values (1003, 'DT006', 'B', 89);
insert into enroll values (1005, 'DT005', 'A', 89);
insert into enroll values (1005, 'DT006', 'A', 89);

CREATE TABLE lecture(
cno VARCHAR2(10),
pno NUMBER(5,0),
lec_time VARCHAR2(10),
room VARCHAR2(10),
PRIMARY KEY(cno, pno),
CONSTRAINT c_cno_fk  FOREIGN KEY (cno) REFERENCES course(cno) ON DELETE SET NULL,
CONSTRAINT c_pno2_fk FOREIGN KEY (pno) REFERENCES professor(pno) ON DELETE SET NULL
);
select * from lecture;
insert into lecture values ('DT001',1900, 'TUE123','Y103');
insert into lecture values ('DT002',1900, 'TUE789','Y103');
insert into lecture values ('DT003',1901, 'MON456','Y103');
insert into lecture values ('DT005',1901, 'TUE345','Y104');
insert into lecture values ('DT006',1901, 'TUE678','Y104');
insert into lecture values ('SE003', 1402, 'MON789','Y1001');
insert into lecture values ('SE002', 1403, 'FRI234','Y1002');
insert into lecture values ('ME006', 1301, 'FRI234','Y1003');
insert into lecture values ('SE007', 1401, 'THI456','Y1004');


-- a. Retrieve names of all senior students in the 'DT' (Data Technology) department.
select sname from student where year=4.0 and dept='DT';
-- b. Retrieve names of all courses taught by Professor 'Jonghoon Chun
select cname from course c, professor p, lecture l where pname='Jonghoon Chun' and c.cno=l.cno and l.pno=p.pno;
-- c. Retrieve names and majors of all straight 'A' students (students who have a grade 'A' in all their courses.) 	
select sname, dept from student s where not exists (select * from enroll where sno=s.sno and not(GRADE='A'));
-- d. Retrieve names and majors of all students who do not have a grade 'A' in any of their courses.
select sname, dept from student s where not exists (select * from enroll where sno=s.sno and grade='A');
-- e. Delete all courses offered by 'CE' (Computer Engineering) department.
delete from course where cno in (select c.cno from course c, lecture l, professor p where c.cno =l.cno and p.pno=l.pno and pdept='CE');



-- *****************2*****************
CREATE TABLE DEPARTMENT(
dnumber NUMBER(5), 
dname VARCHAR2(20), 
mgrstartdate VARCHAR2(15), 
dlocation VARCHAR2(10),
PRIMARY KEY(dnumber));
insert into department values (1000, 'A', '11/14/2022', 'KOREA');
insert into department values (1001, 'B', '11/10/2022', 'KOREA');
insert into department values (1002, 'C', '11/10/2022', 'KOREA');
insert into department values (1003, 'D', '11/10/2022', 'KOREA');
insert into department values (1004, 'E', '11/05/2020', 'KOREA');
insert into department values (1005, 'F', '1/14/2020', 'KOREA');
insert into department values (1006, 'G', '9/4/2019', 'KOREA');
insert into department values (1007, 'S', '7/14/2012', 'KOREA');
insert into department values (1008, 'H', '9/24/2011', 'KOREA');
insert into department values (1009, 'I', '11/10/2018', 'KOREA');
insert into department values (1010, 'J', '7/14/2011', 'KOREA');

CREATE TABLE PROJECT(
pnumber NUMBER(5), 
pname VARCHAR2(30), 
plocation VARCHAR2(10),
PRIMARY KEY(pnumber));
select * from project;
insert into project values (4001, 'web1', 'KOREA');
insert into project values (4002, 'web2', 'KOREA');
insert into project values (4003, 'web3', 'KOREA');
insert into project values (4004, 'web4', 'KOREA');
insert into project values (4005, 'web5', 'KOREA');
insert into project values (4006, 'app1', 'KOREA');
insert into project values (4007, 'app2', 'KOREA');
insert into project values (4008, 'app3', 'KOREA');
insert into project values (4009, 'app4', 'KOREA');
insert into project values (4010, 'app5', 'KOREA');


CREATE TABLE employee (
ssn NUMBER(5), 
fname VARCHAR2(30), 
lname VARCHAR2(30), 
bdate VARCHAR2(30), 
address VARCHAR2(30), 
sex VARCHAR2(1), 
salary NUMBER(10), 
superssn NUMBER(5), 
dno NUMBER(5),
PRIMARY KEY (ssn),
CONSTRAINT c_dno_fk FOREIGN KEY (dno) REFERENCES department(dnumber) ON DELETE SET NULL
);
alter table employee add FOREIGN KEY (superssn) REFERENCES employee(ssn) ON DELETE SET NULL;
insert into employee values(180,'Jung','Eun','09/09/2000', 'INCHEON', 'M', 10000, 146, 1000); 
insert into employee values(181,'Jung','Min','09/09/2010', 'INCHEON', 'F', 8000, 146, 1000); 
insert into employee values(182,'Jung','Jun','09/09/2011', 'INCHEON', 'F', 7800, 146, 1008); 
insert into employee values(183,'Jung','Jin','09/09/2012', 'INCHEON', 'F', 7500, 146, 1008); 
insert into employee values(184,'Jung','Jaemin','09/09/2020', 'INCHEON', 'M', 60000, 147, 1008); 
insert into employee values(185,'Jung','Jimin','09/09/2020', 'INCHEON', 'M', 5000, 147, 1010); 
insert into employee values(186,'Jung','Jiwoo','09/09/2020', 'INCHEON', 'M', 3800, 147, 1001); 
insert into employee values(187,'Jung','Minju','09/09/2021', 'INCHEON', 'F', 4000, 148, 1000); 
insert into employee values(188,'Jung','sang','09/09/2021', 'INCHEON', 'F', 5500, 148, 1002); 
insert into employee values(189,'Jung','chung','09/09/2022', 'INCHEON', 'F', 7000, 148, 1003); 
insert into employee values(190,'Jung','jihee','09/09/2022', 'INCHEON', 'M', 8000, 148, 1004); 

CREATE TABLE works_on (
ssn NUMBER(5),
pnumber NUMBER(5),
hours NUMBER(5),
PRIMARY KEY (ssn, pnumber),
CONSTRAINT c_ssn_fk FOREIGN KEY(ssn) references EMPLOYEE(ssn) ON DELETE SET NULL, 
CONSTRAINT c_pnum_fk FOREIGN KEY(pnumber) references PROJECT(pnumber)  ON DELETE SET NULL
);
insert into works_on values (180, 3321, 10);
insert into works_on values (181, 3344, 9);
insert into works_on values (182, 3377, 18);
insert into works_on values (183, 4001, 10);
insert into works_on values (184, 4001, 8);
insert into works_on values (185, 4001, 7);
insert into works_on values (186, 4001, 11);
insert into works_on values (187, 3377, 11);
insert into works_on values (188, 3399, 15);
insert into works_on values (189, 3377, 11);
insert into works_on values (190, 3333, 10);
insert into works_on values (180, 3344, 10);
insert into works_on values (180, 3373, 10);
insert into works_on values (180, 3377, 10);
insert into works_on values (180, 3388, 10);
insert into works_on values (180, 3399, 10);
insert into works_on values (180, 3333, 10);
insert into works_on values (180, 3311, 10);
insert into works_on values (180,4001, 10);
insert into works_on values (180,4002, 10);
insert into works_on values (180,4003, 10);
insert into works_on values (180,4004, 10);
insert into works_on values (180,4005, 10);
insert into works_on values (180,4006, 10);
insert into works_on values (180,4007, 10);
insert into works_on values (180,4008, 10);
insert into works_on values (180,4009, 10);
insert into works_on values (180,4010, 10);


--  a)	Retrieve names of employees in department '3' who work more than 10 hours per week on the 'Y' project.
select concat(concat(trim(e.fname),' '),trim(e.lname)) as name from employee e, works_on w, project p where e.dno='3' 
and e.ssn=w.ssn and w.pnumber=p.pnumber and p.pname='Y' and hours > 10;
--	b)	Retrieve names of employees who are directly supervised by 'Jonghoon Chun'.
select concat(concat(trim(e1.fname),' '),trim(e1.lname)) as name from employee e1, employee e2 where e1.superssn = e2.ssn 
and e2.fname='Jonghoon' and e2.lname='Chun';
--	c)	For each project, list the project name and the total hours (by all employees) spent on that project.
select pname, sum(hours) as total_work_time from project p, works_on w where w.pnumber=p.pnumber group by pname;
--	d)	Retrieve names of employees who work on every project.
select  concat(concat(trim(e.fname),' '),trim(e.lname)) as name from employee e where not exists ((select pnumber p from project)
Minus (select pnumber from works_on w where e.ssn=w.ssn));
--	e)	Retrieve names of employees who do not work on any project.
select concat(concat(trim(e.fname),' '),trim(e.lname)) as name from employee e where not exists (select w.ssn from works_on w where e.ssn = w.ssn);
--	f)	For each department, retrieve the department numbers and names, and the average salary of employees working in that department.
select d.dname, avg(salary) as avg_sal from employee e, department d where e.dno = d.dnumber group by d.dname;
--	g)	Retrieve the average salary of all female employees.
select avg(salary) as avg_sal from (select * from employee where sex='F');
--	h)	Find the names and addresses of employees who work on at least one project located in 'Seoul' but whose department has no location in 'Seoul'.
select concat(concat(trim(e.fname),' '),trim(e.lname)) as name, address from works_on w, project p, employee e 
where w.pnumber = p.pnumber and p.plocation='SEOUL' and e.ssn = w.ssn
MINUS
select  concat(concat(trim(e.fname),' '),trim(e.lname)) as name, address from department d, employee e where d.dlocation !='SEOUL' and e.dno =d.dnumber;

-- *****************3*****************
CREATE TABLE WAREHOUSE(
code VARCHAR2(4), 
address VARCHAR2(30), 
phone VARCHAR2(15),
PRIMARY KEY(code)
);
insert into warehouse values('E01','인천 중구 운서동', '032-111-1111');
insert into warehouse values('E02','인천 중구 운남동', '032-111-1112');
insert into warehouse values('E03','인천 중구 운북동', '032-111-1113');
insert into warehouse values('E04','인천 중구 중산동', '032-111-1114');
insert into warehouse values('E05','인천 중구 진황동', '032-111-1115');
insert into warehouse values('E06','인천 중구 중동', '032-111-1116');
insert into warehouse values('E07','인천 중구 진배동', '032-111-1117');
insert into warehouse values('E08','인천 중구 강배동', '032-111-1118');
insert into warehouse values('E09','인천 중구 동화동', '032-111-1119');
insert into warehouse values('E10','인천 중구 신림동', '032-111-1110');


CREATE TABLE STOCKS(
ISBN VARCHAR2(4), 
code VARCHAR2(4), 
num VARCHAR2(10),
PRIMARY KEY(ISBN, code),
CONSTRAINT c_isbn_fk FOREIGN KEY (ISBN) REFERENCES book(ISBN) ON DELETE SET NULL
); 
insert into stocks values(6001, 'A03', 600);
insert into stocks values(6002, 'A03', 300);
insert into stocks values(6003, 'A02', 500);
insert into stocks values(6004, 'A02', 700);
insert into stocks values(6005, 'A01', 800);
insert into stocks values(6006, 'A01', 500);
insert into stocks values(7001, 'A01', 0);
insert into stocks values(7002, 'A02', 300);
insert into stocks values(7003, 'A02', 10);
insert into stocks values(7004, 'A01', 500);


CREATE TABLE AUTHOR(
name VARCHAR2(50), 
address VARCHAR2(50), 
url VARCHAR2(50),
PRIMARY KEY(name, address)
);
insert into author values ('정은', '인천 중구 이편한세상', 'http://www.lovecat4.com');
insert into author values ('정민', '인천 중구 풍림1차', 'http://www.lovecat5.com');
insert into author values ('진', '인천 중구 풍림2차', 'http://www.lovecat6.com');
insert into author values ('소현', '인천 중구 스카이시티자이', 'http://www.lovecat7.com');
insert into author values ('승관', '인천 중구 금호2차', 'http://www.lovecat8.com');
insert into author values ('태연', '인천 중구 금호1차', 'http://www.lovecat9.com');
insert into author values ('혜리', '인천 중구 삼안', 'http://www.lovecat10.com');
insert into author values ('민경', '인천 중구 sk', 'http://www.lovecat11.com');
insert into author values ('지우', '인천 중구 프루지오', 'http://www.lovecat12.com');
insert into author values ('주환', '인천 중구 어울림', 'http://www.lovecat13.com');


drop table written_by;
CREATE TABLE WRITTEN_BY(
name VARCHAR2(50), 
address VARCHAR2(50), 
ISBN VARCHAR2(4),
PRIMARY KEY(name, address, isbn),
CONSTRAINT c_name_fk FOREIGN KEY (name, address) REFERENCES AUTHOR(name, address)ON DELETE SET NULL,
CONSTRAINT c_isbn2_fk FOREIGN KEY (ISBN) REFERENCES book(ISBN) ON DELETE SET NULL
);
insert into written_by values('Gun Ro', '경기 수원시 팔달구 벽산아파트', 6001);
insert into written_by values('Gun Ro', '경기 수원시 팔달구 벽산아파트', 6002);
insert into written_by values('Gun Ro', '경기 수원시 팔달구 벽산아파트', 6003);
insert into written_by values('Gun Ro', '경기 수원시 팔달구 벽산아파트', 6004);
insert into written_by values('Gun Ro', '경기 수원시 팔달구 벽산아파트', 6005);
insert into written_by values('Gun Ro', '경기 수원시 팔달구 벽산아파트', 6006);
insert into written_by values('정은', '인천 중구 이편한세상', 7001);
insert into written_by values('정은', '인천 중구 이편한세상', 7002);
insert into written_by values('정은', '인천 중구 이편한세상', 7003);
insert into written_by values('정은', '인천 중구 이편한세상', 7004);

CREATE TABLE PUBLISHER(
name VARCHAR2(50),
address VARCHAR2(50), 
phone VARCHAR2(30), 
url VARCHAR2(50),
PRIMARY KEY(name)
);
insert into publisher values ('이주환', '경기 수원시 팔달구 십산아파트', '031-111-222', 'http://www.bsicokr1.hotmail.com');
insert into publisher values ('김진표', '경기 수원시 팔달구 일산아파트', '031-111-333', 'http://www.bsicokr2.hotmail.com');
insert into publisher values ('정충신', '경기 수원시 팔달구 이산아파트', '031-111-444', 'http://www.bsicokr3.hotmail.com');
insert into publisher values ('이상희', '경기 수원시 팔달구 삼산아파트', '031-111-555', 'http://www.bsicokr4.hotmail.com');
insert into publisher values ('이진희', '경기 수원시 팔달구 사산아파트', '031-111-666', 'http://www.bsicokr5.hotmail.com');
insert into publisher values ('이주희', '경기 수원시 팔달구 오산아파트', '031-111-777', 'http://www.bsicokr6.hotmail.com');
insert into publisher values ('이재민', '경기 수원시 팔달구 육산아파트', '031-111-888', 'http://www.bsicokr7.hotmail.com');
insert into publisher values ('이미희', '경기 수원시 팔달구 칠산아파트', '031-111-999', 'http://www.bsicokr8.hotmail.com');
insert into publisher values ('김준배', '경기 수원시 팔달구 팔산아파트', '031-111-1010', 'http://www.bsicokr9.hotmail.com');
insert into publisher values ('김지환', '경기 수원시 팔달구 구산아파트', '031-111-1111', 'http://www.bsicokr`0.hotmail.com');


CREATE TABLE PUBLISHED_BY(
name VARCHAR2(30), 
ISBN VARCHAR2(4),
PRIMARY KEY(name, ISBN),
CONSTRAINT c_name2_fk FOREIGN KEY (name) REFERENCES PUBLISHER(name) ON DELETE SET NULL,
CONSTRAINT c_isbn3_fk FOREIGN KEY (ISBN) REFERENCES book(ISBN) ON DELETE SET NULL
);
insert into published_by values('Harry', 6001);
insert into published_by values('Harry', 6002);
insert into published_by values('Harry', 6003);
insert into published_by values('Harry', 6004);
insert into published_by values('Harry', 6005);
insert into published_by values('Harry', 6006);
insert into published_by values('김준배', 7001);
insert into published_by values('김준배', 7002);
insert into published_by values('김준배', 7003);
insert into published_by values('김준배', 7004);


CREATE TABLE BOOK(
ISBN VARCHAR2(4), 
title VARCHAR2(50), 
year VARCHAR2(4), 
price VARCHAR2(10),
PRIMARY KEY(ISBN)
);
insert into book values(6001, '떡볶이 먹고 싶다', 2020, 45000);
insert into book values(6002, '휘낭시에 레시피북', 2019, 30000);
insert into book values(6003, '세계여행, 맛집투어', 2020, 50000);
insert into book values(6004, '사랑일기', 2020, 42000);
insert into book values(6005, '너만 보인단 말이야', 2010, 35000);
insert into book values(6006, '나 너 좋아하냐', 2018, 15000);
insert into book values(7001, '한눈에 보는 머신러닝', 2020, 48000);
insert into book values(7002, '한눈에 보는 데이터베이스', 2020, 48000);
insert into book values(7003, '한눈에 보는 파이썬', 2020, 48000);
insert into book values(7004, '한눈에 보는 빅데이터', 2020, 30000);


CREATE TABLE CONTAINS(
basketid VARCHAR2(10), 
ISBN VARCHAR2(4), 
num VARCHAR2(10), 
PRIMARY KEY(basketid, isbn),
CONSTRAINT c_basketid_fk FOREIGN KEY (basketid) REFERENCES SHOPPING_BASKET(basketid) ON DELETE SET NULL,
CONSTRAINT c_isbn4_fk FOREIGN KEY (ISBN) REFERENCES book(ISBN) ON DELETE SET NULL
);
insert into contains values ('OOO1', 6001, 5);
insert into contains values ('OOO2', 6002, 15);
insert into contains values ('OOO3', 6003, 20);
insert into contains values ('OOO4', 6004, 5);
insert into contains values ('OOO5', 6005, 1);
insert into contains values ('OOO6', 6006, 3);
insert into contains values ('OOO7', 7001, 50);
insert into contains values ('OOO8', 7002, 100);
insert into contains values ('OOO9', 7003, 5);
insert into contains values ('OO10', 7004, 15);


CREATE TABLE SHOPPING_BASKET(
basketid VARCHAR2(10),
PRIMARY KEY(basketid));
select * from shopping_basket;
insert into shopping_basket values ('OOO1');
insert into shopping_basket values ('OOO2');
insert into shopping_basket values ('OOO3');
insert into shopping_basket values ('OOO4');
insert into shopping_basket values ('OOO5');
insert into shopping_basket values ('OOO6');
insert into shopping_basket values ('OOO7');
insert into shopping_basket values ('OOO8');
insert into shopping_basket values ('OOO9');
insert into shopping_basket values ('OO10');


CREATE TABLE BASKET_OF(
email VARCHAR2(30), 
basketid VARCHAR2(10),
PRIMARY KEY(email, basketid),
CONSTRAINT c_email_fk FOREIGN KEY (email) REFERENCES CUSTOMER(email) ON DELETE SET NULL,
CONSTRAINT c_basketid2_fk FOREIGN KEY (basketid) REFERENCES SHOPPING_BASKET(basketid) ON DELETE SET NULL
); 
insert into basket_of values('60191687@mju.ac.kr','OOO1');
insert into basket_of values('60191688@mju.ac.kr','OOO2');
insert into basket_of values('60191689@mju.ac.kr','OOO3');
insert into basket_of values('60191690@mju.ac.kr','OOO4');
insert into basket_of values('60191691@mju.ac.kr','OOO5');
insert into basket_of values('60191692@mju.ac.kr','OOO6');
insert into basket_of values('60191693@mju.ac.kr','OOO7');
insert into basket_of values('60191694@mju.ac.kr','OOO8');
insert into basket_of values('60191695@mju.ac.kr','OOO9');
insert into basket_of values('60191696@mju.ac.kr','OO10');

CREATE TABLE CUSTOMER(
email VARCHAR2(30), 
name VARCHAR2(30), 
address VARCHAR2(30), 
phone VARCHAR2(30),
PRIMARY KEY(email)
);
insert into customer values('60191687@mju.ac.kr','Jelly', '서울 서대문구 123-11', '010 1111 1111');
insert into customer values('60191688@mju.ac.kr','Jelly', '서울 서대문구 123-12', '010 1111 2222');
insert into customer values('60191689@mju.ac.kr','Jelly', '서울 서대문구 123-13', '010 1111 3333');
insert into customer values('60191690@mju.ac.kr','Jelly', '서울 서대문구 123-14', '010 1111 4444');
insert into customer values('60191691@mju.ac.kr','Jelly', '서울 서대문구 123-15', '010 1111 5555');
insert into customer values('60191691@mju.ac.kr','Jelly', '서울 서대문구 123-16', '010 1111 6666');
insert into customer values('60191692@mju.ac.kr','Jelly', '서울 서대문구 123-17', '010 1111 7777');
insert into customer values('60191693@mju.ac.kr','Jelly', '서울 서대문구 123-18', '010 1111 8888');
insert into customer values('60191694@mju.ac.kr','Jelly', '서울 서대문구 123-19', '010 1111 9999');
insert into customer values('60191695@mju.ac.kr','Jelly', '서울 서대문구 123-20', '010 2222 1111');
insert into customer values('60191696@mju.ac.kr','Jelly', '서울 서대문구 123-21', '010 2222 2222');
delete from customer where name='60191686@mju.ac.kr'; 

--	a)	'Rolling J.K' 작가가 2017년에 집필한 도서를 모두 검색 하시오.
select * from author a, book b, written_by w where a.name = 'Rolling J.K' and w.name =a.name and w.isbn = b.isbn and year=2017;
-- b)	'Harry' 출판사에서 출판 된 책들 중 'Gun Ro' 작가가 집필하고 가격이 4만원이 넘는 도서의 제목을 검색 하시오.
select title from published_by p, book b, WRITTEN_BY w where p.name='Harry' and p.isbn =w.isbn and b.isbn=w.isbn and w.name='Gun Ro' and price>40000;
--	c)	'Gun Ro’ 작가가 집필한 도서 중 warehouse에 600부 이상 재고가 있는 도서를 검색 하시오.
select title from stocks s, book b, written_by w where s.isbn =b.isbn and w.isbn=b.isbn and w.name='Gun Ro' and s.num >600;
--	d)	'CCC003' 장바구니에 담긴 책들의 총 가격을 검색 하시오. 
select sum(price) as totla_price from basket_of b,contains c, book bo where b.basketid='CCC003' and b.basketid=c.basketid and c.isbn=bo.isbn;
--	e)	'Park Ji Sung' 고객이 장바구니에 등록한 도서 중 warehouse에 재고가 없는 도서를 검색 하시오.
select title from stocks s, (select isbn from customer c, basket_of b, shopping_basket s, contains co where name='Park Ji Sung' and b.email=c.email 
and s.basketid=b.basketid and co.basketid=s.basketid) a, book b where s.isbn(+)=a.isbn and b.isbn = a.isbn group by title having NVL(SUM(s.num), 0) = 0;




