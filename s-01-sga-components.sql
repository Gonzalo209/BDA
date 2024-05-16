Prompt Creando primer tabla
create table gonzalo04op.t01_sga_components(
memory_target_param number(10,2),
fixed_size number(10,2),
variable_size number(10,2),
database_buffers number(10,2),
redo_buffers number(10,2),
total_sga number(10,2)
);

insert into gonzalo04op.t01_sga_components(memory_target_param, fixed_size,
variable_size, database_buffers, redo_buffers, total_sga) values(
768.00,
(select trunc(value/1024/1024,2) from v$sga where name='Fixed Size'),
(select trunc(value/1024/1024,2) from v$sga where name='Variable Size'),
(select trunc(value/1024/1024,2) from v$sga where name='Database Buffers'),
(select trunc(value/1024/1024,2) from v$sga where name='Redo Buffers'),
(select trunc(sum(value)/1024/1024,2) from v$sga));

Prompt Creando la segunda tabla
create table gonzalo04op.t02_sga_dynamic_components(
component_name varchar2(64),
current_size_mb number(10,2),
operation_count number(10,0),
last_operation_type varchar2(13),
last_operation_time date
);

insert into gonzalo04op.t02_sga_dynamic_components
(component_name, current_size_mb, operation_count, last_operation_type,
last_operation_time)
select component, trunc(current_size/1024/1024,2),
oper_count, last_oper_type, last_oper_time from v$sga_dynamic_components;

Prompt Creando la tercer tabla
create table gonzalo04op.t03_sga_max_dynamic_component(
component_name varchar2(64),
current_size_mb number(10,2)
);

insert into gonzalo04op.t03_sga_max_dynamic_component
values(
(select component from v$sga_dynamic_components where current_size >= (select max(current_size) from v$sga_dynamic_components)),
(select trunc(current_size/1024/1024,2) from v$sga_dynamic_components where current_size >= (select max(current_size) from v$sga_dynamic_components))
);

Prompt Creando la cuarta tabla
create table gonzalo04op.t04_sga_min_dynamic_component(
component_name varchar2(64),
current_size_mb number(10,2)
);

insert into gonzalo04op.t04_sga_min_dynamic_component(component_name, 
current_size_mb)
select component, trunc(current_size/1024/1024) from v$sga_dynamic_components
where current_size > 0;

Prompt Creando la quinta tabla
create table gonzalo04op.t05_sga_memory_info(
name varchar2(64),
current_size_mb number(10,2)
);

insert into gonzalo04op.t05_sga_memory_info
values(
(select name from v$sgainfo where name='Maximum SGA Size'),
(select trunc(bytes/1024/1024,2) from v$sgainfo where name='Maximum SGA Size')
);

insert into gonzalo04op.t05_sga_memory_info
values(
(select name from v$sgainfo where name='Free SGA Memory Available'),
(select trunc(bytes/1024/1024,2) from v$sgainfo where name='Free SGA Memory Available')
);

Prompt Creando la sexta tabla
create table gonzalo04op.t06_sga_resizeable_components(
name varchar2(64)
);

insert into gonzalo04op.t06_sga_resizeable_components(name)
select name from v$sgainfo where resizeable='Yes';

create table gonzalo04op.t07_sga_resize_ops(
component varchar2(64),
oper_type varchar2(13),
parameter varchar2(64),
initial_size_mb number(10, 2),
target_size_mb number(10, 2),
final_size_mb number(10, 2),
increment_mb number(10, 2),
status varchar2(9),
start_time date,
end_time date
);

insert into gonzalo04op.t07_sga_resize_ops(component, oper_type, parameter, initial_size_mb, target_size_mb,
final_size_mb, increment_mb, status, start_time, end_time)
select component, 
oper_type, 
parameter, 
trunc(initial_size/1024/1024,2),
trunc(target_size/1024/1024,2), 
trunc(final_size/1024/1024,2), 
trunc((target_size/1024/1024) - (final_size/1024/1024), 2),
status,
start_time,
end_time
from v$sga_resize_ops;

select memory_target_param, fixed_size, variable_size, 
database_buffers, redo_buffers, 
total_sga from gonzalo04op.t01_sga_components;


