{{ if eq .chezmoi.os "archlinux" -}}
yay -S --needed sway wofi kitty waybar ttf-meslo ttf-meslo-nerd-font-powelevel10k
{{ end -}}
