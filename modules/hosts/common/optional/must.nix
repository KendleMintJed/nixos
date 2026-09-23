{self, ...}: {
  flake.nixosModules.must = {system, ...}: {
    environment.systemPackages = [self.packages.${system}.must];
  };
}
