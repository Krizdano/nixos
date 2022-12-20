{ pkgs, ... }: {

   programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
     # for mpv scripts
     youtube-quality
    ];
  };



}
