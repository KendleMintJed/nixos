{pkgs, ...}: let
  theme = "Adwaita-Dark";
in {
  qt = {
    enable = true;
    platformTheme.name = "gtk";

    style.name = theme;
  };

  home.sessionVariables = {
    QT_STYLE_OVERRIDE = theme;
    QT_QUICK_CONTROLS_STYLE = theme;
  };
}
