{self, ...}: {
  flake.nixosModules.obrieConfig = {...}: {
    imports = with self.nixosModules; [
      obrieHardware
      core

      laptop
      desktop

      must
    ];
  };
}
