set heading on
set echo on
set linesize 1500

spool C:\SQL\Project\setup.txt

drop table authorizedSuppliers cascade constraints;
drop table suppliers cascade constraints;
drop table products cascade constraints;
drop table purchaseOrders cascade constraints;
drop table counter cascade constraints;

create table products (
	Pnum varchar2(4),
	Pname varchar2(12),
	Stock number (6),
	primary key (Pnum) );
	
create table suppliers (
	Snum varchar2(4),
	Sname varchar2(25),
	address varchar2(25),
	city_state varchar2(25),
	zip varchar2(10),
	Phone varchar2(25),
	primary key (Snum) );
	
create table counter (
	maxnum number(5),
	primary key (maxnum)
	);
	
create table authorizedSuppliers (
	Pnum varchar2(4),
	Snum varchar2(4),
	UnitPrice number (10,2),
	primary key (Pnum,Snum),
	constraint fk_Pnum foreign key(Pnum) references products(Pnum),
	constraint fk_Snum foreign key(Snum) references suppliers(Snum)
	);
	
create table purchaseOrders (
	OrdNum number(5),
	OrdDate date,
	Status varchar(7),
	Pnum varchar2(4),
	Snum varchar2(4),
	UnitPrice number(10,2),
	OrdQty number(5),
	OrdAmt number(10,2),
	RecDate date,
	RecQty number(10),
	AmtDue number(10),
	primary key (OrdNum),
	constraint fk_Pnum2 foreign key(Pnum) references products(Pnum),
	constraint fk_Snum2 foreign key(Snum) references suppliers(Snum) );
	
	
insert into products values ('p1','Pencil',500);
insert into products values ('p2','Pen',600);
insert into products values ('p3','Cat',3);
insert into products values ('p4','Laptop',5);
insert into products values ('p5','DVI Cable',12);
insert into products values ('p6','Telephone',8);
insert into products values ('p7','Dog',82);

insert into suppliers values ('s1','Pencil Pushers','1234 Freeway St','Long Beach, CA','90501','310-558-2290');
insert into suppliers values ('s2','Pet Company','4523 MLK St','Torrance, CA','97845','318-658-4590');
insert into suppliers values ('s3','Buy More','3423 West St','Long Beach, CA','98502','310-555-2223');

insert into suppliers values ('s4','Blood Bath and Beyond','43251 MLK Ave','Torrance, CA','70602','310-555-4527');
insert into suppliers values ('s5','BlockChubber','Meyler St.','San Pedro, CA','54682','310-453-4215');
insert into suppliers values ('s6','Auction House','Gaffey Blvd','Wilmington, CA','47821','310-444-7856');

insert into authorizedSuppliers values ('p1','s1',3.50);
insert into authorizedSuppliers values ('p1','s3',3.25);
insert into authorizedSuppliers values ('p1','s2',3);

insert into authorizedSuppliers values ('p2','s1',1.50);
insert into authorizedSuppliers values ('p2','s3',2.50);
insert into authorizedSuppliers values ('p2','s5',2.75);

insert into authorizedSuppliers values ('p3','s2',1000);
insert into authorizedSuppliers values ('p3','s4',900);
insert into authorizedSuppliers values ('p3','s6',1050);

insert into authorizedSuppliers values ('p4','s3',200);
insert into authorizedSuppliers values ('p4','s5',312);
insert into authorizedSuppliers values ('p4','s2',252);

insert into authorizedSuppliers values ('p5','s3',20);
insert into authorizedSuppliers values ('p5','s2',21);
insert into authorizedSuppliers values ('p5','s5',13);

insert into authorizedSuppliers values ('p6','s1',22);
insert into authorizedSuppliers values ('p6','s2',12);
insert into authorizedSuppliers values ('p6','s4',12);

insert into authorizedSuppliers values ('p6','s6',500);

insert into authorizedSuppliers values ('p7','s2',3000);

insert into counter values (11001);


insert into purchaseOrders values (00003,TO_DATE('01/03/2018', 'MM/DD/YYYY'),'Closed','p4','s1',5,100,500,TO_DATE('01/08/2018', 'MM/DD/YYYY'),75,375);
insert into purchaseOrders values (00004,TO_DATE('01/05/2018', 'MM/DD/YYYY'),'Closed','p4','s1',5,100,500,TO_DATE('01/06/2018', 'MM/DD/YYYY'),75,375);
insert into purchaseOrders values (00005,TO_DATE('01/13/2018', 'MM/DD/YYYY'),'Closed','p4','s1',5,100,500,TO_DATE('01/21/2018', 'MM/DD/YYYY'),75,375);

insert into purchaseOrders values (00006,TO_DATE('01/11/2018', 'MM/DD/YYYY'),'Closed','p2','s3',2.5,30,75,TO_DATE('01/15/2018', 'MM/DD/YYYY'),28,70);
insert into purchaseOrders values (00007,TO_DATE('01/11/2018', 'MM/DD/YYYY'),'Closed','p2','s3',2.5,30,75,TO_DATE('01/18/2018', 'MM/DD/YYYY'),28,70);
insert into purchaseOrders values (00008,TO_DATE('01/01/2018', 'MM/DD/YYYY'),'Closed','p2','s3',2.5,30,75,TO_DATE('01/02/2018', 'MM/DD/YYYY'),28,70);
insert into purchaseOrders values (00009,TO_DATE('01/04/2018', 'MM/DD/YYYY'),'Closed','p2','s3',2.5,30,75,TO_DATE('01/13/2018', 'MM/DD/YYYY'),28,70);

insert into purchaseOrders values (00010,TO_DATE('02/03/2018', 'MM/DD/YYYY'),'Closed','p5','s3',20,600,12000,TO_DATE('02/05/2018', 'MM/DD/YYYY'),600,12000);

insert into purchaseOrders values (00011,TO_DATE('02/06/2018', 'MM/DD/YYYY'),'Closed','p3','s2',1000,4,4000,TO_DATE('02/11/2018', 'MM/DD/YYYY'),3,3000);

insert into purchaseOrders values (00012,TO_DATE('02/12/2018', 'MM/DD/YYYY'),'Closed','p7','s2',3000,20,60000,TO_DATE('02/15/2018', 'MM/DD/YYYY'),19,57000);

insert into purchaseOrders (OrdNum,OrdDate,Status,Pnum,Snum,UnitPrice,OrdQty,OrdAmt) values (0000013,TO_DATE('02/17/2018', 'MM/DD/YYYY'),'Open','p6','s1',180,20,3600);
insert into purchaseOrders (OrdNum,OrdDate,Status,Pnum,Snum,UnitPrice,OrdQty,OrdAmt) values (0000014,TO_DATE('01/15/2018', 'MM/DD/YYYY'),'Open','p3','s6',1050,10,10500);
insert into purchaseOrders (OrdNum,OrdDate,Status,Pnum,Snum,UnitPrice,OrdQty,OrdAmt) values (0000015,TO_DATE('03/12/2018', 'MM/DD/YYYY'),'Open','p2','s5',2.75,25,68.75);
insert into purchaseOrders (OrdNum,OrdDate,Status,Pnum,Snum,UnitPrice,OrdQty,OrdAmt) values (0000016,TO_DATE('01/02/2018', 'MM/DD/YYYY'),'Open','p1','s2',3,30,90);

commit;

spool off