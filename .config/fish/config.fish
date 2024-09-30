# https://fishshell.com/docs/current/interactive.html#vi-mode-commands
# my fingers speak vi
function fish_user_key_bindings
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
end

set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
set fish_cursor_external line
set fish_cursor_visual block

set -g theme_git_default_branches yes
# set -g theme_display_vi yes
set -g fish_prompt_pwd_dir_length 0
set -g theme_nerd_fonts yes
set -g theme_display_date no
set -g theme_color_scheme catppuccin-mocha

if test (tty) = "/dev/tty2" -o (tty) = "/dev/tty2" -o (tty) = "/dev/tty3" -o (tty) = "/dev/tty4" -o (tty) = "/dev/tty5" -o (tty) = "/dev/tty6"
    set -g theme_powerline_fonts no
    set -g theme_nerd_fonts no
end

export EDITOR=nvim

alias sudo='doas'
alias v='nvim'
alias vi='nvim'
# alias vim='nvim'
alias mem='~/.config/scripts/memory'
alias vol='~/.config/scripts/volume'
alias bright='~/.config/scripts/brightness'

# source: https://github.com/CachyOS/cachyos-fish-config/
# Format man pages
set -x MANROFFOPT "-c"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

## Useful aliases
# Replace ls with eza
alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
alias la='eza -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons'  # long format
alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
alias l.="eza -a | grep -e '^\.'"                                   # show only dotfiles

# why the fuck less so cringe??? show colors
# this doesn't work half the time though
alias less='less -R'
# oh i see why: literally every utility doesnt find color support from pipes
# why???
alias xxd='xxd -R always'

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

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

alias dmesg="sudo /bin/dmesg -L=always"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

