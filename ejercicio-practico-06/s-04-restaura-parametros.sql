connect sys/system2 as sysdba

alter system reset db_writer_processes scope=spfile;
alter system reset log_buffer scope=spfile;
alter system reset db_files scope=spfile;
alter system reset dml_locks scope=spfile;
alter system reset transactions scope=spfile;
alter system reset hash_area_size scope=spfile;
alter system reset optimizer_mode scope=both;

