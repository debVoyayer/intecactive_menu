#!/bin/bash
set -x # Habilita la depuración

DELAY=8
LOG_FILE="resultado.log"

echo "LOG_FILE: $LOG_FILE" # Verifica la variable LOG_FILE

touch "$LOG_FILE"

while true; do
    clear
    cat << EOF
        Selecciona una opción:
        1. Muestra archivos con sus extensiones y permisos
        2. Enumera directorios y subdirectorios
        3. Lista los grupos de tu usuario
        0. Quit
EOF

    read -p "Introduzca la opción deseada > " REPLY

    case "$REPLY" in
        0)
            break
            ;;
        1)
            echo "Archivos:"
            DATE_TIME=$(date "+%Y-%m-%d %H:%M:%S")
            CURRENT_DIR=$(pwd) # Obtiene el directorio actual
            echo "DATE_TIME: $DATE_TIME" # Verifica la variable DATE_TIME
            echo "-----------------------------------------" >> "$LOG_FILE"
            echo "Directorio: $CURRENT_DIR" >> "$LOG_FILE"
            echo "Fecha y hora: $DATE_TIME" >> "$LOG_FILE"
            # ls -la | tee -a "$LOG_FILE" # Comentado para verificar ls -la
            ls -la > temp.txt
            cat temp.txt >> "$LOG_FILE"
            rm temp.txt
            echo "-----------------------------------------" >> "$LOG_FILE"
            ls -la
            ;;
        2)
            echo "Directorios y subdirectorios:"
            find . -type d -print
            ;;
        3)
            echo "Grupos:"
            id | awk -F '[()]' '{print $2, $4, $6, $8, $10}'
            ;;
        *)
            echo "Opción inválida."
            ;;
    esac
    sleep "$DELAY"
done

echo "Programa terminado."