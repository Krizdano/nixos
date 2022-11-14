# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

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

 
 
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # laptop screen brightness
  programs.light.enable= true;
  
  # shell(zsh)
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;

    shellAliases = { # all shell aliases
      conf = "vi ~/NixConfig/hosts/laptop/default.nix"; # nixos configuration
      # rebuild nixos using flake
      re = "pushd ~/NixConfig
           \n doas nixos-rebuild switch --flake '.#laptop'
           \n popd"; 
      # update nixos using flakes
      update = "pushd ~/NixConfig 
                \n nix flake update
                \n popd"; 
      # turn on laptop screen on and off in sway
      lo = "swaymsg output eDP-1 dpms off";
      ln = "swaymsg output eDP-1 dpms on";
      # nix-shell with rust development tools
      rus = "cd ~/rust/
            \n nix-shell"; 
      # update configuation.nix to git repository
      gp = "cp -r ~/NixConfig/  ~/nixos/ 
            \n pushd ~/nixos
            \n git add NixConfig 
            \n git commit -m 'updated config' 
            \n git push 
            \n popd "; 
      # w3m with google search 
      gg = "w3m google.com";
      yt = "ytfzf -t --thumb-viewer=kitty -f -s --detach -l --preview-side=right"; # youtube 
    };
  };
 

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     neofetch
     gnome.gnome-boxes
     htop
     gdu # disk management
     gimp
     mimeo
     tdesktop # telegram
     firefox-wayland 
     #sway
  ];

  


