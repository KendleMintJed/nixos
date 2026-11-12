{lib, ...}: {
  flake.options = {
    configs = lib.mkOption {
      type = with lib.types; attrsOf anything;
    };
  };
}
