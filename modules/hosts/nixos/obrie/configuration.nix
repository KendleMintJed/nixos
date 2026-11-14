{self, ...}: {
  flake.nixosModules.obrieConfig = {...}: {
    imports = with self.nixosModules; [
      obrieHardware
      core
      optionals
    ];

    optionals = {
      hardware.laptop.enable = true;
      media.concord.enable = true;
      games.steam.enable = true;
    };
  };
}
