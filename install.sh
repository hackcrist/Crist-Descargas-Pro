#!/data/data/com.termux/files/usr/bin/bash

REPO="https://github.com/hackcrist/CristBot-MD"
BOT_DIR="$HOME/CristBot-MD"
DB_FILE="database.json"

clear
echo -e "\033[1;32m🚀 Instalando CristBot-MD...\033[0m"

pkg update -y && pkg upgrade -y
pkg install -y git nodejs ffmpeg libwebp yarn

cd $HOME
rm -rf CristBot-MD
git clone "$REPO"
cd CristBot-MD

yarn install || npm install

if [ -f "$HOME/$DB_FILE" ]; then
  mv "$HOME/$DB_FILE" "$BOT_DIR/$DB_FILE"
fi

echo -e "\033[1;34m\n🔗 Visita y suscríbete al canal YouTube:\033[0m"
echo -e "\033[1;33m👉 https://www.youtube.com/@TechConWin\033[0m\n"

echo -e "\033[1;32m✅ Iniciando el bot...\033[0m\n"
npm start
