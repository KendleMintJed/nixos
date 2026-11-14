{self, ...}: {
  flake.nixosModules.hardware = {...}: {
    imports = with self.nixosModules; [
      inputRemapper
      laptop
      logitech
      nvidia
    ];
  };
}
