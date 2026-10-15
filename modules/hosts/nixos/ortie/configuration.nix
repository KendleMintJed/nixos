{self, ...}: {
  flake.nixosModules.ortieConfig = {config, ...}: {
    imports = with self.nixosModules; [
      ortieHardware
      core

      desktop
      must
      roblox
      logitech
      affinity
      osu
    ];

    boot.loader.grub.useOSProber = true;

    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    };
  };
}
