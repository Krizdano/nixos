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
   
  
  # adb
 # programs.adb.enable = true;
  
  # bluetooth 
   hardware.bluetooth.enable = true;
   services.blueman.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  
  # kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

 
  networking.hostName = "nixos"; # Define your hostname.

  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

 
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

 
  # Enable networking
  networking.networkmanager.enable = true;

 
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
  
   
    programs.dconf = {

      enable = true;

    };
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.krizdavezz = {
     isNormalUser = true;
     description = "Krizdavezz";
     extraGroups = [ "networkmanager" "wheel" "video" "audio" "adbusers" ];
     packages = with pkgs; [];
     };


  # brightness
  programs.light.enable= true;
  
  # sound 
  # hardware.pulseaudio.enable = false;  


  # shell(zsh)
    programs.zsh = {
     enable = true;
    enableCompletion = true;
    shellAliases = {
      conf = "vi /home/krizdavezz/NixConfig/configuration.nix";
      rebuild = "doas nixos-rebuild switch -I nixos-config=/home/krizdavezz/NixConfig/configuration.nix";
      update = "doas nixos-rebuild switch -I nixos-config=/home/krizdavezz/NixConfig/configuration.nix --upgrade";
      lapoff = "swaymsg output eDP-1 dpms off";
      lapon = "swaymsg output eDP-1 dpms on";
      rus = "cd ~/rust/ \n nix-shell"; 
      gupdate = "cp /home/krizdavezz/NixConfig/configuration.nix  /home/krizdavezz/nixos/workinprogress 
      \n cd /home/krizdavezz/nixos/workinprogress \n git add configuration.nix \n git commit -m 'updated config' \n git push "; 

    };
   };
  # setting zsh as default shell
  users.defaultUserShell = pkgs.zsh;
 

 
  # doas
  security.doas.enable = true;
  security.sudo.enable = false;
 
  # Configure doas
    security.doas.extraRules = [{
     users = [ "krizdavezz" ];
     keepEnv = true;
     persist = true;  
    }
  ];



  # fonts
   fonts.fonts = with pkgs; [
   (nerdfonts.override { fonts = [ "Ubuntu" ]; })
   ];


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # flatpak
  # services.flatpak.enable = true;

  # xterm
  services.xserver.excludePackages = [pkgs.xterm ];

  # awesome
  # services.xserver.windowManager.awesome.enable = true;
   
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  # services.gnome.core-utilities.enable = false; #gnome without apps
  services.xserver.displayManager.lightdm.enable = false;
  

  # exclude package gnome 
  # environment.gnome.excludePackages = [ pkgs.gnome-tour
  # pkgs.gnome.gnome-session
  # ];
     


  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
  # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     neofetch


     mpv
     gnome.gnome-boxes
     htop
     #git
     blender
     gdu
     kdenlive
     gimp
     mimeo
     vscode-fhs
     android-studio
     tdesktop
    # gnome.gnome-tweaks
     firefox-wayland 
     #themes
     whitesur-gtk-theme
     tela-circle-icon-theme
     
     #rust
     #rustup

     #awesome lua
     #luaPackages.luarocks
     #luaPackages.luadbi-mysql
      
     #sway
     glib # gsettings
     #gnome.adwaita-icon-theme  # default gnome cursors 

   ];

   
  # qt5
  #qt5.platformTheme = "qt5ct";

  # Gtk theme 
  #environment.sessionVariables = {GTK_THEME="WhiteSur-Dark-solid";};
 
  # kdeconnect 
  #programs.kdeconnect.enable = true;

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


  # home manager
  # Begin home-manager directives
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.krizdavezz = { pkgs, ... }: {

  # Everything inside here is managed by Home Manager!

  # version
  home.stateVersion = "22.05";


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

  #lf
  programs.lf = {
   enable = true; 
   keybindings = { 
     "." = "set hidden!";
     "<enter>" = "shell";
     "o" = "open";
     "DD" = "delete";
  

 };

  };

  # starship-prompt
  programs.starship = {
   enable = true;
   enableZshIntegration = true;
   settings = {
    add_newline = false;
    username = {
      style_user = "bright-white bold";
      style_root = "bright-red bold";
    };
    hostname = {
      style = "bright-green bold";
      ssh_only = true;
    };
    nix_shell = {
      symbol = "";
      format = "[$symbol$name]($style) ";
      style = "bright-purple bold";
    };
    git_branch = {
      only_attached = true;
      format = "[$symbol$branch]($style) ";
      symbol = "שׂ";
      style = "bright-yellow bold";
    };
    git_commit = {
      only_detached = true;
      format = "[ﰖ$hash]($style) ";
      style = "bright-yellow bold";
    };
    git_state = {
      style = "bright-purple bold";
    };
    git_status = {
      style = "bright-green bold";
    };
    directory = {
      read_only = " ";
      truncation_length = 0;
    };
    cmd_duration = {
      format = "[$duration]($style) ";
      style = "bright-blue";
    };
    jobs = {
      style = "bright-green bold";
    };
    character = {
      success_symbol = "[\\$](bright-green bold)";
      error_symbol = "[\\$](bright-red bold)";
      };
    };
  };


  # neovim
   programs.neovim = {
    enable = true;
    viAlias = true;
    withNodeJs = true;
    extraConfig = "colorscheme carbonfox \n set number";
    coc = {
      enable = true;
      settings = { "suggest.noselect" = true; };
       pluginConfig = '' inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()''; };
    plugins = with pkgs.vimPlugins; [
     nightfox-nvim 
     vim-nix 
     coc-rust-analyzer
     {
       plugin = lualine-nvim;
       type = "lua";
       config = '' require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
  }''; }

     {
       plugin = nvim-tree-lua;
       type = "lua";
       config = '' -- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
  vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
}) '';
     
}
    ];
  };


  programs.git = {
    enable = true;
    userName = "Krizdano";
    userEmail = "akrishna852@gmail.com";
  };
  
  programs.gh = {
    enable  = true;
    enableGitCredentialHelper = true;
  };
   
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
  
  #theme
  gtk = {

    enable = true;
    theme = { 
     name = "WhiteSur-Dark-solid";
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };



       
  home.packages = with pkgs; [
   pulseaudio   
   swaylock
   swayidle
   wl-clipboard
   mako # notifications
   alacritty # terminal 
   bemenu # search bar
   wl-clipboard
   fzf
   wf-recorder
   #rust-analyzer #rust-analyzer 
   slurp
   autotiling #sway autotiling
   ];



  # sway 
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
   
       
  # sway config
   config = {  
     input = { "PNP0C50:0e 06CB:0e_06CB:7E7E_Touchpad" = # touchpad config 
     {
      dwt = "enable";
      tap = "enable";
      natural_scroll = "enabled";
      middle_emulation = "enabled";
     }; };

      terminal = "alacritty";
      menu = "bemenu-run";
      modifier = "Mod4";
      gaps.inner = 5;
      window.border = 4;
      keybindings = {     
       "mod4+b" = "exec firefox"; # opens firefox
       "mod4+Shift+q" = "kill"; # close windows
       "mod4+Return" =  "exec alacritty"; # open terminal (alacritty)
       "mod4+d" = "exec bemenu-run"; # bemeu 
       "mod4+Shift+c" = "reload"; # reload sway
       
       # exit sway 
       "mod4+shift+e" = "exec swaynag - t warning -m 'you pressed the exit shortcut.Do you really want to exit sway?' -B 'yes' 'swaymsg exit'"; 
       
       # moving aroud
       "mod4+Down" = "focus down";
       "mod4+Up" = "focus up";
       "mod4+Right" = "focus right";
      
       # move focused window
       "mod4+Shift+Left" = "move left";
       "mod4+Shift+Down" = "move down";
       "mod4+Shift+Right" = "move right";
       "mod4+Shift+Up" = "move up";

       # workspaces
       "mod4+1" = "workspace number 1";
       "mod4+2" = "workspace number 2";
       "mod4+3" = "workspace number 3";
       "mod4+4" = "workspace number 4";
       "mod4+5" = "workspace number 5";
       "mod4+6" = "workspace number 6";
       "mod4+7" = "workspace number 7";
       "mod4+8" = "workspace number 8";
       "mod4+9" = "workspace number 9";
       # move focused container to workspaces
       "mod4+Shift+1" = "move container to workspace number 1";
       "mod4+Shift+2" = "move container to workspace number 2";
       "mod4+Shift+3" = "move container to workspace number 3";
       "mod4+Shift+4" = "move container to workspace number 4";
       "mod4+Shift+5" = "move container to workspace number 5";
       "mod4+Shift+6" = "move container to workspace number 6";
       "mod4+Shift+7" = "move container to workspace number 7";
       "mod4+Shift+8" = "move container to workspace number 8";
       "mod4+Shift+9" = "move container to workspace number 9";
      
       "mod4+f" = "fullscreen"; # full screen
       "mod4+space" = "focus mode_toggle"; # toggle focus window
       "mod4+Shift+space" = "floating toggle"; # floating window
       "XF86MonBrightnessDown" = "exec light -U 10";  # increase increase brightness
       "XF86MonBrightnessUp" = "exec light -A 10"; # decrease brightness 
       "XF86AudioRaiseVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'"; # increase volume
       "XF86AudioLowerVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'"; # decrease volume
       "XF86AudioMute" = "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'"; # mute
     };


  # swaybar config
   bars = [{
    fonts.size = 15.0; 
    command = "waybar";
    position = "top";
    hiddenState = "hide";
    mode = "hide";
    extraConfig = "modifier mod4";
   }];
       
  # output      
   output = {  # external monitor
    HDMI-A-1 = { 
     mode = "1366x768";
     bg =  "/home/krizdavezz/Pictures/wallpaper/the big lebowski.jpg fill" ;            
     position = "0,1920";
      };
     };
    };
          
  # extra configurations
   extraConfig = 
   "exec autotiling \n
    output * bg /home/krizdavezz/Pictures/wallpaper/the big lebowski.jpg fill"; 
   };
      
  # waybar
   programs.waybar = {
    enable = true;   
     style= (builtins.readFile  /home/krizdavezz/.config/waybar/style.css);
    };


   };

  };
 

 

 



}
