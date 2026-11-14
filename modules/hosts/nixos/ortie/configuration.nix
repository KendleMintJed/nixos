{self, ...}: {
  flake.nixosModules.ortieConfig = {config, ...}: {
    imports = with self.nixosModules; [
      ortieHardware
      core
      optionals
    ];

    optionals = {
      grub.useOSProber = true;
      nvidia = {
        enable = true;
        package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
      };

      logitech.enable = true;
      inputRemapper.enable = true;

      media.autoEnable = true;
      games.autoEnable = true;
    };
  };
}
