{self, ...}: {
  flake.nixosModules.niri = {
    system,
    lib,
    config,
    ...
  }: {
    options.optionals.desktop.niri = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.optionals.desktop.enable;
      };
    };

    config = lib.mkIf config.optionals.desktop.niri.enable {
      services.logind.settings.Login.HandlePowerKey = "ignore";

      programs = with self.packages.${system}; {
        niri = {
          enable = true;
          package = niri;
        };

        noctalia = {
          enable = true;
          package = noctalia;
        };

        xwayland.enable = true;
      };
    };
  };
}
