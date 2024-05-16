#!/bin/bash

echo "Creando archivo de password para nueva BD"

orapwd FILE='${ORACLE_HOME}/dbs/orapwgcbbda2' \
FORMAT=12.2 \
SYS=password \

echo "Mostrando el archivo de password creado"
ls -l $ORACLE_HOME/dbs/orapwgcbbda2
