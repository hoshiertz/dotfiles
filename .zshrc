PROMPT='%F{cyan}%n%F{white}@%F{blue}%~ %F{cyan}> %F{white}'

alias pyon="source .venv/bin/activate"

alias pyou="deactivate"

alias ls="lsd -al"

alias swayon="sway --unsupported-gpu"

alias sleep="sudo systemctl hibernate"

go_path=~/.gomodcache
export GOMODCACHE=$go_path
export GOPATH=$go_path

export GPG_TTY=$(tty)