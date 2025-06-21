#!/usr/bin/env bash

TMP_FILE="/tmp/updates_list.txt"

# Obtener updates
official=$(checkupdates 2>/dev/null)
aur=$(yay -Qua 2>/dev/null)

{
    echo " 󰣇 Available updates:"
    if [[ -n "$official" ]]; then
        echo "   Pacman:"
        echo "$official" | sed 's/^/     /'
    else
        echo " 󰭹 Pacman: No updates."
    fi
    echo
    if [[ -n "$aur" ]]; then
        echo "  AUR:"
        echo "$aur" | sed 's/^/    /'
    else
        echo " 󰭹 AUR: No updates."
    fi
} > "$TMP_FILE"

# Mostrar el resultado en una terminal nueva (usando Kitty)
kitty --title "Updates" --hold bash -c "cat $TMP_FILE"
