{
  self,
  lib,
  ...
}: {
  flake.configs.noctalia.settings = {pkgs, ...}:
    lib.foldl lib.recursiveUpdate {} (map (x: x {inherit pkgs;})
      (with self.configs.noctalia; [
        bar
        lock-screen
        ({...}: {
          theme = {
            source = "custom";
            community_palette = "custom";
          };

          wallpaper.default.path = self.media.wallpaper;

          shell = {
            setup_wizard_enabled = false;

            avatar_path = self.media.avatar;
            settings_window_translucent = true;

            screenshot.filename_pattern = "snapshot_%Y%m%d_%H%M%S";

            # security
            external_ip_enabled = true;

            session = {
              power.suspend = "systemctl suspend-then-hibernate";
              actions = [
                {
                  action = "lock";
                  countdown_seconds = 0.0;
                  enabled = true;
                  shortcut = "1";
                  variant = "default";
                }
                {
                  action = "logout";
                  countdown_seconds = 0.0;
                  enabled = true;
                  shortcut = "2";
                  variant = "default";
                }
                {
                  action = "command";
                  command = "systemctl hibernate";
                  countdown_seconds = 0.0;
                  enabled = true;
                  glyph = "hibernate";
                  label = "Hibernate";
                  shortcut = "3";
                  variant = "default";
                }
                {
                  action = "reboot";
                  countdown_seconds = 0.0;
                  enabled = true;
                  shortcut = "4";
                  variant = "default";
                }
                {
                  action = "shutdown";
                  countdown_seconds = 0.0;
                  enabled = true;
                  shortcut = "5";
                  variant = "destructive";
                }
              ];
            };

            panel = {
              session_placement = "floating";
              session_position = "center";
            };
          };

          idle.behavior = {
            behavior_order = ["lock" "lock-and-suspend"];
            lock = {
              enabled = true;
              timeout = 300.0;
            };
            lock-and-suspend = {
              enabled = true;
              timeout = 360.0;
            };
          };

          control_center = {
            # Layout
            width = 900;

            # Navigation
            sidebar = "full";
            sidebar_section = "full";
          };

          nightlight.enabled = true;
        })
      ]));
}
