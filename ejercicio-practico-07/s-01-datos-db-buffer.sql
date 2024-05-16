whenever sqlerror exit rollback;

create table gonzalo07.t01_db_buffer_cache
(
block_size number(10,2),
current_size number(10,2),
buffers number(10,2),
target_buffers number(10,2),
prev_size number(10,2),
prev_buffers number(10,2),
default_pool_size number(10,2)
);

insert into gonzalo07.t01_db_buffer_cache values(
(select block_size from v$buffer_pool),
(select current_size from v$buffer_pool),
(select buffers from v$buffer_pool),
(select target_buffers from v$buffer_pool),
(select prev_size from v$buffer_pool),
(select prev_buffers from v$buffer_pool),
0
);

create table gonzalo07.t02_db_buffer_sysstats(
db_blocks_gets_from_cache number(10,2),
consistent_gets_from_cache number(10,2),
physical_reads_cache number(10,2),
cache_hit_radio number(10,2)
);

insert into gonzalo07.t02_db_buffer_sysstats
(db_blocks_gets_from_cache,consistent_gets_from_cache,physical_reads_cache,
cache_hit_radio)
values(
(select value as db_blocks_gets_from_cache
from v$sysstat
where name ='db block gets from cache'),
(select value as consistent_gets_from_cache
from v$sysstat 
where name ='consistent gets from cache'),
(select value as physical_reads_cache
from v$sysstat 
where name ='physical reads cache'),
(select trunc(1 - p3.value / (p1.value + p2.value), 6)
from v$sysstat p1, v$sysstat p2, v$sysstat p3
where p1.name = 'db block gets from cache'
and p2.name = 'consistent gets from cache'
and p3.name = 'physical reads cache')
);
