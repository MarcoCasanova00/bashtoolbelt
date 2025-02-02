#!/bin/bash

while true; do
    read -p "Scegli un valore da 0 a 937 per settare la luminosità: " brightness

    # Controlla se l'input è un numero intero
    if [[ "$brightness" =~ ^[0-9]+$ ]]; then
        # Controlla se il numero è nel range accettabile
        if [ "$brightness" -ge 0 ] && [ "$brightness" -le 937 ]; then
            brightnessctl -d intel_backlight s "${brightness}"
            
            # Chiedi conferma all'utente
            read -p "Il valore va bene? (y/n): " confirm
            case "$confirm" in
                [Yy]*) exit 0 ;;  # Esce se l'utente conferma con "y" o "Y"
                [Nn]*) continue ;; # Ripete il ciclo se l'utente risponde "n" o "N"
                *) echo "Risposta non valida. Riprova." ;;
            esac
        else
            echo "Errore: Il valore deve essere tra 0 e 937."
        fi
    else
        echo "Errore: Inserisci solo numeri interi."
    fi
done