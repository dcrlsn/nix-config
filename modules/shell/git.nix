{
  config,
  lib,
  ...
}:

{
  options.custom.shell.git = {
    enable = lib.mkEnableOption "Git version control system";
  };

  config = lib.mkIf config.custom.shell.git.enable {
    programs.git = {
      enable = true;
    };
  };
}
