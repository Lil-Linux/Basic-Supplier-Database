set linesize 100

spool C:\SQL\Project\info.txt

describe products
prompt
prompt
describe suppliers
prompt
prompt
describe counter
prompt
prompt
describe authorizedSuppliers
prompt
prompt
describe purchaseOrders
prompt
prompt
select * from products;
prompt
prompt
select * from suppliers;
prompt
prompt
select * from authorizedSuppliers;
prompt
prompt
select * from purchaseOrders;
prompt
prompt

spool off