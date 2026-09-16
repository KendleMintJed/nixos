{self, ...}: {
  flake.nixosModules.niri = {system, ...}: {
    programs.niri = {
      enable = true;
      package = self.packages.${system}.niri;
    };

    programs.noctalia = {
      enable = true;
      package = self.packages.${system}.noctalia;
    };

    programs.xwayland.enable = true;
  };
}
