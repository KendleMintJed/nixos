{lib, ...}: {
  flake.configs.niri.utility = {
    pkgs,
    self',
    ...
  }: {
    spawn-at-startup = [
      (lib.getExe self'.packages.noctalia)
    ];

    xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

    screenshot-path = "~/Pictures/Screenshots/snapshot_%Y-%m-%d_%H-%M-%S.png";

    recent-windows.off = _: {};
  };
}
