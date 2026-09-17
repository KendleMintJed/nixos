{
  self,
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.neovim =
      (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;

        modules = [
          ({...}: {
            config = self.lib.mkNvfConfig {inherit pkgs;};
          })
        ];
      }).neovim;
  };
}
