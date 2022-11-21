#   ──────────────────────────────────────────
#    specific system configuration for my: 
#
#   ╦  ╦╦╦═╗╔╦╗╦ ╦╔═╗╦    ╔╦╗╔═╗╔═╗╦ ╦╦╔╗╔╔═╗
#   ╚╗╔╝║╠╦╝ ║ ║ ║╠═╣║    ║║║╠═╣║  ╠═╣║║║║║╣ 
#    ╚╝ ╩╩╚═ ╩ ╚═╝╩ ╩╩═╝  ╩ ╩╩ ╩╚═╝╩ ╩╩╝╚╝╚═╝
#
#  flake.nix
#   └── ./hosts
#         └─ ./laptop
#               ├─ default.nix *
#               └─ hardware-configuration.nix 
#   ──────────────────────────────────────────


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
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  
  # get latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

 
 
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # laptop screen brightness
#  programs.light.enable= true;
  

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     neofetch
     htop
     gdu # disk management
     mimeo
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
    users.${user} = { config, pkgs, inputs, ... }: {

      imports = 
      [ ../../modules/shell/zsh.nix
        ../../modules/WindowManagers/sway.nix
     ];
      
  # Everything inside here is managed by Home Manager!

  # version


 wayland.windowManager.sway.config.output = {  # external monitor
        "*".bg =  "~/.config/wallpapers/three_squares.png fill";        
        "Virtual-1".mode = "1366x768";
        "Virtual-1".position = "0,1920";
       };




  home.packages = with pkgs; [

  ];

  programs.zsh.shellAliases = { 
      # rebuild nixos using flake
      re = "pushd ~/.nixconfig
           \n doas nixos-rebuild switch --flake '.#vm'
           \n popd"; 
    
  };
  
  # themes
  gtk = {
    enable = true;
    theme =  { 
    name =  "Catppuccin-Mocha";
        
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };



   }; #end of home-manager programs

  }; # end of home-manager
 
} # end of configuration
