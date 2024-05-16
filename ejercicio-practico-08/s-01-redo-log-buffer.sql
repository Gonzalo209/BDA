prompt Conectandonos como sys
connect sys/system2 as sysdba

prompt creando la primer tabla
create table gonzalo08.t01_redo_log_buffer(
redo_buffer_size_param_mb number(10,0),
redo_buffer_sga_info_mb number(10,0),
resizeable varchar2(64)
);

prompt insertando datos en la primera tabla
insert into gonzalo08.t01_redo_log_buffer(redo_buffer_size_param_mb,
redo_buffer_sga_info_mb,resizeable)
values(
7.1796875,
(select bytes/1024/1024 from v$sgainfo where name = 'Redo Buffers'),
(select resizeable from v$sgainfo where name = 'Redo Buffers')
);



