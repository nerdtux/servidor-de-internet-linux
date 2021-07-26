#!/bin/bash
### BEGIN INIT INFO
# Provides:          failover.sh
# Required-Start:    $all
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:
### END INIT INFO

# Tempo esperado para testar a conexão novamente
tempo_espera=30

# Número de pacotes a ser pingados
numero_pacotes=2

# Nome das interfaces de rede conectadas com a internet
isp_1=interface_rede1
isp_2=interface_rede2

# Gateway das interfaces
gateway_1=0.0.0.0
gateway_2=0.0.0.0

# Endereço IP a ser pingado (8.8.8.8 é o DNS do Google)
endereco_ping=8.8.8.8

# Arquivo de balanceamento de links
arquivo=/internet/balanceamento.sh

# Não alterar nada daqui para baixo
# Variáveis destinadas ao controle
i=0
link1=1
link2=1

# Ativação do Balanceamento de Links
function iniciar(){
sh $arquivo > /dev/null

while [ $i -le 10 ];
do

if [ $link1 = 0 ] || [ $link2 = 0 ]; then
sh $arquivo > /dev/null
fi

if (ping -I $isp_1 -c $numero_pacotes $endereco_ping > /dev/null)
then
link1="1"
else
ip route del default
ip route add default via $gateway_2
ip route flush cache
link1="0"
fi

if (ping -I $isp_2 -c $numero_pacotes $endereco_ping > /dev/null)
then
link2="1"
else
ip route del default
ip route add default via $gateway_1
ip route flush cache
link2="0"
fi

sleep $tempo_espera

done 
}

function parar(){
	iptables -F
	iptables -F -t nat
}

case "$1" in
	"start") iniciar ;;
	"stop") parar ;;
	"restart") parar; iniciar ;;
	*) echo "Use os parâmetros start ou stop"
esac
