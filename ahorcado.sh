#!/bin/bash

# Lista de palabras
palabras=("perro" "gato" "elefante" "jirafa" "cebra")

# Seleccionar una palabra aleatoria
palabra=${palabras[$RANDOM % ${#palabras[@]} ]}
letras_por_adivinar=${#palabra}

# Inicializar variables
vidas=5
letras_correctas=()

function dibujar_ahorcado() {
  case $vidas in
    5) 
       echo " _________     "
       echo " | /           " 
       echo " |/            " 
       echo " |             "
       echo " |             " ;;

    4) 
       echo " _________     "
       echo " | /      |    " 
       echo " |/       O    " 
       echo " |             "
       echo " |             " ;;

    3) 
       echo " _________     "
       echo " | /      |    "
       echo " |/       O    "
       echo " |            "
       echo " |          "   ;;

    2) 
       echo " _________     "
       echo " | /      |    "
       echo " |/       O    "
       echo " |       /|\    "
       echo " |            " ;;

    1) 
       echo " _________     "
       echo " | /      |    "
       echo " |/       O    "
       echo " |       /|\    "
       echo " |       / \   " ;;
  esac
}

# Función para imprimir la palabra con las letras adivinadas
function imprimir_palabra() {
  for letra in $(echo $palabra | grep -o .); do
    if [[ "${letras_correctas[*]}" == *"$letra"* ]]; then
      echo -n "$letra "
    else
      echo -n "_ "
    fi
  done
  echo ""
}

# Función para leer la letra del usuario
function leer_letra() {
  while true; do
    echo -n "Adivina una letra: "
    read letra
    if [[ ! "$letra" =~ ^[a-zA-Z]$ ]]; then
      echo "Por favor, introduce una letra."
    else
      break
    fi
  done
}


# Bucle principal
while true; do
  clear
  # Imprimir la palabra con las letras adivinadas
  dibujar_ahorcado
  imprimir_palabra
  longitud=${#palabra}
  # Leer la letra del usuario
  leer_letra
  # Comprobar si la letra está en la palabra
  acierto=false
  for (( i=0; i < $longitud; i++ )); do
    caracter=${palabra:i:1}
    if [[ "$caracter" == "$letra" ]]; then
        letras_correctas+=("$letra")
        letras_por_adivinar=$((--letras_por_adivinar))
        acierto=true
    fi
  done
  if [ "$acierto" == true ]; then
    echo "¡Correcto!"
  else
    vidas=$((vidas - 1))
    echo "Incorrecto. Te quedan $vidas vidas."
    echo "Presiona Enter para continuar..."
    read

  fi
  # Comprobar si el usuario ha ganado o perdido
if [[ "$letras_por_adivinar" == 0 ]]; then
    echo "¡Ganaste! La palabra era $palabra."
    echo "Presiona Enter para continuar..."
    read
    echo -e "\e[32m █░░█ █▀▀█ █░░█ 　 █░░░█ ░▀░ █▀▀▄  "
    echo -e " █▄▄█ █░░█ █░░█ 　 █▄█▄█ ▀█▀ █░░█"
    echo -e " ▄▄▄█ ▀▀▀▀ ░▀▀▀ 　 ░▀░▀░ ▀▀▀ ▀░░▀"
   

    break
  elif [[ "$vidas" == 0 ]]; then

                                                                   
                                                                   
    echo -e "\e[31m           █▀▀▀ █▀▀█ █▀▄▀█ █▀▀ 　 █▀▀█ ▀█░█▀ █▀▀ █▀▀█"
    echo -e "\e[31m           █░▀█ █▄▄█ █░▀░█ █▀▀ 　 █░░█ ░█▄█░ █▀▀ █▄▄▀"
    echo -e "\e[31m           ▀▀▀▀ ▀░░▀ ▀░░░▀ ▀▀▀ 　 ▀▀▀▀ ░░▀░░ ▀▀▀ ▀░▀▀"


    echo "¡Perdiste! La palabra era $palabra."
    echo "Presiona Enter para continuar..."
    read

    break
  fi
done
