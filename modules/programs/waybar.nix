{ pkgs, ... }: {

# waybar
  programs.waybar = {
    enable = true;   
    style = ''
      @define-color background  #161718;
      @define-color background2 #282828;
      @define-color shutdown  #cc241d;
      @define-color background3 #458588;
      @define-color text    #bac2de;


      @keyframes blink-warning {
          70% {
              color: white;
          }

          to {
              color: white;
              background-color: orange;
          }
      }

      @keyframes blink-critical {
          70% {
            color: white;
      }

          to {
              color: white;
              background-color: red;
          }
      }

      /* -----------------------------------------------------------------------------
       * Base styles
       * -------------------------------------------------------------------------- */

      /* Reset all styles */
      * {
          border: none;
          border-radius: 0;
          min-height: 0;
          margin: 1px;
          padding: 0;
      }

      /* The whole bar */
      #waybar {
          background: @background;
          color: #bebebe;
          font-family: "Ubuntu Nerd Font";
          font-size: 14px;
          border-radius: 8px;
          border: 1px solid #a6adc8;
      }


      /* Every modules */
      #battery,
      #clock,
      #backlight,
      #cpu,
      #custom-keyboard-layout,
      #memory,
      #mode,
      #custom-weather,
      #network,
      #pulseaudio,
      #temperature,
      #tray,
      #idle_inhibitor,

      #custom-PBPbattery {
          padding:0.5rem 0.6rem;
          margin: 1px 0px;
      }

      /* -----------------------------------------------------------------------------
       * Modules styles
       * -------------------------------------------------------------------------- */
      #window {
	
	font-family: "Ubuntu";
	color: @text;
	padding-right: 6px;
	padding-right: 6px;

      }


      #tray, #notification{
          background-color: @background;
      }


      #custom-notification {
          border-radius: 0px;
          color: @text;
          padding-right: 16px;
          margin-left: 0;
          margin-right: 0px;
          background-color: @background;
          border-radius: 0px 0px 0px 0px;
      }


      #tray {
          color:  @text;
          margin-right: 0;
          border-radius: 0px;
          background-color: @background;
      }


      #network, #memory, #cpu, #pulseaudio, #battery{
          background-color: @background;
          color: @text;
          font-size: 14px;
          margin-top: 0px;
          margin-bottom: 0px;
      }

      #cpu {
          padding-left: 0px;
          margin-right: 0px;
          padding-left: 6px;
          padding-right: 6px;
      }


      #memory {
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }


      #network {
          border-radius: 0px 0px 0px 0px;
          padding-left: 6px;
          padding-right: 6px;
          margin-right: 0px;
      }

      #battery {
          border-radius: 0px 0px 0px 0px;
          padding-left: 6px;
          padding-right: 10px;
          margin-right: 0px;
      }


      #mode {
          background: @highlight;
          border-bottom: 3px transparent;
          color:white;
          margin-left: 5px;
          padding:7;
      }

      #network.disconnected {
          color: #d65d0e;
      }

      #pulseaudio {
          padding-left: 0px;
          padding-top: 10px;
          padding-right: 4px;
          border-radius: 0px 8px 8px 0px;
      }

      #pulseaudio.muted {
          color: @highlight;
      }


      #workspaces {
          font-size:14px;
          border-radius: 8px; 
          background-color: @background;
          color: @text;
          padding: 4px;
      }

      #workspaces button {
          border-radius: 8px;
          margin: 0px;
          font-weight: normal;
          color: @text;
          font-size: 14px;
          padding-top: 3px;
          padding-bottom: 3px;
          padding-left: 4;
          padding-right: 5;
      }

      #workspaces button.focused {
          background-color: @text;
          color: @background2;
          border-radius: 8px;
          margin-top: 0px;
          margin-bottom: 0px;
      }


      #workspaces button.urgent {
          border-color: @shutdown;
          color: @shutdown;
      }


      #clock {
          color: @text;
          border-radius: 8px;
          padding-right: 10px;
          padding-left: 6px;
          background-color: @background;
      }
          '';
  };

  home.file.".config/waybar/config" = {
    text = ''
{
    "layer": "top", // Waybar at top layer
    "position": "top", // Waybar at the bottom of your screen
    "height": 24, // Waybar height
    // "width": 1300, // Waybar width


    // -------------------------------------------------------------------------
    // Global configuration
    // -------------------------------------------------------------------------
    "bar_id": "bar-0",
    "ipc": true,

    // Choose the order of the modules
    "modules-left": ["sway/workspaces", "sway/mode", "custom/spotify"],
    "modules-center": ["sway/window"],
    "modules-right": ["pulseaudio", "network", "cpu", "memory", "battery", "tray", "clock"],
    "sway/workspaces":
    {
       "format": "{icon}"
    
     },
    "sway/mode": {
        "format": "<span style=\"italic\">{}</span>"
    },
    "tray": {
        // "icon-size": 21,
        "spacing": 10
    },
    "clock": {
        "format": "{:%I:%M %p}"
    },
    "cpu": {
        "format": "{usage}% "
    },
    "memory": {
        "format": "{}% "
    },
    "battery": {
        "bat": "BAT1",
        "states": {
            // "good": 95,
            "warning": 30,
            "critical": 15
        },
        "format": "{capacity}% {icon}",
        // "format-good": "", // An empty format will hide the module
        // "format-full": "",
        "format-icons": ["", "", "", "", ""]
    },
    "network": {
        // "interface": "wlp2s0", // (Optional) To force the use of this interface
        "format-wifi": "{essid} ({signalStrength}%) ",
        "format-ethernet": "{ifname}: {ipaddr}/{cidr} ",
        "format-disconnected": "Disconnected ⚠"
    },
    "pulseaudio": {
        //"scroll-step": 1,
        "format": "{volume}% {icon}",
        "format-bluetooth": "{volume}% {icon}",
        "format-muted": "",
        "format-icons": {
            "headphones": "",
            "handsfree": "",
            "headset": "",
            "phone": "",
            "portable": "",
            "car": "",
            "default": ["", ""]
        },
        "on-click": "pavucontrol"
    },
    "custom/spotify": {
        "format": " {}",
        "max-length": 40,
        "interval": 30, // Remove this if your script is endless and write in loop
        "exec": "$HOME/.config/waybar/mediaplayer.sh 2> /dev/null", // Script in resources folder
        "exec-if": "pgrep spotify"
    }
}
    '';
  };

}
