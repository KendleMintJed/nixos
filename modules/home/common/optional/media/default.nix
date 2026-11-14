{self, ...}: {
  flake.homeModules.media = {lib, ...}: {
    options.optionals.media = {
      autoEnable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };

    imports = with self.homeModules; [
      firefox
      nixcord
    ];
  };
}
