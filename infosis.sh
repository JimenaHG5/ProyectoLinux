#!/bin/bash
#infosis
echo -e "\e[0;35m el sistema operativo y su version es la siguiente \e[0m"
lsb_release -a 2>/dev/null | grep -i "Distributor ID\|Release" | awk '{print $3,$2}'
echo -e "\e[0;35mla cpu que usted posee y su arquitectura es\e[0m"
lscpu | grep -E '(Model name:|Arquitectura:)'
lscpu | grep -E '(Model name:|Nombre del modelo: )'
lscpu | grep -E '^CPU\(s\):|^Thread\(s\) per core:'
echo -e "\e[0;35mla modelo de gpu es:    \e[0m"
sudo lshw -C display | grep -i "producto" | awk '{print $3,$4,$5,$6,$7}'
echo -e "\e[0;35mla ram instalada es la siguiente :   \e[0m"
cat /proc/meminfo | grep "MemTotal" | awk '{print $2/1024/1024 " GB"}'
sudo dmidecode --type memory | awk '/Type:|Speed:/ {print $2}' | sed 'N;s/\n/ /;N;s/\n/ /'
