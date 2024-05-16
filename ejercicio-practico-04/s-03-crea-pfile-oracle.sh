#!/bin/bash

echo "1. Creando un archivo de parámetros básico"

export ORACLE_SID=gcbbda2

pfile=$ORACLE_HOME/dbs/initgcbbda2.ora

if [ -f "${pfile}" ]; then
	read -p "El archivo ${pfile} ya existe, [enter] para sobrescribir"
fi;

echo \
"db_name=gcbbda2
memory_target=768M
control_files=(
/unam-bda/d01/app/oracle/oradata/GCBBDA2/control01.ctl,
/unam-bda/d02/app/oracle/oradata/GCBBDA2/control02.ctl,
/unam-bda/d03/app/oracle/oradata/GCBBDA2/control03.ctl
)" > $pfile

echo "Listo"
echo "Comprobando la existencia y contenido del PFILE"
echo ""
cat ${pfile}
