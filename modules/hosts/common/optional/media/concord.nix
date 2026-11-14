{self, ...}: {
  flake.nixosModules.concord = {
    lib,
    config,
    system,
    ...
  }: {
    options.optionals.media.concord = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.optionals.media.autoEnable;
      };
    };

    config.environment.systemPackages = lib.mkIf config.optionals.media.concord.enable [
      self.packages.${system}.concord-tui
    ];
  };
}
