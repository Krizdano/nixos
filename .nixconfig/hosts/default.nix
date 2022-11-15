# profile types (laptop or vm) used to build Nixos

#  flake.nix 
#   └─ ./hosts  
#       ├─ default.nix *
#       ├─ configuration.nix
#       └─ ./laptop OR ./vm
#             └─ ./default.nix
#     

   {lib, home-manager, nixpkgs, user, location, ... }: 

    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in
    { 
     laptop = lib.nixosSystem {
       inherit system;
       specialArgs = { inherit user location;};
       modules = [
         ./configuration.nix
         ./laptop

         home-manager.nixosModules.home-manager {
           home-manager.useGlobalPkgs= true;
           home-manager.useUserPackages = true;
         }
       ]; };
     vm = lib.nixosSystem {
       inherit system;
       specialArgs = { inherit user location; };
       modules = [
         ./configuration.nix
         ./vm
         home-manager.nixosModules.home-manager {
           home-manager.useGlobalPkgs = true;
           home-manager.useUserPackages = true;
         }
       ];
     };
}

