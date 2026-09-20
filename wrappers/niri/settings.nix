{
  self,
  lib,
  ...
}: {
  flake.configs.niri.settings = {
    pkgs,
    self',
    ...
  }:
    lib.foldl lib.recursiveUpdate {} (map (x: x {inherit pkgs self';})
      (with self.configs.niri; [
        look-and-feel
        keybinds
        utility
        ({...}: {
          debug.honor-xdg-activation-with-invalid-serial = _: {};
        })
      ]));
}
