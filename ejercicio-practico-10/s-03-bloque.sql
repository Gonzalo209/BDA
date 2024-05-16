prompt Autenticando como gonzalo1001
connect gonzalo1001/gonzalo

prompt Creando tabla t03_random_str
create table t03_random_str(
str varchar2(1024)
);

prompt Agregando registros a la tabla t03_random_str
begin
  for i in 1..5 loop
    execute immediate 'insert into t03_random_str values(DBMS_RANDOM.STRING('X',1024)';
  end loop;
end;
/

prompt Creando tabla t04_space_usage
create table t04_space_usage(
id number,
segment_name varchar2(128),
unformatted_blocks number, --número de bloques reservados sin formatear
unused_blocks number, --número de bloques reservados sin uso
total_blocks number, --total de bloques reservados para la tabla
free_space_0_25 number, --número de bloques con espacio libre entre el 0 y 25%
free_space_25_50 number, --número de bloques con espacio libre entre el 25 y 50%
free_space_50_75 number, --número de bloques con espacio libre entre el 50 y 75%
free_space_75_100 number --número de bloques con espacio libre entre el 75 y 100%
);

