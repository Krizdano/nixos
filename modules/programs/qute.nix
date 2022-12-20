{ pkgs, ... }:

{
programs.qutebrowser = {
  enable = true;
  keyBindings = {
   normal = {
   "z" = "hint links spawn --detach mpv {hint-url}";
   "cs" = "config-source";
   };
  };
  settings = {
   statusbar.show = "in-mode";
   tabs.show = "switching";
   tabs.position = "left";
   scrolling.bar = "when-searching";
   url.default_page = "about:blank";
   url.start_pages = "about:blank";
  };
  extraConfig = ''
  config.source('themes/city-light-theme.py')
  config.set("colors.webpage.darkmode.enabled", True)
  '';
};
 home.file = {
 ".config/qutebrowser/themes".source = ../themes/qutebrowser;

 };
}
