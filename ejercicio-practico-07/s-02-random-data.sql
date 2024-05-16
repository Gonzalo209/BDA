connect gonzalo07/gonzalo

prompt creando la tabla 03
create table t03_random_data(
id number,
random_string varchar2(1024)
);

prompt creando la tabla 04
create table t04_db_buffer_status(
id number generated always as identity,
total_bloques number,
status varchar2(10),
evento varchar2(30)
);

prompt agregando n registros a la tabla 03
declare
v_rows number;
v_query varchar2(100);
begin
v_rows := 1000*10;
v_query := 'insert into t03_random_data(id,random_string) values (:ph1,:ph2)';
for v_index in 1 .. v_rows loop
execute immediate v_query using v_index, dbms_random.string('P',1016);
end loop; 
end;
/

prompt conectandonos como sys
connect sys/system2 as sysdba

prompt insertar el primer registro en la tabla 04 con el evento Despues de carga
insert into gonzalo07.t04_db_buffer_status(total_bloques,status,evento)
select count(*) total_bloques,status,'Despues de carga' as evento
from v$bh
where objd = (
select data_object_id
from dba_objects
where object_name='T03_RANDOM_DATA'
and owner = 'GONZALO07'
)
group by status;
commit;

prompt liberamos el buffer
alter system flush buffer_cache;

prompt insertamos el segundo registro en la tabla 04 con el evento Despues de vacia db buffer
insert into gonzalo07.t04_db_buffer_status(total_bloques,status,evento)
select count(*) total_bloques, status, 'Despues de vaciar db buffer' as evento
from v$bh
where objd = (
select data_object_id
from dba_objects
where object_name='T03_RANDOM_DATA'
and owner='GONZALO07'
)
group by status;

commit;

prompt apagando instancia
shutdown immediate

prompt levantando instancia
startup 

prompt insertamos un tercer registro en la tabla 04 con el evento Despues del reinicio
insert into gonzalo07.t04_db_buffer_status (total_bloques,status, evento)
select count(*) total_bloques, status, 'Despues del reinicio' as evento
from v$bh
where objd = (
select data_object_id
from dba_objects
where object_name='T03_RANDOM_DATA'
and owner='GONZALO07'
)
group by status;
commit;

prompt modificamos un registro de la tabla 03
update gonzalo07.t03_random_data set random_string=upper(random_string)
where id = 1;

prompt insertamos un cuarto registro con el estatus Despues del cambio
insert into gonzalo07.t04_db_buffer_status (total_bloques,status, evento)
select count(*) total_bloques, status, 'Despues del cambio 1' as evento
from v$bh
where objd = (
select data_object_id
from dba_objects
where object_name='T03_RANDOM_DATA'
and owner='GONZALO07'
)
group by status;

prompt En otra terminal crear una sesion con el usuario gonzalo07
prompt consultar el registro modificado 3 veces
pause "select * from t03_random_data where id = 1", [enter] para continuar

prompt Insertando un ultimo registro
insert into gonzalo07.t04_db_buffer_status (total_bloques,status,evento)
select count(*) total_bloques,status, 'Después de 3 consultas' as evento
from v$bh
where objd = (
select data_object_id
from dba_objects
where object_name='T03_RANDOM_DATA'
and owner = 'GONZALO07'
)
group by status;

commit;

prompt Mostrando los datos finales
select * from gonzalo07.t04_db_buffer_status;
