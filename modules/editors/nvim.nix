{ config, lib, system, pkgs, unstable, vars, ... }:

let
  colors = import ../theming/colors.nix;
in
{
  environment = {
    systemPackages = with pkgs; [
      go
      nodejs
      python3
      rustc
      cargo
      git
      gcc
      gnumake
      unzip
      curl
      ripgrep
      fd
    ];
  };
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };
  home-manager.users.${vars.user} = {
    xdg.configFile."nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };
}

