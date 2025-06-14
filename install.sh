#!/data/data/com.termux/files/usr/bin/bash

GREEN='\033[1;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

clear
echo -e "${GREEN}Instalando Crist-Descargas-Pro v3.0...${NC}"

pkg update -y && pkg upgrade -y
pkg install -y python ffmpeg aria2 git figlet ruby curl
gem install lolcat
pip install -U yt-dlp

mkdir -p $HOME/.crist
curl -sL https://raw.githubusercontent.com/hackcrist/Crist-Descargas-Pro/main/crist-descargas.sh -o $HOME/.crist/crist-descargas.sh
chmod +x $HOME/.crist/crist-descargas.sh

alias_cmd="alias crist-descargas='bash \$HOME/.crist/crist-descargas.sh'"
grep -qxF "$alias_cmd" $HOME/.bashrc || echo "$alias_cmd" >> $HOME/.bashrc
grep -qxF "$alias_cmd" $HOME/.zshrc 2>/dev/null || echo "$alias_cmd" >> $HOME/.zshrc

termux-setup-storage

echo -e "\n${GREEN}✔ Instalación completada.${NC}"
echo -e "${YELLOW}Usa el comando:${NC} ${BLUE}crist-descargas${NC}"
