# My personal Nixos flake 
# this flake manages my Nixos Configuration

#  flake.nix *             
#   ├─ ./hosts
#   │   └─ default.nix

{ 
  description = "My personal Nixos Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { self, home-manager, nixpkgs, ... }: 
   let
     user = "krizdavezz";
     location = "$HOME/NixConfig";
   in 
  {
  nixosConfigurations = (
    import ./hosts {
      inherit (nixpkgs) lib;
      inherit nixpkgs home-manager user location;
    }
   ); 
  };
   
}
