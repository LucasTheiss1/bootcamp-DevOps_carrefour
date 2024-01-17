#!/bin/bash

echo "Removendo diretórios"

rm -rf /publico
rm -rf /adm
rm -rf /ven
rm -rf /sec

echo "Removendo grupos"

groupdel GRP_ADM
groupdel GRP_VEN
groupdel GRP_SEC

echo "Removendo usuários"

userdel -r carlos
userdel -r maria
userdel -r joao
userdel -r debora
userdel -r sebastiana
userdel -r roberto
userdel -r josefina
userdel -r amanda
userdel -r rogerio

echo "Finalizado!"
