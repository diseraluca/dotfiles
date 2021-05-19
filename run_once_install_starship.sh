{{ if (and (eq .chezmoi.osRelease.name "Arch Linux") (eq .shell "fish")) -}}
#!/bin/env sh
pacman -S starship
{{ end -}}
