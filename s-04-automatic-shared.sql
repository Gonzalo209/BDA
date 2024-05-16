connect sys/system2 as sysdba

insert into gonzalo05op.t02_memory_param_values values(
2,
sysdate,
(select value/(1024*1024) from v$parameter where name='memory_target'),
(select value/(1024*1024) from v$parameter where name='sga_target'),
(select value/(1024*1024) from v$parameter where name='pga_aggregate_target'),
(select value/(1024*1024) from v$parameter where name='shared_pool_size'),
(select value/(1024*1024) from v$parameter where name='large_pool_size'),
(select value/(1024*1024) from v$parameter where name='java_pool_size'),
(select value/(1024*1024) from v$parameter where name='db_cache_size')
);


