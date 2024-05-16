prompt creando usuario
create user gonzalo05op identified by gonzalo quota unlimited on users;

prompt dando privilegios al usuario
grant create session, create table, create sequence, create procedure to gonzalo05op;
