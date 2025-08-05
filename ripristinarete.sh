#!/bin/bash
#SCRIPT CREATO PER ORANGEPI CHE HA PROBLEMI A CONNETTERSI QUANDO STA IN SSH CON LAN E VUOLE CONNETTERSI IN WLAN ... HA PROBLEMI DI DNS E ALTRO CREDO

# Modifica questi con i tuoi dati Wi-Fi
SSID="INSERISCI"
PASSWORD="INSERISCI"
GATEWAY="INSERISCI"
IFACE="INSERISCI"

echo "Attivo interfaccia $IFACE..."
sudo ip link set $IFACE up

echo "Connetto a Wi-Fi $SSID..."
nmcli device wifi connect "$SSID" password "$PASSWORD"

sleep 5

echo "Aggiungo rotta di default tramite $GATEWAY..."
sudo ip route del default 2>/dev/null
sudo ip route add default via $GATEWAY dev $IFACE

echo "Imposto DNS in /etc/resolv.conf..."
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null

echo "Controllo stato rete..."
ip a show $IFACE
ip route show
ping -c 3 8.8.8.8

echo "Fatto."
