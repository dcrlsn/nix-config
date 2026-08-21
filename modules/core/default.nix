{ lib, ... }:

{
  options.custom.core.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable core baseline system configuration";
  };

  config = {
    boot.tmp = {
      cleanOnBoot = true;
      tmpfsSize = "5GB";
    };
  };
}
