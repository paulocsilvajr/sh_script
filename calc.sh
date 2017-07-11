#!/bin/bash

case $1 in
    "")
        echo 'Informe um cálculo como parâmetro ou -h para ajuda'
        ;;
    "-h"|"--help")
        echo 'Cálculos matemáticos pelo terminal.'
        echo "O cálculo devem estar entre aspas simples e não conter espaços"
        echo "Ex: calc '1+1'     =>     2"
        echo "    calc '2*(2+4)' =>    16"
        echo "    calc '1*2,2*3' => (2,6)"
        ;;
    *)
        # cálculo efetuado pelo python, com direcionamento de erro
        # para /dev/null e tratamento da mensagem de erro
        python -c "print($1)" 2> /dev/null || echo 'Cálculo inválido'
        ;;
esac
