{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.programs.copilot = {
    enable = lib.mkEnableOption "GitHub Copilot CLI";
  };

  config = lib.mkIf config.custom.programs.copilot.enable {
    environment.systemPackages = with pkgs; [
      github-copilot-cli
    ];
  };
}
