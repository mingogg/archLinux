#!/usr/bin/env bash

TMP_FILE="/tmp/updates_confirm.txt"

official=$(pacman -Qu --quiet 2>/dev/null | grep -v '\[ignored\]' || true)
aur=$(yay -Qua 2>/dev/null)

{
    echo " 󰣇 Available updates:"
    echo
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
    echo
    echo " Update all? [1 = Yes / 0 = No]"
} > "$TMP_FILE"

kitty --title "Updates" --hold bash -c "
    cat $TMP_FILE
    echo
    read -p '> ' confirm
    if [[ \$confirm == 1 ]]; then
        yay -Syu
        echo
        echo ' Clean cache? [1 = Yes / 0 = No]'
        read -p '> ' clean
        if [[ \$clean == 1 ]]; then
            yay -Sc
        fi
    else
        echo 'Update stoped.'
    fi
"
