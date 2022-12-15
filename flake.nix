# My personal Nixos flake 
# this is a flake manages my Nixos Configuration

#  flake.nix *             
#   ├─ ./hosts
#   │   └─ default.nix

{ 
  description = "My personal Nixos Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-22.11";

    home-manager = {
    url = "github:nix-community/home-manager/release-22.11";
    inputs.nixpkgs.follows = "nixpkgs";
    };

  };


  outputs = { self, home-manager, nixpkgs, ... }: 
   let
     user = "krizdavezz";
     location = "$HOME/.nixconfig";
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
