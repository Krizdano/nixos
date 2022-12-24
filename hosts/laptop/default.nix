#  ──────────────────────────────────────────
#    specific system configuration for my:           
#                                                
#            ╦  ╔═╗╔═╗╔╦╗╔═╗╔═╗                             
#            ║  ╠═╣╠═╝ ║ ║ ║╠═╝                              
#            ╩═╝╩ ╩╩   ╩ ╚═╝╩  
#
#  flake.nix
#   ├── ./hosts
#   │       ├─ default.nix 
#   │       ├── configuation.nix
#   │       └─ ./laptop
#   │            ├─ default.nix *
#   │            └── hardware-configuration.nix
#   └── modules
#       └── programs
#          └── kdeconnect.nix             
#  ──────────────────────────────────────────

{ config, pkgs, lib, user, location, ... }:

  
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
   
  # adb
   programs.adb.enable = true;
  
  #opengl
  hardware.opengl= {
    enable = true;
  };

  networking.hostName = "mylaptop";

  # bluetooth 
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Bootloader.
  boot = {
    loader = {
     systemd-boot.enable = true;
     timeout = 0;
     # UEFI settings
     efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
     };
   };
   # get latest kernel
   kernelPackages = pkgs.linuxPackages_6_0;
  }; 
  
 
  #virtualisation
  virtualisation.libvirtd.enable = true;
 
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # laptop screen brightness
  programs.light.enable= true;
  
 
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     neofetch
     virt-manager
     htop
     gdu # disk management
     gimp
     tdesktop # telegram
     firefox-wayland 
    (pkgs.callPackage ../../modules/programs/lobster-movie.nix {})
    (pkgs.callPackage ../../modules/programs/oi.nix {})
    (pkgs.callPackage ../../modules/programs/tt.nix {})
     #sway
  ];

  
#  ──────────────────────────────────────────
#                                                                     #                 
#    ╦ ╦╔═╗╔╦╗╔═╗   ╔╦╗╔═╗╔╗╔╔═╗╔═╗╔═╗╦═╗
#    ╠═╣║ ║║║║║╣ ───║║║╠═╣║║║╠═╣║ ╦║╣ ╠╦╝ 
#    ╩ ╩╚═╝╩ ╩╚═╝   ╩ ╩╩ ╩╝╚╝╩ ╩╚═╝╚═╝╩╚═    
#        Begin home-manager directives
#                                                                     #                 
#  ──────────────────────────────────────────

  home-manager = {
    #useUserPackages = true;
    #useGlobalPkgs = true;
    users.${user} = { config, pkgs, inputs, lib,  ... }: {

      imports = [ 
        ../../modules/programs/kdeconnect.nix
      ];
  # Everything inside here is managed by Home Manager!

 # imports  = [ ../../modules/shell/zsh.nix ];


  home.packages = with pkgs; [
   #pulseaudio   
   #w3m # terminal browser
   #ytfzf # terminal youtube 
   #bemenu # search bar
   #fzf
   #glib # gsettings
  ];
  


  #zsh
    programs.zsh.shellAliases = { # all shell aliases
    
       # rebuild nixos using flake
      re = "pushd ~/.nixconfig
           \n doas nixos-rebuild switch --flake '.#laptop'
           \n popd"; 

      # turn on laptop screen on and off in sway
      lo = "swaymsg output eDP-1 dpms off";
      ln = "swaymsg output eDP-1 dpms on";
      # nix-shell with rust development tools
      rus = "cd ~/rust/
            \n nix-shell"; 
      # update configuation.nix to git repository
          yt = "ytfzf -t --thumb-viewer=kitty -f -s --detach -l --preview-side=right"; # youtube 
    };

};
  };
} # end of configuration
