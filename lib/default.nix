{lib, ...}: {
  flake.options = {
    lib = lib.mkOption {
      type = with lib.types; attrsOf anything;
    };
    configs = lib.mkOption {
      type = with lib.types; attrsOf anything;
    };
  };
}
