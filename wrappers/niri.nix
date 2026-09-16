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
        noctaliaExe = lib.getExe self'.packages.noctalia;
      in {
        spawn-at-startup = [
          noctaliaExe
        ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        prefer-no-csd = _: {};

        debug.honor-xdg-activation-with-invalid-serial = _: {};

        layout = {
          gaps = 10;
          struts.top = 4;
          focus-ring.width = 2;
          border.off = _: {};
          background-color = "transparent";
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
          {
            matches = [{app-id = "dev.noctalia.Noctalia";}];
            open-floating = true;
            default-column-width = {fixed = 1080;};
            default-window-height = {fixed = 920;};
            background-effect.blur = true;
            draw-border-with-background = false;
          }
        ];

        layer-rules = [
          {
            matches = [{namespace = "^noctalia-wallpaper";}];
            place-within-backdrop = true;
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
          "Mod+R".spawn-sh = "${noctaliaExe} msg panel-toggle launcher";
          "Mod+Q".close-window = _: {};
          "Mod+H".focus-column-left = _: {};
          "Mod+L".focus-column-right = _: {};
          "Mod+J".focus-workspace-down = _: {};
          "Mod+K".focus-workspace-up = _: {};
          "Mod+Shift+H".move-column-left = _: {};
          "Mod+Shift+L".move-column-right = _: {};
          "Mod+Shift+J".move-workspace-down = _: {};
          "Mod+Shift+K".move-workspace-up = _: {};
          "Mod+Shift+S".screenshot = _: {};
          "Mod+F".maximize-column = _: {};
          "Mod+Shift+F".fullscreen-window = _: {};
          "Mod+Tab".toggle-overview = _: {};
          # Audio & Brightness
          XF86AudioRaiseVolume.spawn-sh = "${noctaliaExe} msg volume-up";
          XF86AudioLowerVolume.spawn-sh = "${noctaliaExe} msg volume-down";
          XF86AudioMute.spawn-sh = "${noctaliaExe} msg volume-mute";
          XF86MonBrightnessUp.spawn-sh = "${noctaliaExe} msg brightness-up";
          XF86MonBrightnessDown.spawn-sh = "${noctaliaExe} msg brightness-down";
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
