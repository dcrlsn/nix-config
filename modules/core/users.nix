{
  config,
  lib,
  vars,
  ...
}:

lib.mkIf config.custom.core.enable {
  users.users.${vars.user} = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh = {
      authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBy0Ayh+LE/JgCOREmmbaurPg00u1UtbuReYLqVix2MG marika"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIES+FenVoKlLV5YsL9yH0qTKWjavr55Au/PlAYyGonSG ranni"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIb7teK5NPq1RVqm/ItSxYIiQsXUkSbJA/u1FDXEVLmE millicent"
      ];
    };
  };

  home-manager.users.${vars.user} = {
    home = {
      stateVersion = "25.11";
    };
    programs = {
      home-manager.enable = true;
    };
  };
}
