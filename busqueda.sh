#!/bin/bash

echo "Ingrese el nombre del directorio que desea buscar: "
read -e -p " " directorio
echo "Ingrese el nombre del archivo que desea buscar: "
read -e -p " " archivo
echo "Buscando el directorio $directorio ..."

# El comando "find" busca el directorio en todo el sistema, comenzando desde la raíz del sistema "/"
# El flag "-type d" especifica que se busquen solo directorios
# El flag "-name" especifica el nombre del directorio que se desea encontrar
resultados=$(find / -type d -name "$directorio" 2>/dev/null | head -n 1)

if [ -n "$resultados" ]
then
    echo "Se encontró el directorio $resultados   \n"
    cd "$resultados"
    archivo_encontrado=$(ls -R "$resultados" | grep "$archivo" | head -n 1)
    if [ -n "$archivo_encontrado" ]
    then
        echo "---------------- El archivo $archivo fue encontrado en  la ruta $resultados ----------- "
        echo "¿Desea abrir el archivo? (s/n)"
        read -e -p " " respuesta
        if [ "$respuesta" == "s" ]
        then
            cat "$archivo_encontrado"
        else
            echo "El archivo no se abrió."
        fi
    else
        echo "El archivo $archivo no fue encontrado en el directorio $resultados."
    fi
else
    echo "El directorio $directorio no se encontró en el sistema."
fi
