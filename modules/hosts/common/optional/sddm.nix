{self, ...}: {
  flake.nixosModules.sddm = {
    system,
    pkgs,
    ...
  }: {
    environment.systemPackages = [pkgs.catppuccin-cursors.mochaDark];

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "${self.packages.${system}.catppuccin-sddm}/share/sddm/themes/catppuccin-mocha-blue";
      autoNumlock = true;
      settings.Theme.CursorTheme = "catppuccin-mocha-dark-cursors";
    };
  };
}
