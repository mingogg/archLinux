# ~/.bashrc

# neofetch

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias hconf="nvim ~/.config/hypr/hyprland.conf"
alias rwb="pkill -x waybar || true; sleep 0.2; waybar & disown"
alias fopen="fileOpen"
alias dopen="directoryOpen"
alias wopen="workspaceOpen"
alias ns="nvim -c 'source .nvim-session.vim'"
alias wofi-launch='~/.config/wofi/wofi-launcher.sh'
alias wofi-rebuild='~/.config/wofi/build-entries.sh'
alias wofi-edit='~/.config/wofi/edit-entries.sh'

# TODO: Se puede agregar que también en el prompt de git tenga colores, solo cuando hay cosas en el status ej X=rojo, ~=amarillo, etc...

# Exclusion de carpetas de busqueda para fopen y dopen
EXCLUDED=(
  -path '*/venv'                                            -prune -o
  -path '*/.git'                                            -prune -o
  -path './.nvm'                                            -prune -o
  -path './.npm'                                            -prune -o
  -path './.tmux'                                           -prune -o
  -path './.local'                                          -prune -o
  -path './.cache'                                          -prune -o
  -path './Coding'                                          -prune -o
  -path '*/.eclipse'                                        -prune -o
  -path './.mozilla'                                        -prune -o
  -path '*/node_modules'                                    -prune -o
  -path './.config/Postman'                                 -prune -o
  -path './.config/discord'                                 -prune -o
  -path './.local/share/Trash'                              -prune -o
  -path './.vscode/extensions'                              -prune -o
  -path './dev/personal/spendly/backend/.venv'              -prune -o
  -path './.config/BraveSoftware/Brave-Browser'             -prune -o
  -path './dev/personal/nbaShowcase/node_modules'           -prune -o
  -path './dev/personal/spendly/frontend/node_modules'      -prune -o
  -path './Coding/Python/TODO List APP/front/node_modules'  -prune -o
)

function fileOpen() {
    local results
    IFS=$'\n' read -d '' -r -a results < <(
        command find . "${EXCLUDED[@]}" -type f -iname "*$1*" -print 2>/dev/null
    )

    local count=${#results[@]}

    if [[ $count -eq 0 ]]; then
        echo "  No se encontraron archivos que coincidan con '$1'"
    elif [[ $count -eq 1 ]]; then
        echo "  Abriendo: ${results[0]}"
        nvim "${results[0]}"
    else
        echo " Archivos encontrados:"
        for i in "${!results[@]}"; do
            echo "$i) ${results[$i]}"
        done

        read -p "Selecciona el número de archivo a abrir: " choice
        if [[ "$choice" =~ ^[0-9]+$ ]] && [[ $choice -lt $count ]]; then
            nvim "${results[$choice]}"
        else
            echo " Selección inválida"
        fi
    fi
}

function directoryOpen() {
    local dirs
    IFS=$'\n' read -d '' -r -a dirs < <(
        command find . "${EXCLUDED[@]}" -type d -iname "*$1*" -print 2>/dev/null
    )

    local count=${#dirs[@]}

    if [[ $count -eq 0 ]]; then
        echo " No se encontraron carpetas que coincidan con '$1'"
    elif [[ $count -eq 1 ]]; then
        echo " Moviéndote a: $(realpath --relative-to=. "${dirs[0]}")"
        cd "${dirs[0]}"
	echo
        ls
    else
        echo " Carpetas encontradas:"
        for i in "${!dirs[@]}"; do
            echo "$i) $(realpath --relative-to=. "${dirs[$i]}")"
        done

        read -p "Selecciona el número de carpeta a entrar: " choice
        if [[ "$choice" =~ ^[0-9]+$ ]] && [[ $choice -lt $count ]]; then
            cd "${dirs[$choice]}"
	    echo
            ls
        else
            echo " Selección inválida"
        fi
    fi
}

function workspaceOpen() {
    dopen "$1" && nvim
}

# # Prompt de starship
# export STARSHIP_CONFIG=~/.config/starship/starship.toml
# eval "$(starship init bash)"
#
# # If not running interactively, don't do anything
# [[ $- != *i* ]] && return


parse_git_info() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local branch status added modified untracked
    status=$(git status --porcelain 2>/dev/null)

    if [[ -n "$status" ]]; then
      branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
      added=$(echo "$status" | grep '^A' | wc -l)
      modified=$(echo "$status" | grep '^ M' | wc -l)
      untracked=$(echo "$status" | grep '^??' | wc -l)

      echo -n "  git: $branch ✘"
      [[ $modified -gt 0 ]] && echo -n " ~$modified"
      [[ $untracked -gt 0 ]] && echo -n " ?$untracked"
    fi
  fi
}

ARCH_BLUE='\[\e[38;2;23;147;209m\]'
RESET='\[\e[0m\]'
PS1='\n[\u@\h \w$(parse_git_info)]\n'"$ARCH_BLUE"'󰣇 '"$RESET"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
