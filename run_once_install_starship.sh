{{ if eq .chezmoi.os "archlinux" -}}
#!/bin/env sh
pacman -S starship
{{ end -}}
