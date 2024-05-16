Prompt Conectandonos como sys
connect sys/system2 as sysdba

Prompt Levantando instancia
startup


Prompt Creando archivo pfile a partir de un spfile

create pfile='/unam-bda/ejercicios-practicos/ejercicio-practico-06/e-02-spparameter-pfile.txt' from spfile;

Prompt Creando nuevo usuario y asignado privilegios
create user gonzalo06 identified by gonzalo quota unlimited on users;

grant create session, create table to gonzalo06;

Prompt Creando tabla 
create table gonzalo06.t01_spparameters as
select name,value
from v$spparameter
where value is not null;

Prompt Mostrando los datos

col name format a20
col value format a70
select name, value from gonzalo06.t01_spparameters;
