{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };


  outputs = {self, home-manager, nixpkgs, ... }: {

    nixosConfigurations = {
     nixos = nixpkgs.lib.nixosSystem {
       system = "x86_64-linux";
       modules = [
         ./configuration.nix
         home-manager.nixosModules.home-manager
       ];
     };
    };
  };
}
