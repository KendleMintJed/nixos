{
  self,
  inputs,
  ...
}: {
  perSystem = {
    self',
    pkgs,
    ...
  }: {
    packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;

      settings = self.configs.niri.settings {inherit pkgs self';};
    };
  };
}
