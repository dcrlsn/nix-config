#
#  These are the different profiles that can be used when building NixOS.
#
#  flake.nix
#   └─ ./hosts
#       ├─ default.nix *
#       ├─ configuration.nix
#       └─ ./<host>.nix
#           └─ default.nix
#

{ inputs, nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager, plasma-manager, vars, ... }:

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
in
{
  # Desktop Profiles
  marika = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system unstable vars;
      host = {
        hostName = "marika";
      };
    };
    modules = [
      ./marika
      ./configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
  millicent = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system unstable vars;
      host = {
        hostName = "millicent";
      };
    };
    modules = [
      ./millicent
      ./configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };

}
