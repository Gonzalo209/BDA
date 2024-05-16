prompt Autenticando como gonzalo1001

connect gonzalo1001/gonzalo

prompt Creando tabla llamada str_data
create table str_data(
str char(1024)
) pctfree 0;

insert into str_data values('a');

select lengthb(str), length(str) from str_data 
where str = 'a';

begin
 for i in 1..56 loop
   execute immediate 'insert into str_data values('a' + i)';
 end loop;
end;
/

prompt Consultando los resultados de la vista user_extents
select * from user_extents where segment_name = 'STR_DATA';

prompt Mostrando los rowids generados
select rowid from str_dat order by 1;

prompt Creando tabla str_data_extents

create table t02_str_data_extents as
select substr(rowid, 1, 15) as codigo_bloque, count(*) total_registros
from str_data
group by substr(rowid, 1, 15)
order by codigo_bloque;








