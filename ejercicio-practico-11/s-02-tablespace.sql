prompt Autenticando como sys
connect sys/system2 as sysdba2

prompt Creando el tablespace gcb_store_tbs
create tablespace gcb_store_tbs
datafile 'u01/app/oracle/oradata/GCBBDA2/gcb_store_tbs01.dbf'
size 20m
extent management local autoallocate
segment space management auto;

prompt Creando 3 tablespace con los montajes creados anteriormente
create tablespace gcb_store_tbs_multiple
datafile 'u01/app/oracle/oradata/GCBBDA2/disk1/gcb_store_tbs_multiple_01.dbf'
size 10m,
'u01/app/oracle/oradata/GCBBDA2/disk2/gcb_store_tbs_multiple_02.dbf' size 10m,
'u01/app/oracle/oradata/GCBBDA2/disk3/gcb_store_tbs_multiple_03.dbf' size 10m
extent management local autoallocate
segment space management auto;

prompt Creando tablespaces custom
create tablespace gcb_store_tbs_custom
datafile 'u01/app/oracle/oradata/GCBBDA2/gcb_store_tbs_custom_01.dbf'
size 10m
nologging
autoextend on 
next 1m 
maxsize 30m
blocksize 8k
offline


