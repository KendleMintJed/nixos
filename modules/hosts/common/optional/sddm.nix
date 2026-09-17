{self, ...}: {
  flake.nixosModules.sddm = {system, ...}: {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "${self.packages.${system}.catppuccin-sddm}/share/sddm/themes/catppuccin-mocha-blue";
    };
  };
}
