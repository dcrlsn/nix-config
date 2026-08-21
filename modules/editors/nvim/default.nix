{
  config,
  lib,
  pkgs,
  vars,
  ...
}:

{
  options.custom.editors.nvim = {
    enable = lib.mkEnableOption "Neovim editor with custom configuration";
  };

  config = lib.mkIf config.custom.editors.nvim.enable {
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
        source = ./.;
        recursive = true;
      };
    };
  };
}
