{inputs, ...}: {
  flake.nixosModules.roblox = {
    lib,
    config,
    ...
  }: {
    options.optionals.games.roblox = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.optionals.games.autoEnable;
      };
    };

    imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

    config = lib.mkIf config.optionals.games.roblox.enable {
      services.flatpak = {
        enable = true;
        packages = ["org.vinegarhq.Sober"];
      };
    };
  };
}
