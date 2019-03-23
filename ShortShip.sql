SET HEADING on
SET ECHO off
set feedback off
set verify off
set linesize 500

spool C:\SQL\Project\ShortShip.txt

prompt
prompt

prompt ***************Short Ship Report***************
prompt
prompt
SELECT 'Today''s Date: ', TO_CHAR(sysdate) FROM dual;
prompt
prompt

column OrdDate heading 'Date Open' format a20;
column Pname heading 'Product Desc' format a20;
column OrdQty-RecQty heading 'Short Qty' format 999;


select OrdNum, Status, OrdDate, purchaseOrders.Pnum,products.Pname,OrdQty, RecQty, OrdQty-RecQty, purchaseOrders.Snum,suppliers.Sname
	from purchaseOrders, products, suppliers
	where products.Pnum=purchaseOrders.Pnum and suppliers.Snum=purchaseOrders.Snum
	and (OrdQty-RecQty)>=1
	order by OrdDate;
	
clear column

spool off