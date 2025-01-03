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
set -g theme_display_git_untracked no
set -g theme_git_worktree_support no

if test (tty) = "/dev/tty1" -o (tty) = "/dev/tty2" -o (tty) = "/dev/tty2" -o (tty) = "/dev/tty3" -o (tty) = "/dev/tty4" -o (tty) = "/dev/tty5" -o (tty) = "/dev/tty6"
    set -g theme_powerline_fonts no
    set -g theme_nerd_fonts no
else
    set -g theme_color_scheme catppuccin-mocha
end

export EDITOR=nvim

alias sudo='doas'
alias v='nvim'
alias swaps="free -h; echo "\n"; zramctl; echo "\n"; swapon --show"
alias cd='z'
alias y='yazi'

alias synctime="sudo systemctl start systemd-timesyncd && sleep 1 && sudo systemctl stop systemd-timesyncd"

alias rec="wf-recorder -a=alsa_output.pci-0000_00_14.2.analog-stereo.monitor -f"

alias fastfetch="fastfetch --color '4;95' --logo-color-1 '3;95'"

## Useful aliases
# Replace ls with eza
alias ls='eza -al --color=always --group-directories-first --icons --git' # preferred listing
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
alias cleanupagressive='pacman -Qqd | sudo pacman -Rnsu -'

alias dmesg="sudo /bin/dmesg -L=always"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

zoxide init fish | source

