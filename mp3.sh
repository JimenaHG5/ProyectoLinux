#!/bin/bash

# Función para reproducir la música
reproducir() {
  cd "$ruta" || exit # Cambiar de directorio
  mpg123 ./*.mp3 # Reproducir la música
}

# Función para mostrar la lista de canciones
lista() {
  cd "$ruta" || exit # Cambiar de directorio
  ls *.mp3 > .lista # Crear el archivo de lista de canciones
  whiptail --title "REPRODUCTOR DE MÚSICA" --textbox .lista 20 80 # Mostrar la lista de canciones en una ventana
}

# Función para mostrar las instrucciones de uso del programa
instrucciones() {
  whiptail --title "INSTRUCCIONES" --msgbox "Presiona 'h' en la terminal cuando se esté reproduciendo la música, presiona f para la siguiente canción" 10 80
}

# Función para pedir la ruta de la carpeta con las canciones
pedir_ruta() {
  ruta=$(whiptail --title "REPRODUCTOR DE MÚSICA" --inputbox "Ingresa la ruta donde tienes tu música con el siguiente formato (/ruta):" 10 80 --title "Ruta de la carpeta de música" 3>&1 1>&2 2>&3)
  if [[ ! -d "$ruta" ]]; then # Verificar que la ruta existe
    whiptail --title "ERROR" --msgbox "La ruta que ingresaste no existe." 10 80
    pedir_ruta # Pedir de nuevo la ruta
  fi
}

# Función para verificar si el paquete mpg123 está instalado
verificar_paquete() {
  if ! command -v mpg123 &> /dev/null; then
    whiptail --title "ATENCIÓN" --yesno "Para utilizar este programa necesitas tener instalado el paquete mpg123. ¿Deseas instalarlo?" 10 80
    if [[ $? -eq 0 ]]; then
      sudo apt-get update && sudo apt-get install -y mpg123 # Instalar el paquete
    else
      exit
    fi
  fi
}

# Función principal
principal() {
  pedir_ruta # Pedir la ruta de la carpeta con las canciones
  verificar_paquete # Verificar que el paquete mpg123 está instalado
  while true; do # Mostrar el menú de opciones hasta que el usuario decida salir
    opcion=$(whiptail --title "MENU" --menu "Elige una opción" 10 80 3 \
              "1" "Mostrar lista de canciones" \
              "2" "Reproducir música" \
              "3" "Instrucciones" \
              "4" "Salir" \
              3>&1 1>&2 2>&3)
    case $opcion in
      1) lista ;;
      2) reproducir ;;
      3) instrucciones ;;
      4) exit ;;
      *) whiptail --title "ERROR" --msgbox "Opción inválida." 10 80 ;;
    esac
  done
}

principal