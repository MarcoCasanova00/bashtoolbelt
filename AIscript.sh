#!/bin/bash

echo "▄▄▄·▄▄▄ .▄▄▄  .▄▄ ·        ▐ ▄  ▄▄▄· ▄▄▌     ▄▄▄· ▪"
echo "▐█ ▄█▀▄.▀·▀▄ █·▐█ ▀.  ▄█▀▄ •█▌▐█▐█ ▀█ ██•    ▐█ ▀█ ██"
echo " ██▀·▐▀▀▪▄▐▀▀▄ ▄▀▀▀█▄▐█▌.▐▌▐█▐▐▌▄█▀▀█ ██ ▪   ▄█▀▀█ ▐█·"
echo "▐█▪·•▐█▄▄▌▐█•█▌▐█▄▪▐█▐█▌.▐▌██▐█▌▐█▪ ▐▌▐█▌ ▄  ▐█▪ ▐▌▐█▌"
echo ".▀    ▀▀▀ .▀  ▀ ▀▀▀▀  ▀█▄▀▪▀▀ █▪ ▀  ▀ .▀▀▀    ▀  ▀ ▀▀▀"


# Chiedi all'utente quale versione di GEMMA usare
echo "Scegli la versione di GEMMA da avviare:"
echo "1) GEMMA3"
echo "2) GEMMA3 IMPROVED"
read -p "Inserisci 1 o 2: " gemma_choice

# Imposta il file corretto in base alla scelta
case "$gemma_choice" in
  1)
    llamafile="/home/arch-m/AI_Locale/AI_LOCALE_GEMMA3.llamafile"
    ;;
  2)
    llamafile="/home/arch-m/AI_Locale/AI_LOCALE_GEMMA3_IMPROVED.llamafile"
    ;;
  *)
    echo "Scelta non valida. Devi inserire 1 o 2."
    exit 1
    ;;
esac

# Chiedi all'utente di inserire il punteggio nice
echo "Inserisci il punteggio nice (da -20 a 19 dove maggiore è il punteggio, minore risorse userà il programma):"
read nice_score

# Chiedi all'utente di inserire il numero di core da usare (massimo 4 core, da 0 a 3)
echo "Quanti core vuoi usare? (Puoi scegliere da 0 a 3, separati da virgola, ad esempio 0,1,2 ecc):"
read core_list

# Verifica che il punteggio nice sia valido
if [[ ! "$nice_score" =~ ^-?[0-9]+$ ]] || [ "$nice_score" -lt -20 ] || [ "$nice_score" -gt 19 ]; then
  echo "Punteggio nice non valido. Dev'essere un numero tra -20 e 19."
  exit 1
fi

# Verifica che la lista di core sia valida
if [[ -z "$core_list" ]]; then
  echo "Devi inserire almeno un core."
  exit 1
fi

# Verifica che tutti i core richiesti siano validi (tra 0 e 3)
for core in $(echo $core_list | tr "," "\n"); do
  if [ "$core" -lt 0 ] || [ "$core" -gt 3 ]; then
    echo "Errore: il core $core non è valido. I core disponibili sono da 0 a 3."
    exit 1
  fi
done

# Esegui il comando con taskset e nice
echo "Avviando $llamafile con nice $nice_score e assegnando i core: $core_list"
nice -n $nice_score taskset -c $core_list "$llamafile"
