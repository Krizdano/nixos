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
      ];
  # Everything inside here is managed by Home Manager!

 # imports  = [ ../../modules/shell/zsh.nix ];
  # version
  #home.stateVersion = "22.05";


  # sway idle  
 # services.swayidle= {
  #  enable = true;
  #  timeouts = [
  #   { timeout = 200; command = "swaylock -f -c 000000"; }  
   #  { timeout = 400; command = "swaymsg 'output * poweroff' resume swaymsg 'output * power on'";
    # }  
   # ];
    #events = [
    # { event = "before-sleep"; command = "swaylock -f -c 000000";} 
    #];
  #}; 

  #programs.home-manager = {
  # enable = true;

  #};



  home.packages = with pkgs; [
   #pulseaudio   
   #w3m # terminal browser
   #ytfzf # terminal youtube 
   #bemenu # search bar
   #fzf
   #glib # gsettings
  ];
  
  # lf terminal filemanager
  #programs.lf = {
  # enable = true; 
  # keybindings = { # certain keybindings
   #  "." = "set hidden!";
   #  "<enter>" = "shell";
   #  "o" = "open";
   #  "DD" = "delete";
   #};
 # };


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



  # starship shell prompt
  #programs.starship = {
  # enable = true;
  # enableZshIntegration = true; # enable zsh integration 
  # # config
  # settings = {
  #  add_newline = false;
  #  username = {
  #    style_user = "bright-white bold";
  #    style_root = "bright-red bold";
  # };
  #  hostname = {
  #    style = "bright-green bold";
  #    ssh_only = true;
  #  };
  #  nix_shell = {
  #    symbol = "";
  #    format = "[$symbol$name]($style) ";
  #    style = "bright-purple bold";
  #  };
  #  git_branch = {
  #    only_attached = true;
  #    format = "[$symbol$branch]($style) ";
  #    symbol = "שׂ";
  #    style = "bright-yellow bold";
  #  };
  #  git_commit = {
  #    only_detached = true;
  #    format = "[ﰖ$hash]($style) ";
  #    style = "bright-yellow bold";
  #  };
  #  git_state = {
  #    style = "bright-purple bold";
  #  };
  #  git_status = {
  #    style = "bright-green bold";
  #  };
  #  directory = {
  #    read_only = " ";
  #    truncation_length = 0;
  #  };
  #  cmd_duration = {
  #    format = "[$duration]($style) ";
  #    style = "bright-blue";
  #  };
  #  jobs = {
  #    style = "bright-green bold";
  #  };
  #  character = {
  #    success_symbol = "[\\$](bright-green bold)";
  #    error_symbol = "[\\$](bright-red bold)";
  #    };
  #  };
  #};


  # neovim
  #programs.neovim = {
  # enable = true;
  # viAlias = true; 
  # withNodeJs = true; # for coc plugin
  # extraConfig = ''  set relativenumber 
  #                   set ignorecase 
  #                   set splitright
  #                   set splitbelow
  #                   set termguicolors
  #                   colorscheme catppuccin
  #                   map j gj
  #                   map k gk
  #                   let mapleader = " "
  #                   map <Leader>j :bp<CR>
  #                   map <Leader>k :bn<CR>
  #                   map <Leader>q :bp<CR>:bd #<CR>
  #                   map <Leader>z :split term://zsh<CR>
  #                   map <Leader>t :NvimTreeFocus<CR>
  #                   map <Leader>w <C-w>k
  #                   map <Leader>a <C-w>h
  #                   map <Leader>s <C-w>j
  #                   map <Leader>d <C-w>l
    #                '';
   # coc settings
  # coc = {
  #   enable = true;
  #   settings = { "suggest.noselect" = true; };
  #   #coc config
  #   pluginConfig = '' inoremap <silent><expr> <TAB>
  #                      \ coc#pum#visible() ? coc#pum#next(1) :  
  #                      \ CheckBackspace() ? "\<Tab>" :
  #                      \ coc#refresh()''; }; # using tab for completio#n
  #  #plugins
  #  plugins = with pkgs.vimPlugins; [
  #     vim-nix #nix language syntaxhighlighting 
  #     coc-rust-analyzer # rust language support  

   #           {
  #       plugin = nvim-autopairs; # auto pair parantheses and quotes
  #       type = "lua";
  #       config = ''require("nvim-autopairs").setup {}'';
  #     }
  #     
  #          {
  #     plugin = catppuccin-nvim; # theme
  #     type = "lua";
  #     config = ''require("catppuccin").setup {
  #       flavour = "mocha",
  #       background = {
  #       light = "latte",
  #       dark = "mocha",
  #       },
	#compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
        # color_overrides = {
        # mocha = {
        # base = "#161718",
        #  },
        # },
        # integrations = {
        # nvimtree = true,
        #  },
    #}

  #       ''; }




     #{     
     #  plugin = lualine-nvim; # statusline for neovim
     #  type = "lua";
     #  config = '' local cp = require("catppuccin.palettes").get_palette(#)
    #               local custom_catppuccin = require "lualine.themes.catp#puccin"
    #               custom_catppuccin.normal.b.bg = cp.surface0
    #               custom_catppuccin.normal.c.bg = cp.base
    #               custom_catppuccin.insert.b.bg = cp.surface0
    #               custom_catppuccin.command.b.bg = cp.surface0
    #               custom_catppuccin.visual.b.bg = cp.surface0
    #               custom_catppuccin.replace.b.bg = cp.surface0
    #               custom_catppuccin.inactive.a.bg = cp.base
    #               custom_catppuccin.inactive.b.bg = cp.base
    #               custom_catppuccin.inactive.b.fg = cp.surface0
    #               custom_catppuccin.inactive.c.bg = cp.base 
    #               
    #               require("lualine").setup {
    #                options = {
	#	    theme = custom_catppuccin,
	#	    component_separators = "|",
	#	    section_separators = { left = "", right = ""},
        #            },
	#           sections = {
	#	    lualine_a = { { "mode", separator = { left = "" }, right_#padding = 2 } },
	#	    lualine_b = { "filename", "branch", { "diff", colored = fa#lse } },
	#	    lualine_c = {},
	#	    lualine_x = {},
	#	    lualine_y = { "filetype", "progress" },
	#	    lualine_z = { { "location", separator = { right = ""}, le#ft_padding = 2 } },
        #            },
        #           inactive_sections = {
	#	    lualine_a = { "filename" },
	#	    lualine_b = {},
	#	    lualine_c = {},
	#	    lualine_x = {},
	#	    lualine_y = {},
	#	    lualine_z = {},
        #            },
        #           tabline = {
	#	    lualine_a = {
        #            {
	#	     "buffers",
        #             separator = { left = "", right = ""},
	#	     right_padding = 5,
        #             top_padding = 5,
        #             symbols = { alternate_file = "" },
        #            },
        #           },
	#          },
        #         }'';
     #} ## end of lualine config

     #{
     #  plugin = nvim-tree-lua; # side folder for neovim
     #  type = "lua";
     #  config = ''                    
     #             require("nvim-tree").setup{
     #              disable_netrw = true,
	#           hijack_netrw = true,
	#           open_on_tab = false,
	#           hijack_cursor = true,
	#           hijack_unnamed_buffer_when_opening = false,
	#           update_cwd = true,
        #           
	#           update_focused_file = {
        #            enable = true,
        #            update_cwd = false,
        #           },

	 #          sync_root_with_cwd = true,
         #          
         #          view = {
	#	    width = 25,
	#	    hide_root_folder = false,
        #           },

	#           git = {
	#	    enable = false,
	#	    ignore = true,
        #           },

	 #          actions = {
	#	    open_file = {
	#	     resize_window = true,
	#	    },
	#           },

	#           renderer = {
        #            indent_markers = {
        #            enable = false,
        #            },
        #           },
        #          } '';
    # } ## end of nvim tree config
    #]; ## end of neovim plugins
 # };# # e#nd of neovim



  # kitty
  #programs.kitty = {
  #  enable = true;
  #  extraConfig = "
  #                  # The basic colors
  #                  foreground              #CDD6F4
  #                  background              #161718
  #                  selection_foreground    #1E1E2E
  #                  selection_background    #F5E0DC

                    # Cursor colors
   #                 cursor                  #F5E0DC
   #                 cursor_text_color       #1E1E2E

                    # URL underline color when hovering with mouse
    #                url_color               #F5E0DC

                    # Kitty window border colors
    #                active_border_color     #B4BEFE
    #                inactive_border_color   #6C7086
    #                bell_border_color       #F9E2AF

                    # OS Window titlebar colors
     #               wayland_titlebar_color system
     #               macos_titlebar_color system

                    # Tab bar colors
    #                active_tab_foreground   #11111B
    #                active_tab_background   #CBA6F7
    #                inactive_tab_foreground #CDD6F4
    #                inactive_tab_background #181825
    #                tab_bar_background      #11111B

                    # Colors for marks (marked text in the terminal)
     #               mark1_foreground #1E1E2E
     #               mark1_background #B4BEFE
     #               mark2_foreground #1E1E2E
     #               mark2_background #CBA6F7
     #               mark3_foreground #1E1E2E
     #               mark3_background #74C7EC

                    # The 16 terminal colors

                    # black
    #                color0 #45475A
    #                color8 #585B70

                    # red
    #                color1 #F38BA8
    #                color9 #F38BA8

                    # green
    #                color2  #A6E3A1
    #                color10 #A6E3A1

                    # yellow
     #               color3  #F9E2AF
     #               color11 #F9E2AF

                    # blue
     #               color4  #89B4FA
     #               color12 #89B4FA

                    # magenta
     #               color5  #F5C2E7
     #               color13 #F5C2E7

                    # cyan
      #              color6  #94E2D5
     #               color14 #94E2D5

                    # white
       #             color7  #BAC2DE
        #            color15 #A6ADC8

                  
       #          \n background_opacity 0.6
       #          \n dynamic_background_opacity yes
       #          \n confirm_os_window_close 0 ";
 # }#;


  # mpv video player
 # programs.mpv = {
 #   enable = true;
 #   scripts = with pkgs.mpvScripts; [
 #    # for mpv scripts
 #   ];
 # };

  # git
 # programs.git = {
 #   enable = true;
 #   userName = "Krizdano";
 #   userEmail = "akrishna852@gmail.com";
 # };
 # 
 # # github cli
 # programs.gh = {
 #   enable  = true;
 #   enableGitCredentialHelper = true;
 # };
 #  
 # # kdeconnect
 # services.kdeconnect = {
 #   enable = true;
 #   indicator = true;
 # };


  # wallpaper
 # home.file.".config/wallpapers".source = ../../modules/themes/wallpap#ers;
 # home.file.".themes".source = ../../modules/themes/.themes;
 # home.file.".config/scripts".source = ../../config/scripts;
 # home.file.".config/ytfzf/subscriptions".source = ../../config/ytfzf/#subscriptions;
 # home.file.".config/waybar/config".source = ../../config/waybar/confi#g;
 # home.file.".config/waybar/style.css".source = ../../config/waybar/st#yle.css;
 # # themes
 # gtk = {
 #   enable = true;
 #   theme =  { 
 #   name =  "Catppuccin-Mocha";
 #       
 #   };
 # };

 # qt = {
 #   enable = true;
 #   platformTheme = "gtk";
 # };



    
       
   
  # waybar
 # programs.waybar = {
 #   enable = true;   
 #   #style= (builtins.readFile  /home/krizdavezz/.config/waybar/style.#css);
 # };


   }; #end of home-manager programs

  }; # end of home-manager
 
} # end of configuration
