{self, ...}: {
  flake.nixosModules.optionals = {...}: {
    imports = with self.nixosModules; [
      desktop
      games
      hardware
      media

      grub
    ];
  };
}
