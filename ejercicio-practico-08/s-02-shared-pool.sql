connect sys/system2 as sysdba

prompt Creando tabla
create table gonzalo08.t02_shared_pool(
shared_pool_param_mb number(10,0),
shared_pool_sga_info_mb number(10,0),
resizeable varchar2(64),
shared_pool_component_total number(10, 0),
shared_pool_free_memory number
);

prompt Insertando registro en la primer tabla
insert into gonzalo08.t02_shared_pool(shared_pool_param_mb,
shared_pool_sga_info_mb,
resizeable,
shared_pool_component_total,
shared_pool_free_memory)
values(
0,
(select bytes/1024/1024 from v$sgainfo where name = 'Shared Pool Size'),
(select resizeable from v$sgainfo where name = 'Shared Pool Size'),
(select count(*) from v$sgastat where pool = 'shared pool'),
(select bytes/1024/1024 from v$sgastat where pool = 'shared pool' and
name = 'free memory')
);

prompt Creando e insertando datos a la tercer tabla
create table gonzalo08.t03_library_cache_hits as
select 1 as id,reloads,invalidations,pins,pinhits,pinhitratio
from v$librarycache
where namespace='SQL AREA';

prompt Creando la cuarta tabla
create table gonzalo08.test_orden_compra(id number);

prompt Ejecutando consultas con sentencias sql estaticas
set timing on
declare 
 v_orden_compra gonzalo08.test_orden_compra%rowtype;
begin
for i in 1..50000 loop
 begin
    execute immediate
      'select * from  gonzalo08.test_orden_compra where id = ' || i
	into v_orden_compra;
 exception
    when no_data_found then
      null;
 end;
end loop;
end;
/
set timing off

prompt Capturando nuevamente estadisticas del library cache
insert into gonzalo08.t03_library_cache_hits(id,reloads,invalidations,
pins,pinhits,pinhitratio)
select 2 as id,reloads,invalidations,pins,pinhits,pinhitratio
from v$librarycache
where namespace='SQL AREA';
commit;

shutdown immediate
startup

prompt Capturando nuevamente estadisticas del library cache
insert into gonzalo08.t03_library_cache_hits(id,reloads,invalidations,
pins,pinhits,pinhitratio)
select 3 as id,reloads,invalidations,pins,pinhits,pinhitratio
from v$librarycache
where namespace='SQL AREA';
commit;

prompt Agregando bloque anonimo con placeholders

set timing on
declare
v_orden_compra gonzalo08.test_orden_compra%rowtype;
v_query varchar2(64);
begin
v_query := 'select * from gonzalo08.test_orden_compra where id = :ph_id';
for i in 1..50000 loop
begin
execute immediate v_query using i;
exception
when no_data_found then
null;
end;
end loop;
end;
/
set timing off

prompt Capturando nuevamente estadisticas del library cache
insert into gonzalo08.t03_library_cache_hits(id,reloads,invalidations,
pins,pinhits,pinhitratio)
select 4 as id,reloads,invalidations,pins,pinhits,pinhitratio
from v$librarycache
where namespace='SQL AREA';
commit;

select * from gonzalo08.t03_library_cache_hits;
