{
  inputs,
  lib,
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

  boot.initrd.luks.devices."luks-59afc219-8e13-41e1-b7ca-bcfba02c38a1".device = "/dev/disk/by-uuid/59afc219-8e13-41e1-b7ca-bcfba02c38a1";

  networking = {
    hostName = "ollie";
    networkmanager.enable = true;
  };

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=1h
    SuspendState=mem
  '';
  services.logind.lidSwitch = "suspend-then-hibernate";
  boot.initrd.systemd.enable = true;

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    # prime = {
    #   offload = {
    #     enable = true;
    #     enableOffloadCmd = true;
    #   };
    # };
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
