{...}: {
  flake.configs.noctalia.bar = {pkgs, ...}: {
    bar.default = {
      # layout
      thickness = 46;
      font_scale = 1.15;
      margin_ends = 8;
      margin_edge = 8;

      # shape
      radius = 20;

      # capsules
      capsule = true;
      capsule_group = [
        {
          id = "g1";
          members = [
            "cpu"
            "temp"
            "ram"
            "network_tx"
            "network_rx"
            "sysmon"
          ];
        }
      ];

      # widget list
      start = [
        "control-center"
        "workspaces"
        "active_window"
        "tray"
      ];
      center = ["group:g1"];
      end = [
        "brightness"
        "volume"
        "battery"
        "network"
        "bluetooth"
        "weather"
        "clock"
        "notifications"
      ];
    };

    widget = let
      sysmonWidgetConfig = {
        visualization = "none";
        scale = 1.2;
        font_scale = 0.83;
        icon_color = "primary";
      };
    in {
      # start
      control-center = {
        # widget
        custom_image = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";
        custom_image_colorize = true;

        # presentation
        scale = 1.75;
        color = "primary";
        capsule_padding = 2;
      };
      workspaces = {
        # pill style
        active_pill_size = 2.0;

        # presentation
        scale = 1.3;
        font_scale = 0.87;
        font_weight = 600;
        capsule_padding = 5;
      };
      active_window = {
        # widget
        max_length = 200;
        icon_size = 24;
        title_scroll = "on_hover";
      };
      tray = {
        # presentation
        scale = 1.4;
        capsule_padding = 5;
      };

      # center
      cpu = sysmonWidgetConfig;
      temp = sysmonWidgetConfig;
      ram = sysmonWidgetConfig;
      network_tx = sysmonWidgetConfig;
      network_rx = sysmonWidgetConfig;
      sysmon =
        sysmonWidgetConfig
        // {
          stat = "disk_used_pct";
        };

      # end
      bluetooth = {
        # widget
        scale = 1.25;
      };
      weather = {
        # widget
        show_condition = false;
      };
      clock = {
        # widget
        format = "%a %d %b %H:%M:%S";

        # presentation
        capsule_padding = 8;
      };
      notifications = {
        # presentation
        scale = 1.25;
      };
    };
  };
}
