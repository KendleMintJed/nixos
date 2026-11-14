{self, ...}: {
  flake.homeModules.gtk = {
    pkgs,
    system,
    lib,
    config,
    ...
  }: {
    options.optionals.desktop.gtk = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.optionals.desktop.autoEnable;
      };
    };

    config = lib.mkIf config.optionals.desktop.gtk.enable {
      gtk = let
        themeName = "catppuccin-mocha-blue-standard";
        catppuccin-gtk = self.packages.${system}.catppuccin-gtk;
      in {
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
  };
}
