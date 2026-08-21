{
  description = "Nix, NixOS and Nix Darwin System Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11"; # Stable Nix Packages
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable Nix Packages
    nixos-hardware.url = "github:nixos/nixos-hardware/master"; # Hardware Specific Configurations

    # User Environment Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # KDE Plasma User Settings Generator
    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "nixpkgs";
    };

    # Google Antigravity
    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      nixos-hardware,
      home-manager,
      home-manager-unstable,
      plasma-manager,
      ...
    }:
    let
      vars = {
        user = "dcrlsn";
        location = "$HOME/.setup";
        terminal = "alacritty";
        editor = "nvim";
      };
    in
    {
      nixosConfigurations = import ./hosts {
        inherit (nixpkgs) lib;
        inherit
          inputs
          nixpkgs
          nixpkgs-unstable
          nixos-hardware
          home-manager
          home-manager-unstable
          plasma-manager
          vars
          ;
      };
    };
}
