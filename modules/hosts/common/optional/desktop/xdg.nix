{...}: {
  flake.nixosModules.xdg = {
    lib,
    config,
    pkgs,
    ...
  }: {
    options.optionals.desktop.xdg = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.optionals.desktop.enable;
      };
    };

    config = lib.mkIf config.optionals.desktop.xdg.enable {
      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-termfilechooser
        ];

        config = {
          common."org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
          niri."org.freedesktop.impl.portal.FileChooser" = lib.mkIf config.optionals.desktop.niri.enable "termfilechooser";
        };
      };
    };
  };
}
