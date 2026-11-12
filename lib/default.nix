{lib, ...}: {
  flake.options = {
    lib = lib.mkOption {
      type = with lib.types; attrsOf anything;
    };
  };
}
