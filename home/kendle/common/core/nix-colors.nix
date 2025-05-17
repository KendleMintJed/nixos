{inputs, ...}: let
  nix-colors = inputs.nix-colors;
in {
  imports = [nix-colors.homeManagerModules.default];
  colorScheme = nix-colors.colorSchemes.catppuccin-mocha;
}
