{ config, lib, ... }:

lib.mkIf config.custom.core.enable {
  security = {
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };
}
