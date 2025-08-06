#!/usr/bin/env bash

script_name=$(basename "$0")

instance_count=$(ps aux | grep -F "$script_name" | grep -v grep | grep -v $$ | wc -l)
if [ "$instance_count" -gt 1 ]; then
    sleep "$instance_count"
fi

noUpdates=0
updates=25
bigUpdates=100

wait_locks() {
    local pacman_lock="/var/lib/pacman/db.lck"
    local yay_lock="${TMPDIR:-/tmp}/yaydb.lck"
    while [ -f "$pacman_lock" ] || [ -f "$yay_lock" ]; do
        sleep 1
    done
}
wait_locks

official=$(checkupdates | wc -l)
aur=$(yay -Qua 2>/dev/null | wc -l)
total=$(( official + aur ))

(( total > noUpdates )) && css="updates"
(( total > updates )) && css="warning"
(( total > bigUpdates )) && css="urgent"

if (( total > 0 )); then
    printf '{"text":"%d","alt":"%d","tooltip":"%d updates","class":"%s"}' \
           "$total" "$total" "$total" "$css"
else
    printf '{"text":"0","alt":"0","tooltip":"No updates","class":"green"}'
fi
