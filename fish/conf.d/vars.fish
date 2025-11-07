# Set common variables that a lot of scripts use

type -q elinks && set -gx BROWSER elinks
type -q google-chrome && set -gx BROWSER google-chrome
type -q firefox && set -gx BROWSER firefox
type -q xdg-open && set -gx BROWSER xdg-open
type -q open && set -gx BROWSER open

type -q vim && set -gx EDITOR vim
type -q nvim && set -gx EDITOR nvim

type -q less && set -gx PAGER less

