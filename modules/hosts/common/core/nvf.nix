{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.nvf = {
    pkgs,
    host,
    ...
  }: {
    imports = [inputs.nvf.nixosModules.default];

    programs.nvf = {
      enable = true;
      defaultEditor = true;
      enableManpages = true;
      settings = self.lib.mkNvfConfig {inherit pkgs host;};
    };
  };
}
