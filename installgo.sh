#!/bin/bash
#SCRIPT CREATO PER ORANGEPI CHE HA REPO OUTDATED E QUINDI USO QUESTO PER METTERE GO AGGIORNATO FORZANDO 

GO_VERSION=1.21.10
GO_ARCHIVE=go$GO_VERSION.linux-armv6l.tar.gz
GO_URL=https://go.dev/dl/$GO_ARCHIVE

echo "➡️ Scarico Go $GO_VERSION..."
wget -q --show-progress $GO_URL

echo "  Rimuovo Go precedente (se presente)..."
sudo rm -rf /usr/local/go

echo "📦 Estraggo Go..."
sudo tar -C /usr/local -xzf $GO_ARCHIVE

echo "🛠️ Aggiungo Go al PATH..."
if ! grep -q "/usr/local/go/bin" ~/.bashrc; then
  echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
fi
source ~/.bashrc

echo "✅ Go installato:"
go version



