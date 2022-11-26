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

  home = {

   packages = with pkgs; [
    file
    pistol
  ];

    file.".config/lf/lf_kitty_clean" = {
     text = ''#!/usr/bin/env bash

      kitty +icat --clear --silent --transfer-mode file 
      '';
    executable = true;
  };


  file.".config/lf/lf_kitty_preview" = {
    text = ''
      #!/usr/bin/env bash
      file=$1
      w=$2
      h=$3
      x=$4
      y=$5
      
      if [[ "$( file -Lb --mime-type "$file")" =~ ^image ]]; then
          kitty +icat --silent --transfer-mode file --place ''${w}x''${h}@''${x}x''${y} "$file"
          exit 1
      fi
      
      pistol "$file"
          '';
      
    executable = true;
  };

};


}



