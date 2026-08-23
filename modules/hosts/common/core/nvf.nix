{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.nvf = {
    lib,
    pkgs,
    host,
    ...
  }: {
    imports = [inputs.nvf.nixosModules.default];

    programs.nvf = {
      enable = true;
      defaultEditor = true;
      enableManpages = true;
      settings = self.lib.mkNvfConfig {inherit lib host;};
    };

    environment = {
      systemPackages = with pkgs; [
        tree-sitter
        ripgrep
        imagemagick
        fd
      ];
    };
  };
}
