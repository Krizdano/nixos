# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

  
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];
   
    #bluetooth 
     hardware.bluetooth.enable = true;
     services.blueman.enable = true;

  # Bootloader.
  boot.loader.grub.device = "/dev/vda";
#  boot.loader.efi.canTouchEfiVariables = true;
 # boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos"; # Define your hostname.
 
 # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN.utf8";

  # Configure keymap in X11
   services.xserver = {
   enable = false;  
  layout = "us";
    xkbVariant = "";
  };

  #hardware support for sway 
  hardware = { 
   opengl = { 
    enable = true; 
     driSupport = true; 
    }; 
    };   

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.krizdavezz = {
    isNormalUser = true;
    description = "Krizdavezz";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    packages = with pkgs; [];
  };
  
 #brightness
   
 programs.light.enable= true;
  
 #sound 
# hardware.pulseaudio.enable = true;  


 #shell(zsh)
 programs.zsh = {
 enable = true;
 enableCompletion = true;
 };
 users.defaultUserShell = pkgs.zsh;
 


 #doas
 security.doas.enable = true;
 security.sudo.enable = false;
 # Configure doas
 security.doas.extraRules = [{
 users = [ "krizdavezz" ];
 keepEnv = true;
 persist = true;  
 }];



 #fonts
 fonts.fonts = with pkgs; [
  (nerdfonts.override { fonts = [ "Ubuntu" ]; })
 ];


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  #flatpak
   
  # services.flatpak.enable = true;

  #xterm
   services.xserver.excludePackages = [pkgs.xterm ];

  # awesome
  # services.xserver.windowManager.awesome.enable = true;
  # services.xserver.displayManager.sddm.enable = false;
   #services.gnome.core-utilities.enable = false; #gnome without apps
  # services.xserver.displayManager.lightdm.enable = false;
  #exclude package gnome
  
 # environment.gnome.excludePackages = [ pkgs.gnome-tour
  # pkgs.gnome.gnome-session
 # ];
     


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
     neofetch
     firefox-wayland
     #gnome.eog
     #mpv
     #gnome.gnome-boxes
     htop
     git
    # blender
    # gdu
    # kdenlive
    # lf
    # gimp
     mimeo
    # tdesktop
     #themes
    # whitesur-gtk-theme
    # tela-circle-icon-theme
         #awesome lua
    # luaPackages.luarocks
    # luaPackages.luadbi-mysql
      #sway
     #glib # gsettings
     #dracula-theme # gtk theme
    #   # default gnome cursors 
     autotiling
  ];


  #kdeconnect 

    programs.kdeconnect.enable = true;

    #pipewire 
     security.rtkit.enable = true;
     services.pipewire = {
     enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  #recent fix for break 
  systemd.user.services.pipewire-pulse.path = [ pkgs.pulseaudio ];
   
   # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name
  # (org.freedesktop.portal.Desktop) and object path
  # (/org/freedesktop/portal/desktop).
  # The portal interfaces include APIs for file access, opening URIs,
  # printing and others.
  services.dbus.enable = true;
  xdg = { 
      portal = {
    enable = true;
     extraPortals = with pkgs; [
       xdg-desktop-portal-wlr
       xdg-desktop-portal-gtk
     ];
  };
 };    

  #sway 
 
# programs.sway = {
# enable = true;
# extraPackages = with pkgs; [
#  swaylock
#  swayidle
 # wl-clipboard
 # wf-recorder
 # mako # notificatio
 # slurp
  #alacritty
 # waybar
 # bemenu
 #];
 #

# programs.waybar.enable = true;

# programs.qt5ct.enable = true;


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


 #home manager
  # Begin home-manager directives
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.krizdavezz = { pkgs, ... }: {
      # Everything inside here is managed by Home Manager!
      programs.home-manager = {
        enable = true;
           

    };
                   
       
  home.packages = with pkgs; [

  pulseaudio  
  # sway 
  swaylock
  swayidle
  wl-clipboard
  mako
  alacritty
  bemenu
  #waybar
 # gnome3.adwaita-icon-theme
   ];

    
 #cursor 
  # home.pointerCursor= {
  # size = 40;
  # package = pkgs.capitaine-cursors;
  # name = "capitain-cursors"; 
 #};

    wayland.windowManager.sway = {
    enable = true; 
    wrapperFeatures.gtk = true;
    
     extraSessionCommands = ''export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
      export WLR_NO_HARDWARE_CURSORS=1
   '';
   

    config = { 
      terminal = "alacritty";
       menu = "bemenu-run";
       modifier = "Mod1";
       gaps.inner = 5;
       window.border = 4;
       bars = [{
            fonts.size = 15.0; 
            command = "waybar";
             position = "top";
             hiddenState = "hide";
             mode = "hide";
             extraConfig = "modifier mod1";
            }];

        output = {
                 Virtual-1 = { mode = "1920x1080"; 
                  
                  bg =  "/home/krizdavezz/pictures/the big lebowski.jpg fill" ;            
       
    };
           
    };

};
  
};

  programs.waybar = {
   enable = true;    
    settings = [{
     bar_id = "bar-0";
     ipc = "true";  
     
    # Choose the order of the modules
    modules-left =  ["sway/workspaces" "sway/mode" "custom/spotify"];
    modules-center = ["sway/window"];
    modules-right = ["pulseaudio" "network" "cpu" "memory" "battery" "tray" "clock"];
   
   "sway/workspaces" =
    {
       format = "{icon}";
    
     };
    "sway/mode" = {
        format = "<span style=\"italic\">{}</span>";
    };

    "tray" = {
         icon-size = 21;
        spacing = 10;
    };

    "clock" = {
        format = "{:%I:%M %p}";
    };

    "cpu" = {
        format = "{usage}% ";
    };

    "memory" = {
        format = "{}% ";
    };

    "battery" = {
        bat = "BAT1";
        states = {
            good = 95;
            warning = 30;
            critical= 15;
        };

        format = "{capacity}% {icon}";
        # "format-good": "", # An empty format will hide the module
        #// "format-full": "",
        format-icons = [""  ""  ""  ""  ""];
    };

    "network" = {
        #// "interface": "wlp2s0", // (Optional) To force the use of this interface
        format-wifi =  "{essid} ({signalStrength}%) ";
        format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
        format-disconnected = "Disconnected ⚠";
    }; 

    "pulseaudio" = {
       # //"scroll-step": 1,
        format = "{volume}% {icon}";
        format-bluetooth = "{volume}% {icon}";
        format-muted =  "";
        format-icons = {
            headphones = "";
            handsfree =  "";
            headset  = "";
            phone  = "";
            portable = "";
            car = "";
            default = ["" ""];
        };
        on-click  =  "pavucontrol";
    };

   # "custom/spotify": {
    #    "format": " {}",
     #   "max-length": 40,
      #  "interval": 30, // Remove this if your script is endless and write in loop
       # "exec": "$HOME/.config/waybar/mediaplayer.sh 2> /dev/null", // Script in resources folder
       # "exec-if": "pgrep spotify"
   }];
   style= (builtins.readFile  /home/krizdavezz/.config/waybar/style.css);
    
};

};
};
  

}
