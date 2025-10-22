use tempdb;
go
if OBJECT_ID('tempdb..data_table') is not null
	drop table tempdb..data_table

create table tempdb..data_table (
id int identity primary key,
code1 nvarchar(50),
code2 nvarchar(50),
[value] int
)


;With NumberCTE as(
select 1 as num
union all
select num+1 from NumberCTE where num<100
)
,CreatedNumbers as(
select ROW_NUMBER()over(order by n1.num,n2.num,n3.num) RN
from NumberCTE n1
cross apply NumberCTE n2
cross apply NumberCTE n3
where n3.num<=50
)
insert into tempdb..data_table(code1,code2,[value])
select (case when RN%2=1 then concat('Code1_',RN) else null end) [code1]
		,(case when RN%2=0 then concat('Code2_',RN) else null end) [code2]
		,CAST(CEILING(5000000 * RAND(CHECKSUM(NEWID()))) as int) [value]
from CreatedNumbers

 
--select * from tempdb..data_table
