{...}: {
  flake.configs.niri.look-and-feel = {pkgs, ...}: {
    prefer-no-csd = _: {};

    hotkey-overlay.skip-at-startup = _: {};

    layout = {
      gaps = 10;
      struts.top = 4;
      focus-ring.width = 2;
      border.off = _: {};
      background-color = "transparent";
    };

    gestures = {
      hot-corners = {
        off = _: {};
      };
    };

    input = {
      warp-mouse-to-focus = _: {};
      focus-follows-mouse = _: {max-scroll-amount = "0%";};
      mouse.accel-profile = "flat";
    };

    cursor.xcursor-theme = "${pkgs.catppuccin-cursors.mochaDark}/share/icons/catppuccin-mocha-dark-cursors";

    window-rules = [
      {
        geometry-corner-radius = 10;
        clip-to-geometry = true;
        open-maximized = true;
      }
      {
        matches = [
          {app-id = "^com\\.mitchellh\\.ghostty$";}
          {app-id = "dev.noctalia.Noctalia";}
        ];
        background-effect.blur = true;
        draw-border-with-background = false;
      }
      {
        matches = [
          {app-id = "dev.noctalia.Noctalia";}
          {title = "termfilechooser";}
        ];
        open-floating = true;
        default-column-width = {fixed = 1635;};
        default-window-height = {fixed = 920;};
      }
    ];

    layer-rules = [
      {
        matches = [{namespace = "^noctalia-wallpaper";}];
        place-within-backdrop = true;
      }
    ];
  };
}
