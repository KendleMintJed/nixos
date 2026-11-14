{...}: {
  flake.nixosModules.osu = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options.optionals.games.osu = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.optionals.games.autoEnable;
      };
    };

    config.environment.systemPackages = lib.mkIf config.optionals.games.osu.enable [pkgs.osu-lazer-bin];
  };
}
