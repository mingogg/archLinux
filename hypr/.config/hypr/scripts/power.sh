#!/usr/bin/env bash

case "${1:-}" in
  logout)
    hyprctl dispatch exit
    ;;
  poweroff)
    systemctl poweroff
    ;;
  suspend)
    systemctl suspend
    ;;
  reboot)
    systemctl reboot
    ;;
  *)
    echo "Executing: $(basename "$0") {logout|poweroff|suspend}"
    exit 1
    ;;
esac
