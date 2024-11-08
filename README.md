# ...

my dotfiles for swayfx.

## How to

i mean its pretty easy to apply. you need to first... 

<!-- markdownlint violations live here. -->
<details>
<summary>im an undertale fan i cant read</summary>

here's a bash oneliner:

```sh
paru -S stow mako fish btop kitty neovim yazi rofi thunar thunar-archive-plugin swayfx swaybg swaylock-effects waybar autotiling-rs grim slurp jq --needed && sudo chsh $(whoami) -s /bin/fish && git clone https://github.com/WilliamAnimate/....git --depth=1 && cd ... && stow . && curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher && fisher install oh-my-fish/theme-bobthefish
```

</details>

## Install GNU stow and curl (for downloading fisher)

```sh
pacman -S stow curl --needed
```

## then find out the other deps it has.

```sh
paru -S mako fish btop kitty neovim yazi rofi thunar thunar-archive-plugin swayfx swaybg swaylock-effects waybar autotiling-rs grim slurp jq --needed
```

### or if you like yay...

```sh
rm -rf ~
```

### or if you like [nyaur](https://github.com/williamAnimate/nyaur)...

```sh
echo "there is something wrong with me"
```

### or if you like pacman

```sh
# TODO: download aur pkgs from pacman somehow.
```

## Then, change shell to fish shell, the best shell that will ever exist.

```sh
sudo chsh $(whoami) -s /bin/fish
```

## Then, clone this repo...

```sh
git clone https://github.com/WilliamAnimate/....git --depth=1
```

## Then, switch view into it

```sh
cd ...
```

## symlink em' all

```sh
stow .
```

<!-- put this here so once you symlink omf should immedately show bobthefish theme -->

## et enfin, install [fisher](https://github.com/jorgebucaran/fisher) and themes and plugins

```sh
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher && fisher install oh-my-fish/theme-bobthefish && fisher install franciscolourenco/done
```

fisher is used over omf because omf is deprecated and unmaintained.

## haha jk not finally. you need to then find the fira code nerd font

idk where to find it. perhaps [google](https://google.com) it yourself. (or [duckduckgo](https://duckduckgo.com) it yourself)

## Further configuration

more bloat! woooooooooooo

### image file previews in thunar

```sh
sudo pacman -S tumbler
```

### delete my system

```sh
sudo rm -rf /*
```

