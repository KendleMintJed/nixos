{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.ollieConfig = {...}: {
    imports = with self.nixosModules; [
      inputs.nixos-hardware.nixosModules.dell-precision-5560

      ollieHardware
      core
      optionals
    ];

    optionals = {
      grub.useOSProber = true;
      laptop.enable = true;
      nvidia.enable = true;

      media.must.enable = true;

      games.steam.enable = true;
    };

    swapDevices = [
      {
        device = "/var/lib/swapfile";
        size = 32 * 1024;
      }
    ];
  };
}
