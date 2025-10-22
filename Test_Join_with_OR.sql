use tempdb;
go
select type,count(*)cnt from tempdb..intermediate_table group by [type];
select count(*)cnt from tempdb..data_table;
/* Scenarios:
1- Without indexes
2- Without indexes (with query hint)
3- With indexes
*/
------------------------------------
select *
from tempdb..intermediate_table  it
join tempdb..data_table dt on (it.type=1 and it.code=dt.code1) or (it.type=2 and it.code=dt.code2)
--option (hash join)
----------------------------------------------------
select *
from tempdb..intermediate_table  it
join tempdb..data_table dt on (it.type=1 and it.code=dt.code1) 
union all 
select *
from tempdb..intermediate_table  it
join tempdb..data_table dt on (it.type=2 and it.code=dt.code2)
--option (loop join)


CREATE NONCLUSTERED INDEX IX_data_table_Code1 ON tempdb..data_table (code1);
CREATE NONCLUSTERED INDEX IX_data_table_Code2 ON tempdb..data_table (code2);
CREATE NONCLUSTERED INDEX IX_intermediate_table_Code ON tempdb..intermediate_table (code);

drop index data_table.IX_data_table_Code1;
drop index data_table.IX_data_table_Code2;
drop index intermediate_table.IX_intermediate_table_Code;
