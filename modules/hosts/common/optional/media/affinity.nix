{inputs, ...}: {
  flake.nixosModules.affinity = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options.optionals.media.affinity = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.optionals.media.autoEnable;
      };
    };

    config = lib.mkIf config.optionals.media.affinity.enable {
      nixpkgs.overlays = [inputs.affinity.overlays.default];
      environment.systemPackages = [pkgs.affinity-v3];
    };
  };
}
