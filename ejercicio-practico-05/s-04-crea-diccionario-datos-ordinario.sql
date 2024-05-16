--@Author: Gustavo Chavez
--@Description: Creamos el diccionario de datos
--@Date: 16/03/24

connect sys/system2 as sysdba

@?/rdbms/admin/catalog.sql
@?/rdbms/admin/catproc.sql
@?/rdbms/admin/utlrp.sql

connect system/system2

@?/sqlplus/admin/pupbld.sql
