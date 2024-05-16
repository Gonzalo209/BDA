--obtiene la lista de nombres y valores de los parámetros a nivel de instancia
--empleando la vista v$system_parameter justo antes de ser modificados.
--Estos valores servirán para validar que los cambios y restauración se haya
--realizado de forma correcta.
Prompt Entrando como usuario sys
connect sys/system2 as sysdba

Prompt Creando tabla 	
create table gonzalo06.t02_other_parameters as
select num,name,value,default_value,isses_modifiable as is_session_modifiable,
issys_modifiable as is_system_modifiable
from v$system_parameter
where name in (
'cursor_invalidation','optimizer_mode',
'sql_trace','sort_area_size','hash_area_size','nls_date_format',
'db_writer_processes','db_files','dml_locks','log_buffer','transactions'
);

select * from gonzalo06.t02_other_parameters;
