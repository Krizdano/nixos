{ pkgs, config, lib, ...}:

{

 # sway 
  wayland.windowManager.sway = {
    enable = true; 
    systemdIntegration = true;
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

      terminal = "${pkgs.kitty}/bin/kitty";
      menu = "${pkgs.sway-launcher-desktop}/bin/sway-launcher-desktop";
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
       "mod4+d" = "exec kitty --class=launcher -e sway-launcher-desktop"; # sway-launcher-desktop 
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
        "*".bg =  "~/.config/wallpapers/three_squares.png fill";        
        "HDMI-A-1".mode = "1366x768";
        "HDMI-A-1".position = "0,1920";
       };
    };
          
    # extra configurations
    extraConfig = 
    "exec autotiling 
     exec inactive-windows-transparency.py  
     output * bg /home/krizdavezz/Pictures/wallpapers/three_squares.png fill 
     include /home/krizdavezz/.config/sway/extraconf";
      
  }; # end of sway
      

  home.packages = with pkgs; [

    swaylock
    swayidle
    sway-launcher-desktop
    wl-clipboard
    mako
    wf-recorder
    sway-contrib.inactive-windows-transparency
    autotiling
    slurp
  ];
}




