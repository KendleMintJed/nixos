{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.nvf = {
    system,
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

    environment.systemPackages = with pkgs; [
      self.packages.${system}.yazi
      tree-sitter
      ripgrep
      imagemagick
      fd
    ];
  };
}
