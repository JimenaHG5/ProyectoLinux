#!/bin/bash
#terminal nueva
#bienvenida
trap '' INT
stty susp ^0
ruta=$(pwd) 
comandos=("ayuda" "busqueda" "ahorcado" "infosis" "creditosh" "fecha" "mp3" )
comando=""
while true;
do
    terminalnueva="$(pwd)"
    printf ">""\e[0;36m$terminalnueva\e[0;37m " 
    read -e -p " " comando 
    for aux in "${comandos[@]}"
    do
        # Compara si la palabra dada es igual a un comando
        if [ "$comando" == "$aux" ]
        then
                . "$ruta/$comando.sh"
                comando=" "
                break 
              
        fi
    done
    if [ "$comando" == "salir" ]; then
            comando=" "
            break
    fi
    $comando
    
done

echo -e "\e[34;1m  ███████████████████████████████████████████████████████████████████████████████████████████"
echo -e "\e[34;1m  █▄─▀█▄─▄█─▄▄─█─▄▄▄▄███▄─█─▄█▄─▄▄─█▄─▀█▀─▄█─▄▄─█─▄▄▄▄███▄─▄▄─█▄─▄▄▀█─▄▄─█▄─▀█▄─▄█─▄─▄─█─▄▄─█"
echo -e "\e[34;1m  ██─█▄▀─██─██─█▄▄▄▄─████▄▀▄███─▄█▀██─█▄█─██─██─█▄▄▄▄─████─▄▄▄██─▄─▄█─██─██─█▄▀─████─███─██─█"
echo -e "\e[34;1m   ▄▄▄▀▀▄▄▀▄▄▄▄▀▄▄▄▄▄▀▀▀▀▀▄▀▀▀▄▄▄▄▄▀▄▄▄▀▄▄▄▀▄▄▄▄▀▄▄▄▄▄▀▀▀▄▄▄▀▀▀▄▄▀▄▄▀▄▄▄▄▀▄▄▄▀▀▄▄▀▀▄▄▄▀▀▄▄▄▄"
