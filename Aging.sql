SET HEADING on
SET ECHO off
set feedback off
set verify off
set linesize 500

spool C:\SQL\Project\Aging.txt

prompt
prompt

prompt ***************PURCHASE ORDER AGING REPORT***************
prompt
prompt
SELECT 'Today''s Date: ', TO_CHAR(sysdate) FROM dual;
prompt
prompt

accept vQueryDays prompt 'Please enter number of days to query: ';

column OrdDate heading 'Date Open' format a20;
column Pname heading 'Product Desc' format a20;
column trunc(sysdate)-trunc(OrdDate) heading 'Days Open' format 999;

select OrdNum, Status, OrdDate, purchaseOrders.Pnum,products.Pname,OrdQty, UnitPrice, OrdAmt, purchaseOrders.Snum,suppliers.Sname, trunc(sysdate)-trunc(OrdDate)
	from purchaseOrders, products, suppliers
	where (trunc(sysdate)-trunc(OrdDate)) >= '&vQueryDays' and Status='Open'
	and products.Pnum=purchaseOrders.Pnum and suppliers.Snum=purchaseOrders.Snum
	ORDER by trunc(sysdate)-trunc(OrdDate) DESC;
	
clear column

spool off