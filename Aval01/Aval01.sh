#!/bin/bash
# Este script é um exercício para o Curso Administração de SO Linux
# da Universidade de Caxias do Sul.
#
# O Objetivo deste script é controlar um arquivo com IPs que poderia
# ser usado em uma ACL de proxy, por exemplo.


ArquivoControle="/etc/ips.txt"
#ArquivoControle="ips.txt"


# TODO - Se arquivo não existe, crie-o.
test -f $ArquivoControle || touch $ArquivoControle 2>> aval01.log

IP="null"
Param=$#
if [ \( "$Param" -lt 1 \) -o \( "$Param" -gt 2 \) ]
then
   echo
   echo "Erro na chamada" ;  
   echo "Para ajuda, digite: "$0" -h" ;    
   echo
  exit 4 ; 
else
   if [ $Param -eq 2 ]
   then
      IP=$2 ;  
#      echo "recebeu segundo parâmetro"
#  else 
#      echo "somente um parâmetro"
   fi
fi



Adicionar(){

# TODO - Testar se IP passado depois do parâmetro "-a" é válido.
# Caso seja inválido, informar ao usuário e sair com codigo de erro 1.
# TODO - Inserir IP no "ArquivoControle" sem sobrescreve ro arquivo.
# TODO - Exibir uma mensagem de sucesso para o usuário.
# Sair com código de erro 0.

# Separa cada octeto, ignorando-os caso não exista o delimitador "."
o1=`echo $IP | cut -d "." -f 1 -s` 
o2=`echo $IP | cut -d "." -f 2 -s`  
o3=`echo $IP | cut -d "." -f 3 -s` 
o4=`echo $IP | cut -d "." -f 4 -s` 


if [ \( "$o1" -ge 0 -a "$o1" -le 255 \) -a \( "$o2" -ge 0 -a "$o2" -le 255 \)  -a  \( "$o3" -ge 0 -a "$o3" -le 255 \)  -a \( "$o4" -ge 0 -a "$o4" -le 255 \) ] 2> /dev/null ;
then
   echo $IP >> $ArquivoControle
   echo
   echo "IP adicionado com sucesso"
   echo
   exit 0
else
   echo ;
   echo "IP Invalido!"; 
   echo ;
   exit 1; 
fi
}
 


Remover(){

# TODO - Procurar IP passado depois do parâmetro "-d" no "ArquivoControle".
# Caso seja encontrado, remover e exibir uma mensagem de sucesso. Saia com código de erro 0.
# Caso não seja encontrado, exibir mensagem de erro e sair com código de erro 2.
# TODO - CUIDADO: Caracteres especiais no IP informado podem fazer um estrago no arquivo. ex.: "192.168.0.*"
# TODO - CUIDADO: Na busca pelo IP, não confunda 192.168.0.1 com 192.168.0.10

Erro=2
if [ `cat $ArquivoControle | grep $IP | wc -l` -gt 0 ] ;
then
   touch temp.tmp ; 
   while read line
   do
# Se a linha do arquivo não for igual ao parametro recebido (IP informado)
       if [ ! "$line" == "$IP" ] ;
       then 
          echo "$line" >> temp.tmp ;
       else
# Encontrou uma linha no arquivo igual ao parametro recebido (IP informado)
          Erro=0 ;
       fi
   done < $ArquivoControle
   cat temp.tmp > $ArquivoControle ;
   rm -f temp.tmp ; 
fi
if [ "$Erro" -eq 0 ] ;
then 
   echo
   echo "IP "$IP" removido com sucesso";
   echo
else
   echo
   echo "Erro. IP não encontrado no arquivo";
   echo
fi
exit $Erro 
}



Listar(){

# TODO - Listar todos os IPs do "ArquivoControle"
# Sair com código de erro 0.
# TODO - Caso algum IP tenha sido passado como parâmetro, usar como filtro.
# Exibir IPs encontrados com o filtro e sair com código de erro 0.
# Caso nenhum IP seja encontrado, exibir mensagem de erro e sair com código de erro 3.

# Permite que a busca seja feita com parte do IP
if [ "$IP" == "null" ] ;
  then 
     cat $ArquivoControle ; 
     exit 0 ;
  else
     if [  ` cat $ArquivoControle | grep $IP | wc -l ` -gt 0 ] ;
       then 
          cat $ArquivoControle | grep $IP ;
          exit 0 ;
       else 
         echo ;
         echo "IP não encontrado" ; 
         echo ;
         exit 3 ; 
     fi 
fi
}



Ajuda(){

# TODO - Informar ao usuário a forma de uso desse script (todas as opções possíveis).
echo 
echo $0"   - Texto de Ajuda (Modo de Uso)" 
echo "        -a, --add     <IP>    [Adiciona um IP no arquivo]"
echo "        -d, --delete  <IP>    [Remove um IP do arquivo]"
echo "        -l, --list    <IP>    [Lista o IP caso exista no arquivo]"
echo "        -l, --list            [Lista todos os IPs contidos no arquivo]"
echo "        -h, --help    <IP>    [Exibe estas informações de ajuda]"
echo
}



# Case para receber parâmetros e chamar função correspondente

# TODO - Aceitar "--add" para chamar a função "Adicionar"
# TODO - Aceitar "--delete" para chamar a função "Remover"
# TODO - Aceitar "--list" para chamar a função "Listar"
# TODO - Aceitar "--help" para chamar a função "Ajuda"
# TODO - Exibir uma mensagem de "uso" quando o parâmetro passado não for reconhecido
# TODO - Os parâmetros podem estar em qualquer posição e, ainda assim, devem funcionar corretamente

case $1 in
-a|--add)
Adicionar
;;
-d|--delete)
Remover
;;
-l|--list)
Listar
;;
-h|--help)
Ajuda
;;
esac