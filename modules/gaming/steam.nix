{ config, lib, ... }:

{
  options.custom.gaming.steam = {
    enable = lib.mkEnableOption "Steam gaming and Sunshine game streaming";
  };

  config = lib.mkIf config.custom.gaming.steam.enable {
    programs.steam.enable = true;

    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [
        47984
        47989
        47990
        48010
      ];
      allowedUDPPortRanges = [
        {
          from = 47998;
          to = 48000;
        }
        {
          from = 8000;
          to = 8010;
        }
      ];
    };
  };
}
