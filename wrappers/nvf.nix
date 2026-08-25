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
    packages.neovim =
      (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;

        modules = [
          ({...}: {
            config = self.lib.mkNvfConfig {inherit lib;};
          })
        ];
      }).neovim;
  };
}
