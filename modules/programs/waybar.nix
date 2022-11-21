{ pkgs, ... }: {

# waybar
  programs.waybar = {
    enable = true;   
    #style= (builtins.readFile  /home/krizdavezz/.config/waybar/style.css);
  };

}
