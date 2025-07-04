{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = lib.flatten [
    ./hardware-configuration.nix

    inputs.nixos-hardware.nixosModules.dell-precision-5560

    (map lib.custom.relativeToRoot [
      "hosts/common/core"
    ])
  ];

  # boot.extraModprobeConfig = ''
  #  options xe force_probe=9a60
  #  options i915 force_probe=!9a60
  # '';

  networking = {
    hostName = "ollie";
    networkmanager.enable = true;
  };

  boot.initrd.systemd.enable = true;
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
    }
  ];

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };

  services.printing.enable = true;

  security.rtkit.enable = true;

  users.users.kendle = {
    isNormalUser = true;
    description = "kendle";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs;};
    users = {
      "kendle" = import (lib.custom.relativeToRoot "home/kendle/ollie.nix");
    };
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  programs.git.enable = true;

  programs.yubikey-touch-detector.enable = true;

  programs.ssh.startAgent = false;
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.systemPackages = with pkgs; [
    mullvad-browser
    yubioath-flutter
    yubikey-manager
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  system.stateVersion = "25.05";
}
