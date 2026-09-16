{self, ...}: {
  flake.nixosModules.sddm = {pkgs, ...}: {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "${(pkgs.catppuccin-sddm.override {
        flavor = "mocha";
        accent = "blue";
        loginBackground = true;
        background = self.media.wallpaper;
      })}/share/sddm/themes/catppuccin-mocha-blue";
    };
  };
}
