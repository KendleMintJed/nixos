{...}: {
  flake.nixosModules.inputRemapper = {
    lib,
    config,
    ...
  }: {
    options.optionals.inputRemapper = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };

    config.services.input-remapper = lib.mkIf config.optionals.inputRemapper.enable {
      enable = true;
      enableUdevRules = true;
    };
  };
}
