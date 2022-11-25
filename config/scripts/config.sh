


vim=$( find .nixconfig -name '*.nix' | fzf -e --preview "pistol {}")

[ -z "$vim" ] && exit 0

$EDITOR $vim

