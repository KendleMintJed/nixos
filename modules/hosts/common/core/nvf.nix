{self, ...}: {
  flake.nixosModules.nvf = {
    lib,
    pkgs,
    ...
  }: let
    myNeovim = self.packages.${pkgs.stdenv.hostPlatform.system}.neovim;
  in {
    environment = {
      systemPackages = with pkgs; [
        myNeovim
        tree-sitter
        ripgrep
      ];
      sessionVariables = {
        EDITOR = lib.getExe myNeovim;
        VISUAL = lib.getExe myNeovim;
      };
    };
  };
}
