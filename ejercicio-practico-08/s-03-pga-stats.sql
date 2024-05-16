connect sys/system2 as sysdba

create table gonzalo08.t04_pga_stats(
max_pga_mb number(10,2),
pga_target_param_calc_mb number(10,0),
pga_target_param_actual_mb number(10,0),
pga_total_actual_mb number(10,2),
pga_in_use_actual_mb number(10,2),
pga_free_memory_mb number(10,2),
pga_process_count number(10,0),
pga_cache_hit_percentage number(10,0)
);

insert into gonzalo08.t04_pga_stats
values(
(select value/1024/1024 from v$pgastat where name = 'maximum PGA allocated'),
(select value/1024/1024 from v$pgastat where name = 'aggregate PGA target parameter'),
0,
(select value/1024/1024 from v$pgastat where name = 'total PGA allocated'),
(select value/1024/1024 from V$pgastat where name = 'total PGA inuse'),
(select value/1024/1024 from v$pgastat where name = 'total freeable PGA memory'),
(select value/1024/1024 from v$pgastat where name = 'max processes count'),
(select value/1024/1024 from v$pgastat where name = 'cache hit percentage')
);
