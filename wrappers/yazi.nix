{inputs, ...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.yazi = inputs.wrapper-modules.wrappers.yazi.wrap {
      inherit pkgs;
      settings.theme =
        lib.removeAttrs
        (lib.importTOML "${inputs.catppuccin-yazi}/themes/mocha/catppuccin-mocha-blue.toml")
        ["app"];
    };
  };
}
