#!/bin/bash

GREEN='\033[1;32m'
BLUE='\033[1;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

while true; do
  clear
  echo -e "${CYAN}┌────────────────────────────────────────────┐${NC}"
  echo -e "${CYAN}│${NC}       ${BLUE}Bienvenido a Crist-Descargas Pro v3.0${CYAN}       │${NC}"
  echo -e "${CYAN}│${NC}         ${YELLOW}Tu descargador multimedia favorito${CYAN}         │${NC}"
  echo -e "${CYAN}└────────────────────────────────────────────┘${NC}"
  echo -e "${YELLOW}                 by Crist${NC}\n"

  figlet -f small "Descargas v3.0" | lolcat

  echo "==============================================" | lolcat
  echo " 1) Descargar video en MP4 HD (1080p)" | lolcat
  echo " 2) Descargar música en MP3" | lolcat
  echo " 3) Descargar película (máxima calidad)" | lolcat
  echo " 4) Descargar video de TikTok" | lolcat
  echo " 5) Descargar video de Facebook" | lolcat
  echo " 6) Buscar por nombre (v/m)" | lolcat
  echo " 7) Salir" | lolcat
  echo "==============================================" | lolcat
  read -p " Elige una opción: " opcion

  if [ "$opcion" = "7" ]; then
    echo -e "${GREEN}¡Gracias por usar Crist-Descargas!${NC}"
    exit 0
  fi

  if [ "$opcion" = "6" ]; then
    read -p " Ingresa el nombre del video o canción: " nombre
    read -p " ¿Quieres descargar (v)ideo o (m)úsica? [v/m]: " tipo
    enlace="ytsearch1:$nombre"
  else
    read -p " Pega el enlace del video o página o URL: " enlace
  fi

  output="$HOME/storage/downloads/%(title)s.%(ext)s"

  case $opcion in
    1)
      yt-dlp -f "bestvideo[ext=mp4][height<=1080]+bestaudio[ext=m4a]/best[ext=mp4]" "$enlace" --merge-output-format mp4 --downloader aria2c --downloader-args "aria2c:-x16 -k1M" -o "$output"
      ;;
    2)
      yt-dlp --extract-audio --audio-format mp3 "$enlace" --downloader aria2c --downloader-args "aria2c:-x16 -k1M" -o "$output"
      ;;
    3)
      yt-dlp -f "bestvideo+bestaudio/best" "$enlace" --merge-output-format mp4 --downloader aria2c --downloader-args "aria2c:-x16 -k1M" -o "$output"
      ;;
    4)
      yt-dlp -f "bestvideo+bestaudio/best" "$enlace" --merge-output-format mp4 --downloader aria2c --downloader-args "aria2c:-x16 -k1M" -o "$output"
      ;;
    5)
      yt-dlp -f "bestvideo+bestaudio/best" "$enlace" --merge-output-format mp4 --downloader aria2c --downloader-args "aria2c:-x16 -k1M" -o "$output"
      ;;
    6)
      if [[ "$tipo" == "m" || "$tipo" == "M" ]]; then
        yt-dlp -f "bestaudio[ext=m4a]/bestaudio" "$enlace" --extract-audio --audio-format mp3 --downloader aria2c --downloader-args "aria2c:-x16 -k1M" -o "$output"
      else
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
