{self, ...}: {
  flake.homeModules.desktop = {lib, ...}: {
    options.optionals.desktop = {
      autoEnable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };

    imports = with self.homeModules; [
      gtk
      qt
    ];
  };
}
