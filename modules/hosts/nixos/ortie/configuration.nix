{self, ...}: {
  flake.nixosModules.ortieConfig = {config, ...}: {
    imports = with self.nixosModules; [
      ortieHardware
      core

      desktop
      inputRemapper
      must
      roblox
      logitech
      affinity
      osu
      minecraft
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
