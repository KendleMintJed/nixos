{...}: {
  flake.configs.niri.look-and-feel = {pkgs, ...}: {
    prefer-no-csd = _: {};

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
      focus-follows-mouse = _: {};
    };

    cursor.xcursor-theme = "${pkgs.catppuccin-cursors.mochaDark}/share/icons/catppuccin-mocha-dark-cursors";

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
  };
}
