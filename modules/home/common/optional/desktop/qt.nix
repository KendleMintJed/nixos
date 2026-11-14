{...}: {
  flake.homeModules.qt = {
    lib,
    config,
    pkgs,
    ...
  }: {
    options.optionals.desktop.qt = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.optionals.desktop.autoEnable;
      };
    };

    config = lib.mkIf config.optionals.desktop.qt.enable {
      qt = let
        variant = "mocha";
        accent = "blue";
        themeName = "catppuccin-${variant}-${accent}";
        qtctSettings.Appearance = {
          custom_palette = true;
          color_scheme_path = "${pkgs.catppuccin-qt5ct}/${themeName}.conf";
          style = "kvantum";
        };
      in {
        enable = true;
        platformTheme.name = "qtct";
        style.name = "kvantum";
        kvantum = {
          enable = true;
          themes = with pkgs; [
            (catppuccin-kvantum.override {
              inherit variant accent;
            })
          ];
          settings.General.theme = themeName;
        };
        qt5ctSettings = qtctSettings;
        qt6ctSettings = qtctSettings;
      };
    };
  };
}
