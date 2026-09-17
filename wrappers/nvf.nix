{
  self,
  inputs,
  ...
}: {
  perSystem = args @ {pkgs, ...}: {
    packages.neovim =
      (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;

        modules = [
          ({...}: {
            config = self.lib.mkNvfConfig args;
          })
        ];
      }).neovim;
  };
}
