prompt Autenticando como gonzalo10
connect gonzalo1001/gonzalo

prompt Creando tabla
create table empleado(
empleado_id number(10,0),
nombre_completo varchar2(100) not null,
num_cuenta varchar2(15) not null,
expediente blob not null,
constraint empleado_pk primary key(empleado_id),
constraint empleado_num_cuenta_uix unique(num_cuenta)
);

prompt Comprobar que aun no existen estructuras logicas de almanc
select * from user_segments where segment_name like '%EMPLEADO%';

prompt Agregando registro a la tabla
insert into empleado values(1,'Gustavo Gonzalo Chavez Bolaños',421113581,
empty_blob());

prompt Solicitando la creacion de una nueva extension
alter table empleado allocate extent;

prompt Consultando los segmentos de nuevo
select segment_name,segment_type,tablespace_name,bytes,blocks,
extents from user_segments where segment_name like '%EMPLEADO%';

prompt Usando la vista user_lobs
col table_name format a10
col column_name format a10
col segment_name format a10
select table_name,column_name,segment_name,tablespace_name,index_name
from user_lobs
where table_name = 'EMPLEADO';

--create table t01_emp_segments as 
--se
