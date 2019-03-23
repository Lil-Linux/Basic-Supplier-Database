SET HEADING on
SET ECHO off
set feedback off
set verify off
set linesize 1500

spool C:\SQL\Project\SupplierMonthly.txt

prompt
prompt

prompt *************** SUPPLIER MONTHLY REPORT ***************
prompt
prompt

column TO_CHAR(OrdDate,'MM/YYYY') heading 'Order Month' format a25;
column Snum heading 'Supplier Number' format a25;
column Snum heading 'Supplier Name' format a25;
column count(OrdNum) heading 'No of Orders' format 9999999999999999;
column sum(OrdQty) heading 'Total Units' format 9999999999999999;
column sum(OrdAmt) heading 'Total Amount' format $9999999999999999;

select purchaseOrders.Snum,
	suppliers.Sname,
	TO_CHAR(OrdDate,'MM/YYYY'), 
	count(OrdNum), 
	sum(OrdQty), 
	sum(OrdAmt)
		from purchaseOrders,suppliers
		where suppliers.Snum = purchaseOrders.Snum
		group by purchaseOrders.Snum,suppliers.Sname, TO_CHAR(OrdDate,'MM/YYYY')
		order by purchaseOrders.Snum, TO_CHAR(OrdDate,'MM/YYYY');

clear column




spool off
