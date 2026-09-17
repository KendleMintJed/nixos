{lib, ...}: {
  flake = {
    options = {
      media = lib.mkOption {
        type = with lib.types; attrsOf anything;
      };
    };

    media = {
      wallpaper = ./wallpaper.svg;
      avatar = ./avatar.jpg;
    };
  };
}
