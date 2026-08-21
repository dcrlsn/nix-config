{ config, lib, ... }:

lib.mkIf config.custom.core.enable {
  services = {
    printing = {
      enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
    };
    flatpak.enable = true;
  };

  # Required by Flatpak and modern desktop integrations
  xdg.portal.enable = true;
}
