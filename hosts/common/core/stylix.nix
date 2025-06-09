{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.stylix.nixosModules.stylix];
  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    targets = {
      gtk.enable = true;
      #qt.enable = true;
    };
  };
}
