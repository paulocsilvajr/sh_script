#!/bin/bash

case $1 in
    "")
        echo 'Informe um cálculo como parâmetro ou -h para ajuda'
        ;;
    "-h"|"--help")
        echo "Cálculos matemáticos pelo terminal."
        echo "O cálculo devem estar entre aspas simples e não conter espaços"
        echo "Sintaxe: $0 'operacao'"
        echo "         $0 [ -h | --help ]"
        echo "Ex:      $0 '1+1'     =>     2"
        echo "         $0 '2*(2+4)' =>    16"
        echo "         $0 '1*2,2*3' => (2,6)"
        ;;
    *)
        # cálculo efetuado pelo python, com direcionamento de erro
        # para /dev/null e tratamento da mensagem de erro
        python3 -c "print($1)" 2> /dev/null || echo 'Cálculo inválido'
        ;;
esac
