create table gonzalo05op.t01_memory_areas (
id number,
sample_date date,
redo_buffer_mb number(10,1),
buffer_cache_mb number(10,0),
shared_pool_mb number(10,0),
large_pool_mb number(10,0),
java_pool_mb number(10,0),
total_sga_mb1 number(10,2),
total_sga_mb2 number(10,2),
total_sga_mb3 number(10,2),
total_pga_mb1 number(10,0),
total_pga_mb2 number(10,0),
max_pga number(10,2)
);

insert into gonzalo05op.t01_memory_areas
values(
1,
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

create table gonzalo05op.t02_memory_param_values(
id number,
sample_date date,
memory_target number,
sga_target number,
pga_aggregate_target number,
shared_pool_size number,
large_pool_size number,
java_pool_size number,
db_cache_size number
);

insert into gonzalo05op.t02_memory_param_values values(
1,
sysdate,
(select value/(1024*1024) from v$parameter where name='memory_target'),
(select value/(1024*1024) from v$parameter where name='sga_target'),
(select value/(1024*1024) from v$parameter where name='pga_aggregate_target'),
(select value/(1024*1024) from v$parameter where name='shared_pool_size'),
(select value/(1024*1024) from v$parameter where name='large_pool_size'),
(select value/(1024*1024) from v$parameter where name='java_pool_size'),
(select value/(1024*1024) from v$parameter where name='db_cache_size')
);

commit;
