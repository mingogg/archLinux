#
# ~/.bashrc
#
#neofetch

alias hconf="nvim ~/.config/hypr/hyprland.conf"
alias rwb="pkill -x waybar || true; sleep 0.2; waybar & disown"
alias fopen="fileOpen"
alias dopen="directoryOpen"
alias wopen="workspaceOpen"
alias ns="nvim -c 'source .nvim-session.vim'"

# TODO: Se puede hacer que wopen abra la carpeta y ejecute nvim, en lugar de wopen
# ya que se tiene neo-tree y fuzzy finder


# Exclusion de carpetas de busqueda para fopen y dopen
EXCLUDED=(
  -path './.local' -prune -o
  -path './.cache' -prune -o
  -path './.local/share/Trash' -prune -o
  -path './.vscode/extensions' -prune -o
  -path './dev/personal/nbaShowcase/node_modules' -prune -o
  -path './dev/personal/spendly/frontend/node_modules' -prune -o
  -path './Coding/Python/TODO List APP/front/node_modules' -prune -o
  -path './dev/personal/spendly/backend/.venv' -prune -o
  -path './.npm' -prune -o
  -path './Coding' -prune -o
  -path './.tmux' -prune -o
  -path './.nvm' -prune -o
  -path './.mozilla' -prune -o
  -path './.config/BraveSoftware/Brave-Browser' -prune -o
  # probar otro día (para que elimine todos los paths que puedan llevar a la carpeta)
  # -path '../.git/' -prune -o
  # -path '../node_modules' -prune -o
)

# Para buscar y abrir archivos
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

# Para buscar y abrir directorios
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

# Para abrir workspaces
function workspaceOpen() {
    dopen "$1" && [[ -f .nvim-session.vim ]] && nvim -c 'nvim'
}



# Prompt de starship
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init bash)"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\e[0;32m\]\u@\h:\w\$ \[\e[0m\]'

# Wofi launcher scripts
alias wofi-launch='~/.config/wofi/wofi-launcher.sh'
alias wofi-rebuild='~/.config/wofi/build-entries.sh'
alias wofi-edit='~/.config/wofi/edit-entries.sh'


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
