{ pkgs, ... }: {

  programs.pistol = {
    enable = true;
    config = {
    };
  };

  home.packages = with pkgs; [
  ];
}
