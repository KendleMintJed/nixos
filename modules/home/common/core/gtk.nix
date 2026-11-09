{self, ...}: {
  flake.homeModules.gtk = {
    pkgs,
    system,
    config,
    ...
  }: let
    themeName = "catppuccin-mocha-blue-standard";
    catppuccin-gtk = self.packages.${system}.catppuccin-gtk;
  in {
    gtk = {
      enable = true;
      colorScheme = "dark";
      theme = {
        name = themeName;
        package = catppuccin-gtk;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders;
      };
      cursorTheme = {
        name = "catppuccin-mocha-dark-cursors";
        package = pkgs.catppuccin-cursors.mochaDark;
      };

      gtk4.theme = config.gtk.theme;
    };
  };
}
