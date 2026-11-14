{inputs, ...}: {
  flake.nixosModules.septabee = {
    lib,
    config,
    ...
  }: {
    options.optionals.media.septabee = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.optionals.media.autoEnable;
      };
    };

    imports = [inputs.septabee.nixosModules.default];

    config = lib.mkIf config.optionals.media.septabee.enable {
      programs.septabee.enable = true;
    };
  };
}
