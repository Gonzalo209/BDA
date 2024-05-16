prompt autenticando como sysdba
connect sys/system2 as sysdba

prompt configurando los 2 dispatchers empleando el protocolo TCP
alter system set dispatchers=('dispatchers=2)(protocol=tcp)';

prompt configurando los 4 shared services
alter system set shared_servers=4;

prompt verificando la configuracion
show parameter shared_servers

prompt configurando el listener en modo compartido
alter system register;

prompt mostrando el listener
!lsnrctl services




