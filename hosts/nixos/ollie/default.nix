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
      "hosts/common/optional/grub.nix"
      "hosts/common/optional/sddm.nix"
      "hosts/common/optional/audio.nix"
      "hosts/common/optional/hyprland.nix"
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
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=1h
    SuspendState=mem
  '';
  services.logind.lidSwitch = "suspend-then-hibernate";

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
