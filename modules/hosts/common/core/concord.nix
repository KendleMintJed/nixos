{self, ...}: {
  flake.nixosModules.concord = {system, ...}: {
    environment.systemPackages = [
      self.packages.${system}.concord-tui
    ];
  };
}
