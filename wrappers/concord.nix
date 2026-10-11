{inputs, ...}: {
  perSystem = {pkgs, ...}: let
    concord-tui = inputs.wrapper-modules.lib.wrapModule ({
      lib,
      wlib,
      pkgs,
      ...
    }: {
      imports = [wlib.modules.default];
      config = {
        package = lib.mkDefault pkgs.concord-tui;
        runtimePkgs = [pkgs.mpv];
      };
    });
  in {
    packages.concord-tui = concord-tui.wrap {inherit pkgs;};
  };
}
