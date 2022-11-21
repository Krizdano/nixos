{ pkgs, ... }: {

  programs.lf = {
   enable = true; 
   keybindings = { # certain keybindings
     "." = "set hidden!";
     "<enter>" = "shell";
     "o" = "open";
     "DD" = "delete";
   };
  };

}


