{self, ...}: {
  flake.nixosModules.niri = {system, ...}: {
    programs.niri = {
      enable = true;
      package = self.packages.${system}.niri;
    };
  };
}
