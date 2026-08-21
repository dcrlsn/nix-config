{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.programs.discord = {
    enable = lib.mkEnableOption "Discord chat client and BetterDiscord utility";
    withBetterDiscord = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Include betterdiscordctl";
    };
  };

  config = lib.mkIf config.custom.programs.discord.enable {
    environment.systemPackages =
      with pkgs;
      [
        discord
      ]
      ++ lib.optional config.custom.programs.discord.withBetterDiscord betterdiscordctl;
  };
}
