set heading off
set echo off
set feedback off
set verify off

spool C:\SQL\Project\OpenPO.txt

prompt 
prompt
prompt ************O P E N  O R D E R************
prompt
prompt
SELECT 'Today''s Date: ', TO_CHAR(sysdate) FROM dual;
prompt
prompt

column Pnum heading 'Item Number' format a25;
prompt Here is a list of products:
prompt ___________________________________________
prompt

select Pnum,Pname from products;

 
prompt
prompt
accept vPnum prompt 'Enter the Item Number: ';

set heading off
select 'Item Description: ', Pname from products
	where Pnum='&vPnum';

select 'Current Inventory Level: ', Stock from products
	where Pnum='&vPnum';
	
prompt
prompt

set heading on 

prompt Please select from one of the following Authorized Suppliers: 

column Snum heading 'Supplier Number' format a25;

select suppliers.Snum, suppliers.Sname, suppliers.city_state, authorizedSuppliers.UnitPrice
	from suppliers, authorizedSuppliers
	where Pnum='&vPnum'
		and suppliers.Snum= authorizedSuppliers.Snum;
prompt
prompt

clear column
set heading off
accept vSnum prompt 'Enter the Supplier Number: ';
select 'Supplier Name: ', Sname from suppliers where Snum='&vSnum';
select 'Address: ', address from suppliers where Snum='&vSnum';
select 'City, State, and Zip: ',city_state,ltrim(zip) from suppliers where Snum='&vSnum';
select 'Phone: ', Phone from suppliers where Snum='&vSnum';
prompt
prompt
accept vOrdQty prompt 'Enter Order Quantity: ';

insert into purchaseOrders (OrdNum,OrdDate,Pnum,Snum,OrdQty,Status)
	select maxnum,sysdate,'&vPnum','&vSnum','&vOrdQty','Open' from counter;

update purchaseOrders
	set UnitPrice = 
		(select UnitPrice 
		from authorizedSuppliers 
		where authorizedSuppliers.Pnum = '&vPnum' 
		and authorizedSuppliers.Snum = '&vSnum')
	where OrdNum=(select maxnum from counter);
	
update purchaseOrders
	set OrdAmt = UnitPrice*OrdQty
	where OrdNum=(select maxnum from counter);
	
select 'Unit Price: '||'$'||UnitPrice from purchaseOrders where OrdNum=(select maxnum from counter);
select 'Amount Ordered: '||'$'||OrdAmt from purchaseOrders where OrdNum=(select maxnum from counter);

select '****** Order Status: ', Status from purchaseOrders where OrdNum=(select maxnum from counter);
select '****** Purchase Order number is ----------->      ', OrdNum from purchaseOrders where OrdNum=(select maxnum from counter);

update counter set maxnum=maxnum+1;
	
spool off