#!/data/data/com.termux/files/usr/bin/bash

set -e
BOT_NAME="CristBot-MD"
REPO_URL="https://github.com/hackcrist/CristBot-MD"
INSTALL_DIR="$HOME/$BOT_NAME"
DB_FILE="database.json"

# Colores
GREEN='\033[0;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # Sin color

clear
echo -e "${BLUE}🔧 Instalando $BOT_NAME...${NC}"

# Actualizar paquetes
pkg update -y && pkg upgrade -y
pkg install -y git nodejs ffmpeg libwebp yarn

# Clonar el repositorio
cd $HOME
rm -rf "$BOT_NAME"
echo -e "${YELLOW}📥 Clonando repositorio desde GitHub...${NC}"
git clone "$REPO_URL"
cd "$INSTALL_DIR"

echo -e "${YELLOW}📦 Instalando dependencias...${NC}"
yarn install || npm install

# Restaurar base de datos si existe
if [ -f "$HOME/$DB_FILE" ]; then
  echo -e "${YELLOW}🔁 Restaurando $DB_FILE...${NC}"
  mv "$HOME/$DB_FILE" "$INSTALL_DIR/$DB_FILE"
fi

# Mensaje de YouTube
echo -e "\n${GREEN}✅ Instalación completa.\n" 
echo -e "${BLUE}📺 Suscríbete al canal: https://www.youtube.com/@TechConWin${NC}\n"

# Iniciar el bot
echo -e "${GREEN}🚀 Iniciando el bot...${NC}"
npm start
