#!/bin/bash

echo "Ingrese la contraseña del usuario oracle"
su -l oracle

echo "Cambiandonos al directorio GCBBDA2"
cd /u01/app/oracle/GCBBDA2/

echo "Verificar el directorio"
pwd

echo "Creando directorios disk1, disk2 y disk3"
mkdir disk1 disk2 disk3

echo "Cambiandos los permisos"
chmod 750 disk1 disk2 disk3

echo "Cambiando el dueño y grupo de usuario"
chown oracle:oinstall disk1 disk2 disk3

