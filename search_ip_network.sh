#!/bin/bash

IP_BASE="192.168.1."
SERVER=1
INICIAL=100
FINAL=254

ips_encontrados="Host list received ECHO_REQUEST:    "
ultimo_testado=""
cont=0

# trap redireciona ação quando CTRL+c for pressionado
trap sair INT

sair(){
    if [ "$ultimo_testado" != "${IP_BASE}${FINAL}" ]; then
        echo -e "\rLast: $ultimo_testado, $cont received    "
        c="\n"
    else
        c="\r"
    fi

    echo -e ${c}${ips_encontrados}"\n$cont received"
    exit 0
}

ajuda(){
    echo "Ping em intervalo de rede para encontrar hosts."
    echo
    echo "Sintaxe: $0 [ -h ] [ -b ip_base ] [ -s end_servidor] [ -i end_inicial ] [ -f end_final ]"
    echo "-h                ajuda"
    echo "-b ip_base        IP base da rede. Default=$IP_BASE"
    echo "-s end_servidor   Endereço do servidor, em inteiro. Default=$SERVER"
    echo "-i end_inicial    Endereço inicial para busca, em inteiro. Defaul=$INICIAL"
    echo "-f end_final      Endereço final para busca, em inteiro. Defaul=$FINAL"

    exit 0
}

validar_ip(){
    # adicionando . depois do IP_BASE, caso não seja informado.
    # capturando o último caracter do IP_BASE
    # ultimo_caracter=$(echo $IP_BASE | cut -c ${#IP_BASE})
    # utilizando o rev para reverter a string
    ultimo_caracter=$(echo $IP_BASE | rev | cut -c 1)
    if [ "$ultimo_caracter" != "." ];
    then
        IP_BASE="$IP_BASE."
    fi

    # validação de ip
    for end in $SERVER $INICIAL $FINAL
    do
        ip_temp="${IP_BASE}${end}"
        # Expressão regular para validar ip. 
        # Fonte: http://aurelio.net/regex/casar-ip.html
        if echo $ip_temp | egrep '(((1[0-9]|[1-9]?)[0-9]|2([0-4][0-9]|5[0-5]))\.){3}((1[0-9]|[1-9]?)[0-9]|2([0-4][0-9]|5[0-5]))' > /dev/null
        then
            echo -n
        else
            echo "IP inválido" $ip_temp
            exit 1
        fi
    done
}

if [[ $1 = "--help" ]];
then
    ajuda   
fi

while getopts 'hb:s:i:f:' OPTION
do
    case $OPTION in
        h)
            ajuda
            ;;
        b)

            IP_BASE=$OPTARG
            ;;
        s)
            SERVER=$OPTARG
            ;;
        i)
            INICIAL=$OPTARG
            ;;
        f)
            FINAL=$OPTARG
            ;;
        
    esac
done

validar_ip

echo -e "ping ${IP_BASE}${SERVER}, ${IP_BASE}${INICIAL} ... ${IP_BASE}${FINAL}\n"

for i in $SERVER $(seq $INICIAL $FINAL); do
    IP=${IP_BASE}${i}
    resultado=$(ping -c 1 $IP)

    echo -n -e "\rping... $IP, $cont received"

    # Se pingou, incrementa a lista de ips
    if echo $resultado | grep "1 received" > /dev/null
    then
        ips_encontrados=$ips_encontrados"\n$IP"
        # incremento variável inteira
        ((cont++))
    fi

    ultimo_testado=$IP
done

sair

