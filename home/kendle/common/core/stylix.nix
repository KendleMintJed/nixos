{
  lib,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = lib.custom.relativeToRoot "media/wallpaper.png";
    targets = {
      librewolf = {
        profileNames = ["default"];
        colorTheme.enable = true;
      };

      nvf.enable = false;
      nixcord.enable = false;
    };
  };
}
