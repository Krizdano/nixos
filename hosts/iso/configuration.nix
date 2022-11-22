#  ──────────────────────────────────────────
#        ╔╦╗╔═╗╦╔╗╔╔═╗╔═╗╔╗╔╔═╗╦╔═╗
#        ║║║╠═╣║║║║║  ║ ║║║║╠╣ ║║ ╦
#        ╩ ╩╩ ╩╩╝╚╝╚═╝╚═╝╝╚╝╚  ╩╚═╝
#         Main configuration file 
#
#         flake.nix
#         ├─ ./hosts
#               └─ configuration.nix *
#  ──────────────────────────────────────────

{ config, pkgs, lib, user, ... }:

  
{
  imports =
    [ # Include the results of the hardware scan.
      #./hardware-configuration.nix
    ];
   
  
  #flakes
  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Enable networking
  #networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";
  
  # Configure keymap in X11
  services.xserver = {
    enable = true;  
    layout = "us";
    xkbVariant = "";
  };
  
  # dconf (for gtk themes to work properly)
  programs.dconf = {
    enable = true;
  };
  
   
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = { 
    defaultUserShell = pkgs.zsh;
    users.nixos = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" "libvirtd" "audio" "adbsers" ];
    packages = with pkgs; [];
  };
  };


  # sound 
  # hardware.pulseaudio.enable = false;  

  # doas
  security.doas.enable = true;
  security.sudo.enable = false; # disable sudo
  # Configure doas
  security.doas.extraRules = [{
    users = [ "nixos" ];
    keepEnv = true;
    persist = true;  
    }];


  # fonts
  fonts.fonts = with pkgs; [
   (nerdfonts.override { fonts = [ "Ubuntu" ]; })
  ]; # for swaybar config


  # remove xterm terminal 
  services.xserver.excludePackages = [pkgs.xterm];


  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  # services.gnome.core-utilities.enable = false; #gnome without apps
  services.xserver.displayManager.lightdm.enable = false; #disables ldm  which is enabled by default
  

  # exclude package gnome 
  # environment.gnome.excludePackages = [ pkgs.gnome-tour
  # pkgs.gnome.gnome-session
  # ];
     
   
  # qt5
  qt5.platformTheme = "qt5ct";
  qt5.style = "gtk2";

  environment = { 
    pathsToLink = [ "/share/zsh" ];
    shells = [ pkgs.zsh ];
    variables = {
    TERMINAL ="kitty";
    EDITOR = "nvim" ;
    VISUAL = "nvim" ;
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  };

  # Gtk theme 
  #environment.sessionVariables = {GTK_THEME="WhiteSur-Dark-solid";};
 
  # pipewire 
  security.rtkit.enable = true;
  services.pipewire = {
   enable = true;
   alsa.enable = true;
   alsa.support32Bit = true;
   pulse.enable = true;
   jack.enable = true;
  };


  # recent fix for break 
  systemd.user.services.pipewire-pulse.path = [ pkgs.pulseaudio ];
   
  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name
  # (org.freedesktop.portal.Desktop) and object path
  # (/org/freedesktop/portal/desktop).
  # The portal interfaces include APIs for file access, opening URIs,
  # printing and others.
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };   
   

  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPortRanges = [ # kdconnect
  { from = 1714; to = 1764;} ];

  networking.firewall.allowedUDPPortRanges = [ # kdeconnect 
  { from = 1741; to = 1764; } ];
  
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  
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
    users.nixos = { config, pkgs, inputs, lib,  ... }: {

      imports = [ 
        ../../modules/shell/zsh.nix 
        ../../modules/WindowManagers/sway.nix
      ]
     ++ (import ../../modules/programs);
  # Everything inside here is managed by Home Manager!

 # imports  = [ ../../modules/shell/zsh.nix ];
  # version
  
 # home = {
    # user = "nixos";
   # stateVersion = "22.05";
 # };

  # sway idle  
  services.swayidle= {
    enable = true;
    timeouts = [
     { timeout = 200; command = "swaylock -f -c 000000"; }  
     { timeout = 400; command = "swaymsg 'output * poweroff' resume swaymsg 'output * power on'";
     }  
    ];
    events = [
     { event = "before-sleep"; command = "swaylock -f -c 000000";} 
    ];
  }; 

  programs.home-manager = {
   enable = true;

  };



  home = {
    stateVersion = "22.05";



   packages = with pkgs; [
   pulseaudio   
   w3m # terminal browser
   ytfzf # terminal youtube 
   bemenu # search bar
   fzf
   glib # gsettings
  ];
  
   file = {
    ".config/wallpapers".source = ../../modules/themes/wallpapers;
    ".themes".source = ../../modules/themes/.themes;
    ".config/scripts".source = ../../config/scripts;
    ".config/ytfzf/subscriptions".source = ../../config/ytfzf/subscriptions;
    ".config/waybar/config".source = ../../config/waybar/config;
    ".config/waybar/style.css".source = ../../config/waybar/style.css;
    ".mozilla/firefox/mz4w5cdv.default/chrome".source = ../../config/chrome; 
    ".mozilla/firefox/profiles.ini".source = ../../config/firefox/profiles.ini; 
};


  };

   


  # wallpaper

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