#!/bin/bash
#@Author: Gustavo Chavez
#Description: Crear los directorios para la creacion de la BD, dando tambien permisos
#y asignando duenios y grupos
#@Date: 16/03/24

echo "Exportando la variables para la BD 2"
export ORACLE_SID=gcbbda2

echo "Cambiando al directorio oradata"
cd /u01/app/oracle/oradata

echo "Creando nuevo directorio"
mkdir GCBBDA2

echo "Asignando duenio oracle y grupo oinstall"
chown oracle:oinstall GCBBDA2

echo "Dando permisos al directorio"
chmod 750 GCBBDA2

echo "Creando directorios en d01"
cd /unam-bda/d01
mkdir -p app/oracle/oradata/GCBBDA2
chown -R oracle:oinstall app
chmod -R 750 app

echo "Creando directorios en d02"
cd /unam-bda/d02
mkdir -p app/oracle/oradata/GCBBDA2
chown -R oracle:oinstall app
chmod -R 750 app

echo "Creando directorios en d03"
cd /unam-bda/d03
mkdir -p app/oracle/oradata/GCBBDA2
chown -R oracle:oinstall app
chmod -R 750 app

echo "Mostrando directorio de data files"

ls -l /u01/app/oracle/oradata

echo "Mostrando directorios para control files y Redo Logs"
ls -l /unam-bda/d0*/app/oracle/oradata
