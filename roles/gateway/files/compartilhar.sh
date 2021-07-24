#!/bin/bash

# Provides: firewall.sh
# Short-Description: Start firewall.sh at boot time
# Description: Enable service provided by firewall.sh
  
# Interface da Internet:
# ifinternet="ppp0"
ifinternet1=""
ifinternet2=""

# Interface da rede local
iflocal=""

iniciar(){
modprobe iptable_nat
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o $ifinternet1 -j MASQUERADE
iptables -t nat -A POSTROUTING -o $ifinternet2 -j MASQUERADE
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
echo 1 > /proc/sys/net/ipv4/conf/default/rp_filter
iptables -A INPUT -m state --state INVALID -j DROP
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -i $iflocal -j ACCEPT
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
}

parar(){
iptables -F
iptables -F -t nat
}

case "$1" in
"start") iniciar ;;
"stop") parar ;;
"restart") parar; iniciar ;;
*) echo "Use os parâmetros start ou stop"
esac

