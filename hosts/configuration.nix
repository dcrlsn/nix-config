#
#  Main system configuration. More information available in configuration.nix(5) man page.
#
#  flake.nix
#   ├─ ./hosts
#   │   ├─ default.nix
#   │   └─ configuration.nix *
#   └─ ./modules
#       ├─ ./desktops
#       │   └─ default.nix
#       ├─ ./editors
#       │   └─ default.nix
#       ├─ ./hardware
#       │   └─ default.nix
#       ├─ ./programs
#       │   └─ default.nix
#       ├─ ./services
#       │   └─ default.nix
#       ├─ ./shell
#       │   └─ default.nix
#       └─ ./theming
#           └─ default.nix
#

{ lib, config, pkgs, stable, inputs, vars, ... }:

let
  terminal = pkgs.${vars.terminal};
in
{
  imports = (import ../modules/desktops ++
    import ../modules/editors ++
    import ../modules/programs ++
    import ../modules/shell ++
    import ../modules/theming);

  boot = {
    tmp = {
      cleanOnBoot = true;
      tmpfsSize = "5GB";
    };
  };
  
  users.users.${vars.user} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    openssh = {
      authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKvhXeFBArjo3LDrQGLILbPB0pSYbEIKSFk3/ayvxl99 marika"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIES+FenVoKlLV5YsL9yH0qTKWjavr55Au/PlAYyGonSG ranni"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIb7teK5NPq1RVqm/ItSxYIiQsXUkSbJA/u1FDXEVLmE millicent"
      ];
    };
  };

  time.timeZone = "America/New_York";
    i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  security = {
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  fonts.packages = with pkgs; [
    carlito # NixOS
    vegur # NixOS
    source-code-pro
    jetbrains-mono
    font-awesome # Icons
    corefonts # MS
    noto-fonts # Google + Unicode
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override {
      fonts = [
        "FiraCode"
      ];
    })
  ];

  environment = {
    variables = {
      TERMINAL = "${vars.terminal}";
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };
    systemPackages = with pkgs; [
      #Terminal
      terminal # Terminal Emulator
      xclip # Terminal Clipboard
      btop # Resource Manager
      coreutils # GNU Utilities
      git # Version Control
      gvfs # Samba
      killall # Process Killer
      lshw # Hardware Config
      nano # Text Editor
      nix-tree # Browse Nix Store
      pciutils # Manage PCI
      tldr # Helper
      usbutils # Manage USB
      wget # Retriever
      xdg-utils # Environment integration

      # Video/Audio
      vlc # Media Player

      # Apps
      appimage-run # Runs AppImages on NixOS
      firefox # Browser
      google-chrome # Browser

      # File Management
      p7zip # Zip Encryption
      rsync # Syncer - $ rsync -r dir1/ dir2/
      zip # Zip
      unzip # unzip

      # Work
      slack
      teams-for-linux

      # Other
      gcc
      cmake
      ripgrep

      # Other Packages Found @
      # - ./<host>/default.nix
      # - ../modules
    ];
  };
    # ++
    # (with unstable; [
    #   # Apps
    #   # firefox # Browser
    #   # image-roll # Image Viewer
    # ]);

  programs = {
      dconf.enable = true;
  };

  sound.enable = true;

  hardware ={
    pulseaudio.enable = false;
    bluetooth.enable = true;
  };
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

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    # package = pkgs.nixVersions.latest;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs.config.allowUnfree = true;

  system = {
    stateVersion = "24.05";
  };

  home-manager.users.${vars.user} = {
    home = {
      stateVersion = "24.05";
    };
    programs = {
      home-manager.enable = true;
    };
  };
}
