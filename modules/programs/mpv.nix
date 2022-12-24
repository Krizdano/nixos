{ pkgs, ... }: {

   programs.mpv = {
    enable = true;
    #config = {
     # ytdl-format= "bestvideo[height<=?1080]+bestaudio/best";
    #};
    scripts = with pkgs.mpvScripts; [
     # for mpv scripts
     youtube-quality
    ];
  };



}
