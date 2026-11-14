{self, ...}: {
  flake.nixosModules.sddm = {
    system,
    pkgs,
    lib,
    config,
    ...
  }: {
    options.optionals.desktop.sddm = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.optionals.desktop.enable;
      };
    };

    config = lib.mkIf config.optionals.desktop.sddm.enable {
      environment.systemPackages = [pkgs.catppuccin-cursors.mochaDark];

      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        theme = "${self.packages.${system}.catppuccin-sddm}/share/sddm/themes/catppuccin-mocha-blue";
        autoNumlock = true;
        settings.Theme.CursorTheme = "catppuccin-mocha-dark-cursors";
      };
    };
  };
}
