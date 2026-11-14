{...}: {
  flake.nixosModules.minecraft = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options.optionals.games.minecraft = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.optionals.games.autoEnable;
      };
    };

    config.environment.systemPackages = lib.mkIf config.optionals.games.minecraft.enable [pkgs.prismlauncher];
  };
}
