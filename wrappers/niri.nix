{inputs, ...}: {
  perSystem = {
    self',
    pkgs,
    lib,
    ...
  }: {
    packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;

      settings = let
        noctaliaExe = lib.getExe self'.packages.noctalia-shell;
      in {
        spawn-at-startup = [
          noctaliaExe
        ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        prefer-no-csd = _: {};

        layout = {
          gaps = 10;
          struts.top = 4;
          focus-ring.width = 2;
          border.off = _: {};
        };

        window-rules = [
          {
            geometry-corner-radius = 10;
            clip-to-geometry = true;
          }
          {
            matches = [{app-id = "^com\\.mitchellh\\.ghostty$";}];
            background-effect.blur = true;
            draw-border-with-background = false;
          }
          {
            matches = [
              {app-id = "^librewolf$";}
              {app-id = "^discord$";}
            ];
            open-maximized = true;
          }
        ];

        input = {
          keyboard.xkb.layout = "gb";
          touchpad = {
            tap = _: {};
            natural-scroll = _: {};
          };
          warp-mouse-to-focus = _: {};
          focus-follows-mouse = _: {};
        };

        binds = {
          "Mod+Return".spawn-sh = lib.getExe self'.packages.ghostty;
          "Mod+R".spawn-sh = "${noctaliaExe} ipc call launcher toggle";
          "Mod+Q".close-window = _: {};
          "Mod+H".focus-column-left = _: {};
          "Mod+L".focus-column-right = _: {};
          "Mod+Shift+S".screenshot = _: {};
          "Mod+F".maximize-column = _: {};
          "Mod+Shift+F".fullscreen-window = _: {};
          "Mod+Tab".toggle-overview = _: {};
        };

        gestures = {
          hot-corners = {
            off = _: {};
          };
        };
      };
    };
  };
}
