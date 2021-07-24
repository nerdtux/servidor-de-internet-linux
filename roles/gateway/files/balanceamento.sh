# Dados da interfaces de rede conectadas com a internet - Link 1
isp_1=eth0
tabela_1=nome_tabela_1
gateway_1=192.168.0.1
peso_isp_1=30

# Dados da interfaces de rede conectadas com a internet - Link 2
isp_2=eth1
tabela_2=nome_tabela_2
gateway_2=192.168.1.1
peso_isp_2=70

# Dados da Rede Interna
placa_rede_interna=eth2
rede_interna=10.0.0.0/24


# Deletar a rota default
ip route del default

# Limpa as regras das tabelas
ip route flush table $tabela_1
ip route flush table $tabela_2

# Define a rota para as tabelas
ip route add default dev $isp_1 via $gateway_1 table $tabela_1
ip route add default dev $isp_2 via $gateway_2 table $tabela_2

# Define as regras para balanceamento dos links
ip route add default scope global nexthop via $gateway_1 dev $isp_1 weight $peso_isp_1 nexthop via $gateway_2 dev $isp_2 weight $peso_isp_2

# Aplicar as regras
ip route flush cache

# Compartilha a conexão
iptables -t nat -A POSTROUTING -o $isp_1 -j MASQUERADE
iptables -t nat -A POSTROUTING -o $isp_2 -j MASQUERADE

# Firewall
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
iptables -A INPUT -m state --state INVALID -j DROP
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -i $placa_rede_interna -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 54510 -j ACCEPT
iptables -A INPUT -p tcp --dport 22321 -j ACCEPT
iptables -A INPUT -p tcp --dport 30000 -j ACCEPT
iptables -A INPUT -p tcp --dport 30003 -j ACCEPT
iptables -A INPUT -p tcp --dport 30004 -j ACCEPT
iptables -A INPUT -p udp --dport 30003 -j ACCEPT
iptables -A INPUT -p udp --dport 30004 -j ACCEPT
iptables -A INPUT -p tcp --dport 54511 -j ACCEPT
iptables -A INPUT -p tcp --dport 8080  -j ACCEPT
iptables -A INPUT -p tcp --dport 37777 -j ACCEPT
iptables -A INPUT -p tcp --dport 587 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 587 -j ACCEPT
iptables -A FORWARD -p tcp -s 192.168.0.0/24 --dport 587 -j ACCEPT
iptables -A INPUT -p tcp --syn -j DROP
