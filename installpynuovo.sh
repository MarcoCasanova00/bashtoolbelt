#!/bin/bash
#SCRIPT CREATO PER ORANGEPI CHE HA REPO OUTDATED E QUINDI NON INSTALL PYTHON NUOVO, CON QUESTO FORZO IL NUOVO

set -e

echo "Aggiornamento pacchetti e installazione dipendenze per compilare Python..."
sudo apt-get update
sudo apt-get install -y build-essential libssl-dev zlib1g-dev libncurses5-dev \
libsqlite3-dev libreadline-dev libffi-dev wget

PYTHON_VERSION=3.9.17

echo "Scarico Python $PYTHON_VERSION..."
cd /tmp
wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz

echo "Estraggo..."
tar xf Python-$PYTHON_VERSION.tgz
cd Python-$PYTHON_VERSION

echo "Configuro e compilo Python..."
./configure --enable-optimizations
make -j$(nproc)

echo "Installazione Python 3.9..."
sudo make altinstall

echo "Verifica installazione:"
python3.9 --version

echo "Aggiorno pip per Python 3.9..."
python3.9 -m ensurepip --upgrade
python3.9 -m pip install --upgrade pip setuptools wheel

echo "Installazione completata."
echo "Ora puoi usare python3.9 e pip3.9 per il tuo progetto."
echo "Esempio: pip3.9 install -r requirements.txt"

