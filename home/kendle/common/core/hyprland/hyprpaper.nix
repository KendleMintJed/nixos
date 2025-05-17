{
  lib,
  pkgs,
  ...
}: let
  wallpaper = pkgs.runCommand "wallpaper" {} ''
    mkdir -p $out
    cp ${lib.custom.relativeToRoot "media/wallpaper.png"} $out/wallpaper.png
  '';
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = ["${wallpaper}/wallpaper.png"];
      wallpaper = [",${wallpaper}/wallpaper.png"];
    };
  };
}