#  ╦ ╦╔═╗╔╦╗╔═╗   ╔╦╗╔═╗╔╗╔╔═╗╔═╗╔═╗╦═╗
#  ╠═╣║ ║║║║║╣ ───║║║╠═╣║║║╠═╣║ ╦║╣ ╠╦╝ 
#  ╩ ╩╚═╝╩ ╩╚═╝   ╩ ╩╩ ╩╝╚╝╩ ╩╚═╝╚═╝╩╚═    
     # Begin home-manager directives

  home-manager = {
    #useUserPackages = true;
    #useGlobalPkgs = true;
    users.${user} = { config, pkgs, inputs, ... }: {

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



  home.packages = with pkgs; [
   pulseaudio   
   swaylock
   swayidle
   sway-launcher-desktop
   wl-clipboard
   mako # notifications
   w3m # terminal browser
   ytfzf # terminal youtube 
   bemenu # search bar
   wl-clipboard
   fzf
   wf-recorder
   sway-contrib.inactive-windows-transparency
   glib # gsettings
   slurp
   autotiling #sway autotiling
  ];
  
  # lf terminal filemanager
  programs.lf = {
   enable = true; 
   keybindings = { # certain keybindings
     "." = "set hidden!";
     "<enter>" = "shell";
     "o" = "open";
     "DD" = "delete";
   };
  };

  # starship shell prompt
  programs.starship = {
   enable = true;
   enableZshIntegration = true; # enable zsh integration 
   # config
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
   withNodeJs = true; # for coc plugin
   extraConfig = ''  set relativenumber 
                     set ignorecase 
                     set splitright
                     set splitbelow
                     set termguicolors
                     colorscheme catppuccin
                     map j gj
                     map k gk
                     let mapleader = " "
                     map <Leader>j :bp<CR>
                     map <Leader>k :bn<CR>
                     map <Leader>q :bp<CR>:bd #<CR>
                     map <Leader>z :split term://zsh<CR>
                     map <Leader>t :NvimTreeFocus<CR>
                     map <Leader>w <C-w>k
                     map <Leader>a <C-w>h
                     map <Leader>s <C-w>j
                     map <Leader>d <C-w>l
                    '';
   # coc settings
   coc = {
     enable = true;
     settings = { "suggest.noselect" = true; };
     #coc config
     pluginConfig = '' inoremap <silent><expr> <TAB>
                        \ coc#pum#visible() ? coc#pum#next(1) :  
                        \ CheckBackspace() ? "\<Tab>" :
                        \ coc#refresh()''; }; # using tab for completion
    #plugins
    plugins = with pkgs.vimPlugins; [
       vim-nix #nix language syntaxhighlighting 
       coc-rust-analyzer # rust language support  

              {
         plugin = nvim-autopairs; # auto pair parantheses and quotes
         type = "lua";
         config = ''require("nvim-autopairs").setup {}'';
       }
       
            {
       plugin = catppuccin-nvim; # theme
       type = "lua";
       config = ''require("catppuccin").setup {
         flavour = "mocha",
         background = {
         light = "latte",
         dark = "mocha",
         },
	compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
         color_overrides = {
         mocha = {
         base = "#161718",
          },
         },
         integrations = {
         nvimtree = true,
          },
    }

         ''; }


     {     
       plugin = lualine-nvim; # statusline for neovim
       type = "lua";
       config = '' local cp = require("catppuccin.palettes").get_palette()
                   local custom_catppuccin = require "lualine.themes.catppuccin"
                   custom_catppuccin.normal.b.bg = cp.surface0
                   custom_catppuccin.normal.c.bg = cp.base
                   custom_catppuccin.insert.b.bg = cp.surface0
                   custom_catppuccin.command.b.bg = cp.surface0
                   custom_catppuccin.visual.b.bg = cp.surface0
                   custom_catppuccin.replace.b.bg = cp.surface0
                   custom_catppuccin.inactive.a.bg = cp.base
                   custom_catppuccin.inactive.b.bg = cp.base
                   custom_catppuccin.inactive.b.fg = cp.surface0
                   custom_catppuccin.inactive.c.bg = cp.base 
                   
                   require("lualine").setup {
                    options = {
		    theme = custom_catppuccin,
		    component_separators = "|",
		    section_separators = { left = "", right = ""},
                    },
	           sections = {
		    lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
		    lualine_b = { "filename", "branch", { "diff", colored = false } },
		    lualine_c = {},
		    lualine_x = {},
		    lualine_y = { "filetype", "progress" },
		    lualine_z = { { "location", separator = { right = ""}, left_padding = 2 } },
                    },
                   inactive_sections = {
		    lualine_a = { "filename" },
		    lualine_b = {},
		    lualine_c = {},
		    lualine_x = {},
		    lualine_y = {},
		    lualine_z = {},
                    },
                   tabline = {
		    lualine_a = {
                    {
		     "buffers",
                     separator = { left = "", right = ""},
		     right_padding = 5,
                     top_padding = 5,
                     symbols = { alternate_file = "" },
                    },
                   },
	          },
                 }'';
     } # end of lualine config

     {
       plugin = nvim-tree-lua; # side folder for neovim
       type = "lua";
       config = ''                    
                  require("nvim-tree").setup{
                   disable_netrw = true,
	           hijack_netrw = true,
	           open_on_tab = false,
	           hijack_cursor = true,
	           hijack_unnamed_buffer_when_opening = false,
	           update_cwd = true,
                   
	           update_focused_file = {
                    enable = true,
                    update_cwd = false,
                   },

	           sync_root_with_cwd = true,
                   
                   view = {
		    width = 25,
		    hide_root_folder = false,
                   },

	           git = {
		    enable = false,
		    ignore = true,
                   },

	           actions = {
		    open_file = {
		     resize_window = true,
		    },
	           },

	           renderer = {
                    indent_markers = {
                    enable = false,
                    },
                   },
                  } '';
     } # end of nvim tree config
    ]; # end of neovim plugins
  }; # end of neovim



  # kitty
  programs.kitty = {
    enable = true;
    extraConfig = "
                    # The basic colors
                    foreground              #CDD6F4
                    background              #161718
                    selection_foreground    #1E1E2E
                    selection_background    #F5E0DC

                    # Cursor colors
                    cursor                  #F5E0DC
                    cursor_text_color       #1E1E2E

                    # URL underline color when hovering with mouse
                    url_color               #F5E0DC

                    # Kitty window border colors
                    active_border_color     #B4BEFE
                    inactive_border_color   #6C7086
                    bell_border_color       #F9E2AF

                    # OS Window titlebar colors
                    wayland_titlebar_color system
                    macos_titlebar_color system

                    # Tab bar colors
                    active_tab_foreground   #11111B
                    active_tab_background   #CBA6F7
                    inactive_tab_foreground #CDD6F4
                    inactive_tab_background #181825
                    tab_bar_background      #11111B

                    # Colors for marks (marked text in the terminal)
                    mark1_foreground #1E1E2E
                    mark1_background #B4BEFE
                    mark2_foreground #1E1E2E
                    mark2_background #CBA6F7
                    mark3_foreground #1E1E2E
                    mark3_background #74C7EC

                    # The 16 terminal colors

                    # black
                    color0 #45475A
                    color8 #585B70

                    # red
                    color1 #F38BA8
                    color9 #F38BA8

                    # green
                    color2  #A6E3A1
                    color10 #A6E3A1

                    # yellow
                    color3  #F9E2AF
                    color11 #F9E2AF

                    # blue
                    color4  #89B4FA
                    color12 #89B4FA

                    # magenta
                    color5  #F5C2E7
                    color13 #F5C2E7

                    # cyan
                    color6  #94E2D5
                    color14 #94E2D5

                    # white
                    color7  #BAC2DE
                    color15 #A6ADC8

                  
                 \n background_opacity 0.6
                 \n dynamic_background_opacity yes
                 \n confirm_os_window_close 0 ";
  };


  # mpv video player
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
     # for mpv scripts
    ];
  };

  # git
  programs.git = {
    enable = true;
    userName = "Krizdano";
    userEmail = "akrishna852@gmail.com";
  };
  
  # github cli
  programs.gh = {
    enable  = true;
    enableGitCredentialHelper = true;
  };
   
  # kdeconnect
  services.kdeconnect = {
    enable = true;
    indicator = true;
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
      # touchpad config 
      input = { "1739:32382:PNP0C50:0e_06CB:7E7E_Touchpad" = {
        dwt = "enable";
        tap = "enable";
        natural_scroll = "enabled";
        middle_emulation = "enabled";
       };
      };

      terminal = "kitty";
      menu = "bemenu-run";
      modifier = "Mod4";
      gaps.inner = 7;
      window.border = 2;
      colors = {
        focused = {
          background = "#ffffff";
          border = "#ffffff";
          childBorder = "#BAC2DE";
          indicator = "#BAC2DE";
          text = "#ffffff";
        };

      };
      # keybindings 
      keybindings = {     
       "mod4+b" = "exec firefox"; # opens firefox
       "mod4+Shift+y" = "exec firefox https://www.youtube.com"; # opens youtube in firefox
       "mod4+Shift+n" = "exec firefox https://mipmip.github.io/home-manager-option-search/"; # opens home-manager search
       "mod4+n" = "exec firefox https://search.nixos.org/packages"; # opens nixos search 
       "mod4+Shift+q" = "kill"; # close windows
       "mod4+Return" =  "exec kitty"; # open terminal (alacritty)
       "mod4+d" = "exec kitty --class=launcher -e /nix/store/hx3w4vf0ky19kwsaz8pmc7n38g3mii17-sway-launcher-desktop-1.6.0/bin/sway-launcher-desktop"; # sway-launcher-desktop 
       "mod4+y" = "exec kitty --class=ytfzf -e ytfzf -t --thumb-viewer=kitty -l -s -f --preview-side=right"; # youtube in terminal
       "mod4+s" = "exec kitty --class=ytfzf -e ytfzf -t --thumb-viewer=kitty -l -s -f -c SI --preview-side=right"; # youtube subscriptions in terminal
       "mod4+Shift+c" = "reload"; # reload sway
       
       # exit sway 
       "mod4+shift+e" = "exec swaynag - t warning -m 'you pressed the exit shortcut.Do you really want to exit sway?' -B 'yes' 'swaymsg exit'"; 
       
       #scratchpad
       "mod4+Shift+minus" = "move scratchpad";
       "mod4+minus" = "scratchpad show";

       # moving aroud
       "mod4+Down" = "focus down";
       "mod4+Up" = "focus up";
       "mod4+Right" = "focus right";
       "mod4+Left" = "focus left";
       # use vim keys to move around
       "mod4+j" = "focus down";
       "mod4+k" = "focus up";
       "mod4+l" = "focus right";
       "mod4+h" = "focus left";

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
        bg =  "/home/krizdavezz/Pictures/wallpaper/pulp_fiction_wallpaper.jpg fill";        
        position = "0,1920";
       };
      };
    };
          
    # extra configurations
    extraConfig = 
    "exec autotiling \n
     exec inactive-windows-transparency.py \n 
     output * bg /home/krizdavezz/Pictures/wallpaper/three_squares.png fill \n
     include /home/krizdavezz/.config/sway/extraconf";
      
  }; # end of sway
      
  # waybar
  programs.waybar = {
    enable = true;   
    #style= (builtins.readFile  /home/krizdavezz/.config/waybar/style.css);
  };


   }; #end of home-manager programs

  }; # end of home-manager
 
} # end of configuration
