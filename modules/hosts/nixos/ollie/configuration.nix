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

      laptop
      desktop
      must
    ];

    # boot.extraModprobeConfig = ''
    #  options xe force_probe=9a60
    #  options i915 force_probe=!9a60
    # '';

    swapDevices = [
      {
        device = "/var/lib/swapfile";
        size = 32 * 1024;
      }
    ];

    nixpkgs.config.allowUnfree = true;
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
  };
}
