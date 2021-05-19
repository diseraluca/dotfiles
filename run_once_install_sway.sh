{{ if eq .chezmoi.osRelease.name "Arch Linux" -}}
yay -S --needed sway wofi kitty waybar ttf-meslo ttf-meslo-nerd-font-powelevel10k
{{ end -}}
