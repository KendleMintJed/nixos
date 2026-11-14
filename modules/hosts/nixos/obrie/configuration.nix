{self, ...}: {
  flake.nixosModules.obrieConfig = {...}: {
    imports = with self.nixosModules; [
      obrieHardware
      core
      optionals
    ];

    optionals = {
      laptop.enable = true;
      media.must.enable = true;
      games.steam.enable = true;
    };
  };
}
