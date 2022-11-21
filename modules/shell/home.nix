{ pkgs, ...}: 

{

 # shell(zsh)
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;
    initExtra = ''eval "$(starship init zsh)" '';
  };
}

