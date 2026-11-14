{self, ...}: {
  flake.nixosModules.games = {lib, ...}: {
    options.optionals.games = {
      autoEnable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };

    imports = with self.nixosModules; [
      minecraft
      osu
      roblox
      steam
    ];
  };
}
