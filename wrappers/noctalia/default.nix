{
  self,
  inputs,
  ...
}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.noctalia = inputs.noctalia-wrapper.wrappers.noctalia.wrap {
      inherit pkgs;
      settings = self.configs.noctalia.settings {inherit pkgs;};
      colors =
        lib.recursiveUpdate
        (lib.importJSON "${inputs.noctalia-palettes}/Catppuccin Mocha Blue/Catppuccin Mocha Blue.json")
        {
          dark.mTertiary = self.media.catppuccinMocha.green;
        };
    };
  };
}
