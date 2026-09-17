{
  self,
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.noctalia = inputs.noctalia-wrapper.wrappers.noctalia.wrap {
      inherit pkgs;
      settings = self.configs.noctalia.settings {inherit pkgs;};
    };
  };
}
