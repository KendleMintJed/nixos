{
  self,
  lib,
  ...
}: {
  flake.configs.noctalia.settings = {pkgs, ...}:
    lib.foldl lib.recursiveUpdate {} (with self.configs.noctalia; [
      (bar {inherit pkgs;})
      {
        theme = {
          source = "community";
          community_palette = "Catppuccin Mocha Blue";
        };

        wallpaper.default.path = self.media.wallpaper;

        shell = {
          avatar_path = self.media.avatar;
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
