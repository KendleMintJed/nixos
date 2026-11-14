{self, ...}: {
  flake.homeModules.optionals = {...}: {
    imports = with self.homeModules; [
      desktop
      media
    ];
  };
}
