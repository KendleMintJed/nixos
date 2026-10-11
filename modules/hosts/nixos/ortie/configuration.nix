{self, ...}: {
  flake.nixosModules.ortieConfig = {config, ...}: {
    imports = with self.nixosModules; [
      ortieHardware
      core

      desktop
      must
      roblox
      logitech
      osu
    ];

    boot.loader.grub.useOSProber = true;

    networking = {
      hostName = "ortie";
      networkmanager.enable = true;
    };

    hardware.graphics.enable = true;
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    };

    services.printing.enable = true;

    security.rtkit.enable = true;

    programs.gamemode.enable = true;

    programs.yubikey-touch-detector.enable = true;

    programs.ssh.startAgent = false;
    services.pcscd.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
