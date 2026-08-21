{
  config,
  lib,
  pkgs,
  unstable ? pkgs,
  vars,
  ...
}:

{
  options.custom.desktops.virtualization.docker = {
    enable = lib.mkEnableOption "Docker container engine and tools";
  };

  config = lib.mkIf config.custom.desktops.virtualization.docker.enable {
    virtualisation = {
      docker = {
        enable = true;
        package = unstable.docker;
      };
    };

    users.groups.docker.members = [ "${vars.user}" ];

    environment.systemPackages = [
      unstable.docker-compose
    ];
  };
}
