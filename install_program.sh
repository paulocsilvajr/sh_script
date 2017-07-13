#!/bin/bash

destino=/usr/bin/

is_root(){
# verifica se o programa está sendo executado pelo ROOT("0")
    if [ "$(id -u)" != "0" ]; then
        echo "Execute esse programa como ROOT";
        exit 1
    fi
}

case $1 in
    "")
        echo "Informe um programa.sh para instalar"
        ;;
    "-h"|"--help")
        echo "Instalador de programa.sh personalizado na pasta $destino."
        echo "Necessário reiniciar o terminal para utilizar o programa"
        echo "Caso o programa já exista, será solicito confirmação de sobrescrita"
        echo 
        echo "Sintaxe: $0 programa.sh"
        echo 
        echo "O programa.sh depois de instalado deve ser invocado "
        echo "somente pelo seu nome. Ex: programa.sh -> programa"
        ;;
    *)
        is_root

        # remoção de extensão do arquivo
        nome_programa=${1%.sh}
        # copia do programa para /usr/bin, definição de permissão e 
        # mensagem de confirmação
        cp -vi $1 $destino$nome_programa && chmod 755 /$destino$nome_programa && echo "Reinicie o terminal para utilizar o programa" $nome_programa
        ;;
esac
