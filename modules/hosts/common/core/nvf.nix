{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.nvf = args @ {...}: {
    imports = [inputs.nvf.nixosModules.default];

    programs.nvf = {
      enable = true;
      defaultEditor = true;
      enableManpages = true;
      settings = self.lib.mkNvfConfig args;
    };
  };
}
