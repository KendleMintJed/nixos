{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.stylix = {pkgs, ...}: {
    imports = [inputs.stylix.nixosModules.stylix];
    stylix = {
      enable = true;
      autoEnable = false;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      polarity = "dark";
      image = self.media.wallpaper;

      targets = {
        console.enable = true;
      };
    };
  };
}
