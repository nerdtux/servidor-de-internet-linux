# Dados da interfaces de rede conectadas com a internet - Link 1
isp_1=          # Interface de rede1
tabela_1=       # Tabela igual tabela_1 ao arquivo main.yml
gateway_1=      # Gateway para acesso ao provedor
peso_isp_1=     # A soma tem que dar 100

# Dados da interfaces de rede conectadas com a internet - Link 2
isp_2=          # Interface de rede2
tabela_2=       # Tabela igual tabela_2 do arquivo main.yaml
gateway_2=      # Gateway para acesso ao provedor
peso_isp_2=     # A soma tem que dar 100

# Dados da Rede Interna
placa_rede_interna=
rede_interna=0.0.0.0


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
