#!/bin/bash

ajuda(){
    echo "Agendador de tarefa no crontab para o usuário corrente."
    echo 
    echo "Sintaxe: $0 '* * * * *' /PATH/programa"
    echo "         $0 {-h | --help}"
    echo 
    echo "Informar o agendamento da seguinte forma:"
    echo " * * * * *"
    echo " | | | | |"
    echo " | | | | +----- dia da semana (0 - 6) (domingo=0)"
    echo " | | | +------- mês (1 - 12)"
    echo " | | +--------- dia do mês (1 - 31)"
    echo " | +----------- hora (0 - 23)"
    echo " +------------- minuto (0 - 59)"
    echo
    echo "Deve ser informado o CAMINHO ABSOLUTO do programa."
}

case $1 in
    "")
        echo "Informe um agendamento"
        exit 1
        ;;
    "-h"|"--help")
        ajuda
        ;;
    *)
        if [ ${#1} -lt 8 ]; then
            echo "Agendamento inválido, -h para ajuda."
            exit 1
        fi

        case $2 in
            "")
                echo "Informe um nome de programa"
                exit 1
                ;;
            *)
                # se arquivo não existe 
                if [ ! -e $2 ]; then
                    echo "Programa não existe"
                    exit 1
                # se nome iniciado com ./ é inválido
                elif echo "$2" | egrep '\./' > /dev/null
                then
                    echo "Nome do programa inválido, -h para ajuda"
                    exit 1
                # se não tem / no nome do programa, path recebe $PWD
                elif echo "$2" | egrep -v '/' > /dev/null
                then
                    path=$PWD"/"
                else
                    path=""
                fi

                echo "Incremento de tarefas no crontab do usuário" $(whoami)

                if [ ! -x $2 ]; then
                    echo "Definido privilégio de execução em" $2
                    chmod +x $2
                fi

                # captura do conteúdo do crontab para arquivo temporário
                crontab -l > crontab.temp
                # remove linhas em branco
                sed '/^$/d' crontab.temp > temp.crontab

                echo "$1 $path$2" >> temp.crontab

                # Atribuição de agendamento através de arquivo 
                crontab temp.crontab

                echo "Agendado: $(crontab -l | tail -n 1)"
                
                # remoção dos arquivos temporários
                rm crontab.temp temp.crontab
                ;;
        esac
        ;;
esac

exit 0 

