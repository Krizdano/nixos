#  ──────────────────────────────────────────
#           ╔═╗╦═╗╔═╗╔═╗╦═╗╔═╗╔╦╗╔═╗
#           ╠═╝╠╦╝║ ║║ ╦╠╦╝╠═╣║║║╚═╗
#           ╩  ╩╚═╚═╝╚═╝╩╚═╩ ╩╩ ╩╚═╝
#           My essential applications
#
#           flake.nix
#           ├─ ./hosts
#           │    ├── default.nix
#           │    └── configuration.nix 
#           ├── modules
#           └── programs
#               ├── default.nix *
#               └── ... 
#  ──────────────────────────────────────────

[
  ./gh.nix
  ./git.nix
  ./kitty.nix
  ./lf.nix
  ./mpv.nix
  ./nvim.nix
  ./starship.nix
  ./waybar.nix
  #./dunst.nix
  ./mako.nix
  ./pistol.nix
]
 
# dunst has been replaced by mako
