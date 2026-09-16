{self, ...}: {
  flake.configs.noctalia.settings = args @ {
    pkgs,
    lib,
    ...
  }:
    lib.foldl lib.recursiveUpdate {} (with self.configs.noctalia; [
      (bar args)
      {
        theme = {
          source = "community";
          community_palette = "Catppuccin Mocha Blue";
        };

        wallpaper.default.path = self.media.wallpaper;

        shell = {
          avatar_path = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          settings_window_translucent = true;

          screenshot.filename_pattern = "snapshot_%Y%m%d_%H%M%S";

          # security
          external_ip_enabled = true;

          session.power.suspend = "systemctl suspend-then-hibernate";
        };

        control_center = {
          # Layout
          width = 900;

          # Navigation
          sidebar = "full";
          sidebar_section = "full";
        };

        nightlight.enabled = true;
      }
    ]);
}
