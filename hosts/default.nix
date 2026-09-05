#
#  NixOS Host Profiles with Dendritic Module Loading
#

{
  inputs,
  nixpkgs,
  nixpkgs-unstable,
  nixos-hardware,
  home-manager,
  home-manager-unstable,
  plasma-manager,
  vars,
  ...
}:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
  unstable-lib = nixpkgs-unstable.lib;
in
{
  marika = unstable-lib.nixosSystem {
    inherit system;
    pkgs = unstable;
    specialArgs = {
      inherit
        inputs
        system
        unstable
        vars
        ;
      host = {
        hostName = "marika";
      };
    };
    modules = [
      ../modules
      ./marika
      home-manager-unstable.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
      }
    ];
  };

  millicent = unstable-lib.nixosSystem {
    inherit system;
    pkgs = unstable;
    specialArgs = {
      inherit
        inputs
        system
        unstable
        vars
        ;
      host = {
        hostName = "millicent";
      };
    };
    modules = [
      ../modules
      ./millicent
      home-manager-unstable.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
      }
    ];
  };
}
