#!/bin/bash
clear
rojo='\e[34m'
reset='\033[0m'
echo -e "        ${rojo}████████████████▀█████████████"
echo -e "        █▄─▄███─▄▄─█─▄▄▄▄█▄─▄█▄─▀█▄─▄█ "
echo -e "        ██─██▀█─██─█─██▄─██─███─█▄▀─██"
echo -e "        ▀▄▄▄▄▄▀▄▄▄▄▀▄▄▄▄▄▀▄▄▄▀▄▄▄▀▀▄▄▀ ${reset}"
echo "Por favor, ingrese su usuario para continuar"

read -p "Usuario: " usuario

if ! id -u "$usuario" >/dev/null 2>&1; then
    echo "El usuario '$usuario' no existe en el sistema"
    exit 1
fi

intentos=1
while [ $intentos -le 3 ]; do
    read -s -p "Contraseña del usuario $usuario:" contrasena

    if sudo -l -U "$usuario" -S >/dev/null 2>&1 <<< "$contrasena"; then
        . ./bienvenida.sh
        . ./terminal.sh
        exit 0
    else
        echo -e "\n\033[31m ERROR La contraseña es incorrecta\033[0m \n"
        intentos=$(expr $intentos + 1)
    fi
done

echo "Número máximo de intentos alcanzado. Adiós."
exit 1
