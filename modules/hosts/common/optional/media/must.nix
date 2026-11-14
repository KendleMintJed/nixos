{self, ...}: {
  flake.nixosModules.must = {
    system,
    lib,
    config,
    ...
  }: {
    options.optionals.media.must = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.optionals.media.autoEnable;
      };
    };

    config.environment.systemPackages = lib.mkIf config.optionals.media.must.enable [self.packages.${system}.must];
  };
}
