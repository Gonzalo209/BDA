connect sys/system2 as sysdba

connect gonzalo05op/gonzalo

set timing on

exec spv_query_random_data

set timing off

connect sys/system2 as sysdba

insert into gonzalo05op.t01_memory_areas
values(
3,
sysdate,
(select bytes/1024/1024 from v$sgainfo where name = 'Redo Buffers'),
(select bytes/1024/1024 from v$sgainfo where name = 'Buffer Cache Size'),
(select bytes/1024/1024 from v$sgainfo where name = 'Shared Pool Size'),
(select bytes/1024/1024 from v$sgainfo where name = 'Large Pool Size'),
(select bytes/1024/1024 from v$sgainfo where name = 'Java Pool Size'),
(select trunc(((select sum(value) from v$sga)-(select current_size from v$sga_dynamic_free_memory))/1024/1024,2) as memoria_sga_1 from dual),
(select trunc(((select sum(current_size) from v$sga_dynamic_components) +(select value from v$sga where name ='Fixed Size') +(select value from v$sga where name ='Redo Buffers')) /1024/1024,2) as memoria_sga_2 from dual),
(select trunc((select sum(bytes) from v$sgainfo where name not in ('Granule Size','Maximum SGA Size','Startup overhead in Shared Pool','Free SGA Memory Available','Shared IO Pool Size')) /1024/1024,2) as memoria_sga_3 from dual),
(select trunc(value/1024/1024,2) memoria_pga_1 from v$pgastat where name ='aggregate PGA target parameter'),
(select trunc(current_size/1024/1024,2) memoria_pga_2 from v$sga_dynamic_free_memory),
(select trunc(value/(1024*1024),2) - 100 from v$pgastat where name = 'maximum PGA allocated')
);

commit;
