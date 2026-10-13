{...}: {
  flake.homeModules.gtk = {pkgs, ...}: let
    flavor = "mocha";
    themeName = "catppuccin-${flavor}-blue-standard";
    catppuccin-gtk = pkgs.catppuccin-gtk.override {
      variant = flavor;
    };
  in {
    gtk = {
      theme = {
        name = themeName;
        package = catppuccin-gtk;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders;
      };
    };
    xdg.configFile = let
      gtk4Dir = "${catppuccin-gtk}/share/themes/${themeName}/gtk-4.0";
    in {
      "gtk-4.0/assets".source = "${gtk4Dir}/assets";
      "gtk-4.0/gtk.css".source = "${gtk4Dir}/gtk.css";
      "gtk-4.0/gtk-dark.css".source = "${gtk4Dir}/gtk-dark.css";
    };
  };
}
