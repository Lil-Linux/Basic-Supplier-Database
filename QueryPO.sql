SET HEADING off
SET ECHO off
set feedback off
set verify off

spool C:\SQL\Project\QueryPO.txt

prompt
prompt

prompt ***************Q U E R Y  O R D E R***************
prompt
prompt

accept vOrdNum prompt 'Enter the Purchase Order: ';
prompt
prompt Purchase Order Number: '&vOrdNum'


select 'Item Number: ', Pnum from purchaseOrders
	where OrdNum='&vOrdNum';
	
select '	Item Description: ', Pname from products
	where Pnum= (select Pnum from purchaseOrders where '&vOrdNum'=OrdNum);
	
select '	Current Inventory Level: ', Stock from products
	where Pnum= (select Pnum from purchaseOrders where '&vOrdNum'=OrdNum);
	
select 'Supplier Number: ', Snum from purchaseOrders
	where OrdNum='&vOrdNum';
	
select '	Supplier Name: ', Sname from suppliers
	where Snum= (select Snum from purchaseOrders where '&vOrdNum'=OrdNum);
	
select 'Date Ordered: ', OrdDate from purchaseOrders where '&vOrdNum'=OrdNum;
select 'Quantity Ordered: ', OrdQty from purchaseOrders where '&vOrdNum'=OrdNum;
select 'Date Received: ', RecDate from purchaseOrders where '&vOrdNum'=OrdNum;
select 'Quantity Received: ', RecQty from purchaseOrders where '&vOrdNum'=OrdNum;
select 'Unit Price: '||'$'||UnitPrice from purchaseOrders where '&vOrdNum'=OrdNum;
select 'Amount Ordered: '||'$'||OrdAmt from purchaseOrders where '&vOrdNum'=OrdNum;
select 'Amount Due: '||'$'||AmtDue from purchaseOrders where '&vOrdNum'=OrdNum;
prompt
select 'Status: ', Status from purchaseOrders where '&vOrdNum'=OrdNum;

spool off