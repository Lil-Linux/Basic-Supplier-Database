SET HEADING off
SET ECHO off
set feedback off
set verify off

spool C:\SQL\Project\ReceivePO.txt

prompt
prompt

prompt ***************R E C E I V E   O R D E R***************
prompt
prompt
SELECT 'Today''s Date: ', TO_CHAR(sysdate) FROM dual;
prompt
prompt

accept vOrdNum prompt 'Enter the Purchase Order: ';
prompt
prompt Purchase Order Number: '&vOrdNum'

select 'Item Number: ', Pnum from purchaseOrders
	where OrdNum='&vOrdNum';
	
select '	Item Description: ', Pname from products
	where Pnum= (select Pnum from purchaseOrders where '&vOrdNum'=OrdNum);

select 'Supplier Number: ', Snum from purchaseOrders
	where OrdNum='&vOrdNum';
	
select '	Supplier Name: ', Sname from suppliers
	where Snum= (select Snum from purchaseOrders where '&vOrdNum'=OrdNum);

select 'Date Ordered: ', OrdDate from purchaseOrders where '&vOrdNum'=OrdNum;
SELECT 'Today''s Date: ', TO_CHAR(sysdate) FROM dual;

select 'Quantity Ordered: ', OrdQty from purchaseOrders where '&vOrdNum'=OrdNum;
select 'Unit Price: '||'$'||UnitPrice from purchaseOrders where '&vOrdNum'=OrdNum;
select 'Amount Ordered: '||'$'||OrdAmt from purchaseOrders where '&vOrdNum'=OrdNum;
prompt
prompt

--QUANTITY RECEIVE

accept vRecQty prompt 'Enter Quantity Received: ';

update purchaseOrders 
	set Status = 'Closed',
	RecDate = sysdate,
	RecQty = '&vRecQty',
	AmtDue = '&vRecQty' * (select UnitPrice from purchaseOrders where OrdNum = '&vOrdNum')
	where OrdNum = '&vOrdNum';

update products 
	set Stock = Stock+'&vRecQty'
	where Pnum = (select Pnum from purchaseOrders where OrdNum = '&vOrdNum');
	
select 'Amount Due:  '||'$'||AmtDue from purchaseOrders where OrdNum = '&vOrdNum';
select 'Inventory Level:  '||Stock from products where Pnum = (select Pnum from purchaseOrders where OrdNum = '&vOrdNum');

prompt ********************************************
prompt Order is now ___________> Closed
SELECT 'Date Closed: ', TO_CHAR(sysdate) FROM dual;


spool off