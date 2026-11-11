{self, ...}: {
  flake.nixosModules.concord = {system, ...}: {
    # disabled due to build error
    /*
    environment.systemPackages = [
      self.packages.${system}.concord-tui
    ];
    */
  };
}
