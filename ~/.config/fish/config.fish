source $HOME/.config/fish/yeet.fish # autologin on getty@tty1

alias sshprime='eval (ssh-agent -c); ssh-add ~/.ssh/id_rsa'

set -g fish_prompt_pwd_dir_length 0
set -g theme_nerd_fonts yes
set -g theme_display_date no
set -g theme_color_scheme catppuccin-mocha

export EDITOR=nvim

alias sudo='doas'
alias v='nvim'
alias vi='nvim'
# alias vim='nvim'
alias mem='~/.config/scripts/memory'
alias vol='~/.config/scripts/volume'
alias bright='~/.config/scripts/brightness'

alias start="~/startdolphin.sh"

# source: https://github.com/CachyOS/cachyos-fish-config/
# Format man pages
set -x MANROFFOPT "-c"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

## Useful aliases
# Replace ls with eza
alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
alias la='eza -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons'  # long format
alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
alias l.="eza -a | grep -e '^\.'"                                   # show only dotfiles

# Common use
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias big="expac -H M '%m\t%n' | sort -h | nl"              # Sort installed packages according to size in MB
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'          # List amount of -git packages
alias update='sudo pacman -Syu'

# Get fastest mirrors
alias mirror="rate-mirrors"

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"


# Created by `pipx` on 2024-07-03 22:35:12
set PATH $PATH /home/william/.local/bin
