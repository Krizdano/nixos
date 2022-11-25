{ pkgs, ... }: {

  programs.lf = {
   enable = true; 
   keybindings = { # certain keybindings
     "." = "set hidden!";
     "<enter>" = "shell";
     "o" = "$glow -p $f";
     "DD" = "delete";

   };
   extraConfig = ''
     set previewer ~/.config/lf/lf_kitty_preview
     set cleaner ~/.config/lf/lf_kitty_clean
     '';
  };

  home.packages = with pkgs; [
    file
    pistol
  ];
}


