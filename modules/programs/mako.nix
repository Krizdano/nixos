{ pkgs, ... }: 
{
  programs.mako = {
    enable = true;
    actions = true;
    anchor = "top-right";
    backgroundColor = "#2b2b2b";
    textColor = "#ffffff";
    borderColor = "#aaaaaa";
    borderRadius = 5;
    borderSize = 3;
    defaultTimeout = 5000;
    format = ''<b>%s</b>\n%b''; 
    ignoreTimeout = true;
    padding = "8";
    sort = "+time";
  };
}
