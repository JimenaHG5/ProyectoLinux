#!/bin/bash


epoch=$(printf '%(%s)T\n' -1)  # Obtener el número de segundos desde el 1 de enero de 1970
fecha=$(printf '%(%Y-%m-%d)T\n' "$epoch")  # Formatear la fecha y hora en un formato personalizado

echo "la fecha actual es $fecha"  # Imprimir la fecha y hora en la salida estándar
fecha=$(printf '%(%H:%M:%S)T\n' "$epoch")
echo "la hora es $fecha"