#!/bin/bash
# Este script é um exercício para o Curso Administração de SO Linux
# da Universidade de Caxias do Sul.
#

# Passo 1
# Informe quantos ARQUIVOS existem no diretório "/etc", somente no 1º nível.
# Solicite <enter> para prosseguir.
echo "----------------------- Passo 1 ----------------------------"
echo "Número de arquivos no /etc: " $(ls -la /etc | cut -c1 | grep "-" | wc -l)
read -p  "Pressione <Enter> para continuar... "  key


# Passo 2
# Informe qual o modelo e frequência do processador da sua máquina. Essa informação está em "/proc/cpuinfo".
# Solicite <enter> para prosseguir.
echo "----------------------- Passo 2 ----------------------------"
echo "Modelo do processador: " $(cat /proc/cpuinfo | grep "model name" | cut -d ":" -f2 | tail -1)
echo "Frequencia do processador: " $(cat /proc/cpuinfo | grep -i "cpu mhz" | cut -d ":" -f2 | tail -1)
read -p  "Pressione <Enter> para continuar... "  key


# Passo 3
# Informe a situação do roteamento, se está ou não habilitado. Essa informação está em "/proc/sys/net/ipv4/ip_forward". 
# Solicite <enter> para prosseguir.
echo "----------------------- Passo 3 ----------------------------"
var1=$(cat /proc/sys/net/ipv4/ip_forward)
test $var1 == 0 && echo "Roteamento desabilitado" || echo "Roteamento habilitado"

echo "---------- A seguir, Passo 3 com outra sintaxe -------------"
if [ $var1 == 0 ]; then echo "Roteamento desabilitado"; else echo "Roteamento habilitado"; fi
read -p  "Pressione <Enter> para continuar... "  key


# Passo 4
# 
# Solicite <enter> para encerrar o script.
echo "----------------------- Passo 4 ----------------------------"
read -p  "Pressione <Enter> para encerrar o script... "  key

