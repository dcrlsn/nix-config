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
    ];
  };
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = ''
        luafile ${./nvim/init.lua}
      '';
    };
  };
  home-manager.users.${vars.user} = {};
}

