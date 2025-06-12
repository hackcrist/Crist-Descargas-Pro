
#!/bin/bash

# Autor: Crist
# Script: instalador de Crist-Descargas-Pro v3.0 (Termux sin banner, con bienvenida en color)

# Colores
GREEN='\033[1;32m'
BLUE='\033[1;34m'
CYAN='\033[0;36m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

clear
echo -e "${GREEN}Instalando Crist-Descargas-Pro v3.0...${NC}"

# Instalar dependencias
pkg update -y
pkg install python ffmpeg aria2 git figlet -y
pip install -U yt-dlp

# Crear carpeta del sistema
mkdir -p $HOME/.crist

# Crear script principal
cat > $HOME/.crist/crist-descargas.sh << 'EOF'
#!/bin/bash

GREEN='\033[1;32m'
BLUE='\033[1;34m'
CYAN='\033[0;36m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

while true; do
  clear
  echo -e "${CYAN}----------------------------------------${NC}"
  echo -e "${CYAN}     Bienvenido a Crist-Descargas       ${NC}"
  echo -e "${CYAN}       Tu descargador multimedia        ${NC}"
  echo -e "${CYAN}----------------------------------------${NC}"
  echo -e "${YELLOW}                 by Crist               ${NC}"
  echo -e "${GREEN}"
  figlet -f small "Descargas v3.0"
  echo -e "${NC}"

  echo "=========================================="
  echo " 1) Video MP4 HD (1080p)"
  echo " 2) Música MP3"
  echo " 3) Película (alta calidad)"
  echo " 4) Video TikTok"
  echo " 5) Video Facebook"
  echo " 6) Buscar por nombre"
  echo " 7) Salir"
  echo "=========================================="
  read -p " Elige una opción: " opcion

  if [ "$opcion" = "7" ]; then
    echo -e "${GREEN}¡Gracias por usar Crist-Descargas!${NC}"
    exit 0
  fi

  if [ "$opcion" = "6" ]; then
    read -p " Ingresa el nombre: " nombre
    read -p " ¿Es video (v) o música (m)? [v/m]: " tipo
    enlace="ytsearch1:$nombre"
  else
    read -p " Pega el enlace del video/página o URL: " enlace
  fi

  output="$HOME/storage/downloads/%(title)s.%(ext)s"

  case $opcion in
    1)
      echo -e "${BLUE}Descargando video HD en MP4...${NC}"
      yt-dlp -f "bestvideo[ext=mp4][height<=1080]+bestaudio[ext=m4a]/best[ext=mp4]" "$enlace" --merge-output-format mp4 --downloader aria2c --downloader-args "aria2c:-x16 -k1M" -o "$output"
      ;;
    2)
      echo -e "${BLUE}Descargando música en MP3...${NC}"
      yt-dlp --extract-audio --audio-format mp3 "$enlace" --downloader aria2c --downloader-args "aria2c:-x16 -k1M" -o "$output"
      ;;
    3)
      echo -e "${BLUE}Descargando película en calidad máxima...${NC}"
      yt-dlp -f "bestvideo+bestaudio/best" "$enlace" --merge-output-format mp4 --downloader aria2c --downloader-args "aria2c:-x16 -k1M" -o "$output"
      ;;
    4)
      echo -e "${BLUE}Descargando video de TikTok...${NC}"
      yt-dlp -f "bestvideo+bestaudio/best" "$enlace" --merge-output-format mp4 --downloader aria2c --downloader-args "aria2c:-x16 -k1M" -o "$output"
      ;;
    5)
      echo -e "${BLUE}Descargando video de Facebook...${NC}"
      yt-dlp -f "bestvideo+bestaudio/best" "$enlace" --merge-output-format mp4 --downloader aria2c --downloader-args "aria2c:-x16 -k1M" -o "$output"
      ;;
    6)
      if [[ "$tipo" == "m" || "$tipo" == "M" ]]; then
        echo -e "${BLUE}Buscando y descargando música (MP3)...${NC}"
        yt-dlp -f "bestaudio[ext=m4a]/bestaudio" "$enlace" --extract-audio --audio-format mp3 --downloader aria2c --downloader-args "aria2c:-x16 -k1M" -o "$output"
      else
        echo -e "${BLUE}Buscando y descargando video (MP4)...${NC}"
        yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]" "$enlace" --merge-output-format mp4 --downloader aria2c --downloader-args "aria2c:-x16 -k1M" -o "$output"
      fi
      ;;
    *)
      echo -e "${RED}Opción inválida.${NC}"
      ;;
  esac

  echo -e "${GREEN}\n¡Descarga completada! Presiona Enter para volver al menú...${NC}"
  read
done
EOF

# Permisos y alias
chmod +x $HOME/.crist/crist-descargas.sh
grep -qxF "alias crist-descargas='bash \$HOME/.crist/crist-descargas.sh'" $HOME/.bashrc || echo "alias crist-descargas='bash \$HOME/.crist/crist-descargas.sh'" >> $HOME/.bashrc
grep -qxF "alias crist-descargas='bash \$HOME/.crist/crist-descargas.sh'" $HOME/.zshrc || echo "alias crist-descargas='bash \$HOME/.crist/crist-descargas.sh'" >> $HOME/.zshrc
source $HOME/.bashrc 2>/dev/null || true

termux-setup-storage

echo -e "\n${GREEN}¡Instalación completa!${NC}"
echo -e "Usa el comando: ${BLUE}crist-descargas${NC}"
echo -e "${GREEN}Gracias por usar este script.${NC}"
