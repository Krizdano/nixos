#  ──────────────────────────────────────────
#    specific system configuration for my:           
#                                                
#            ╦  ╔═╗╔═╗╔╦╗╔═╗╔═╗                             
#            ║  ╠═╣╠═╝ ║ ║ ║╠═╝                              
#            ╩═╝╩ ╩╩   ╩ ╚═╝╩  
#
#  flake.nix
#   └── ./hosts
#         └─ ./laptop
#               ├─ default.nix *
#               └─ hardware-configuration.nix 
#  ──────────────────────────────────────────

{ config, pkgs, lib, user, location, ... }:

  
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
   
  
  # adb
  # programs.adb.enable = true;
  
  #opengl
  hardware.opengl= {
    enable = true;
  };

  # bluetooth 
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  
  # get latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

 
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
     mimeo
     tdesktop # telegram
     firefox-wayland 
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
        ../../modules/shell/zsh.nix 
        ../../modules/WindowManagers/sway.nix
        ../../modules/programs/lf.nix
        ../../modules/programs/starship.nix
        ../../modules/programs/nvim.nix
        ../../modules/programs/kitty.nix
        ../../modules/programs/mpv.nix
        ../../modules/programs/git.nix
         ../../modules/programs/gh.nix
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
