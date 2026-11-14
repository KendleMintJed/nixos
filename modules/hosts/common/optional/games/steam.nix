{...}: {
  flake.nixosModules.steam = {
    lib,
    config,
    ...
  }: {
    options.optionals.games.steam = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.optionals.games.autoEnable;
      };
    };

    config.programs.steam = lib.mkIf config.optionals.games.steam.enable {
      enable = true;
      gamescopeSession.enable = true;
    };
  };
}
