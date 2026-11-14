{self, ...}: {
  flake.nixosModules.optionals = {...}: {
    imports = with self.nixosModules; [
      desktop
      games
      media

      grub
      inputRemapper
      laptop
      logitech
      nvidia
    ];
  };
}
