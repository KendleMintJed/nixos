{
  lib,
  pkgs,
  ...
}: {
  imports = lib.flatten [
    ./hardware-configuration.nix

    (map lib.custom.relativeToRoot [
      "hosts/common/core"
      "hosts/common/optional/grub.nix"
      "hosts/common/optional/sddm.nix"
      "hosts/common/optional/audio.nix"
      "hosts/common/optional/hyprland.nix"
    ])
  ];

  boot.loader.grub.useOSProber = true;

  networking = {
    hostName = "ortie";
    networkmanager.enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
  };

  services.printing.enable = true;

  security.rtkit.enable = true;

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
}
