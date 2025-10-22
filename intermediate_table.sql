use tempdb;
go
if OBJECT_ID('tempdb..intermediate_table') is not null
	drop table tempdb..intermediate_table

create table tempdb..intermediate_table (
id int identity primary key,
[type] int,
code nvarchar(50)
)

DECLARE @RowCount INT= 1000;
DECLARE @Counter INT= 1;
DECLARE @Random INT;

WHILE @Counter <= @RowCount
    BEGIN
		SET @Random=CAST(CEILING(500000 * RAND()) as int)
        insert into tempdb..intermediate_table([type],code)
		values( (case when @Random%2=1 then 1 when @Random%2=0 then 2 else null end)
				,(case when @Random%2=1 then concat('Code1_',@Random) when @Random%2=0 then concat('Code2_',@Random) else null end)
			)
        SET @Counter = @Counter + 1;
    END;

--select * from tempdb..intermediate_table;
