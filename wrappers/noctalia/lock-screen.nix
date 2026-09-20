{...}: {
  flake.configs.noctalia.lock-screen = {...}: {
    lockscreen = {
      blur_intensity = 0.0;
      tint_intensity = 0.0;
    };
    lockscreen_widgets = {
      enabled = true;
      schema_version = 2;
      widget_order = [
        "lockscreen-login-box@winit"
        "lockscreen-login-box@eDP-1"
        "lockscreen-widget-0000000000000001"
        "lockscreen-widget-0000000000000003"
        "lockscreen-widget-0000000000000004"
        "lockscreen-widget-0000000000000005"
        "lockscreen-widget-0000000000000006"
        "lockscreen-widget-0000000000000007"
        "lockscreen-widget-0000000000000008"
      ];

      widget = {
        "lockscreen-login-box@eDP-1" = {
          box_height = 70.0;
          box_width = 400.0;
          cx = 960.0;
          cy = 600.0;
          output = "eDP-1";
          placement_height = 1200.0;
          placement_width = 1920.0;
          rotation = 0.0;
          type = "login_box";

          settings = {
            background_color = "surface";
            background_opacity = 0.88;
            background_radius = 12.0;
            center_password_text = true;
            input_opacity = 1.0;
            input_radius = 6.0;
            layout = "compact";
            show_caps_lock = true;
            show_keyboard_layout = true;
            show_login_button = false;
            show_media = false;
            show_session_buttons = true;
            show_unlock_hint = false;
            show_weather = false;
          };
        };
        "lockscreen-login-box@winit" = {
          box_height = 196.0;
          box_width = 810.0;
          cx = 472.99990844726562;
          cy = 940.0;
          output = "winit";
          placement_height = 1122.0;
          placement_width = 945.0;
          rotation = 0.0;
          type = "login_box";

          settings = {
            background_color = "surface_variant";
            background_opacity = 0.88;
            background_radius = 12.0;
            center_password_text = false;
            input_opacity = 1.0;
            input_radius = 6.0;
            layout = "regular";
            show_caps_lock = true;
            show_keyboard_layout = true;
            show_login_button = true;
            show_media = true;
            show_session_buttons = true;
            show_unlock_hint = true;
            show_weather = true;
          };
        };

        lockscreen-widget-0000000000000001 = {
          box_height = 144.0;
          box_width = 304.0;
          cx = 960.0;
          cy = 170.0;
          output = "eDP-1";
          placement_height = 1200.0;
          placement_width = 1920.0;
          rotation = 0.0;
          type = "clock";

          settings = {
            background = false;
            center_text = true;
            clock_style = "digital";
            font_family = "monospace";
          };
        };

        lockscreen-widget-0000000000000003 = {
          box_height = 0.0;
          box_width = 0.0;
          cx = 189.0;
          cy = 232.0;
          output = "eDP-1";
          placement_height = 1200.0;
          placement_width = 1920.0;
          rotation = 0.0;
          type = "audio_visualizer";

          settings = {
            background = false;
            bands = 128;
            centered = true;
            color_1 = "on_surface";
            color_2 = "on_surface";
            mirrored = false;
            reversed = false;
            show_when_idle = true;
          };
        };

        lockscreen-widget-0000000000000004 = {
          box_height = 0.0;
          box_width = 0.0;
          cx = 189.0;
          cy = 98.0;
          output = "eDP-1";
          placement_height = 1200.0;
          placement_width = 1920.0;
          rotation = 0.0;
          type = "media_player";

          settings = {
            layout = "horizontal";
            shadow = true;
          };
        };

        lockscreen-widget-0000000000000005 = {
          box_height = 0.0;
          box_width = 0.0;
          cx = 1824.0;
          cy = 123.0;
          output = "eDP-1";
          placement_height = 1200.0;
          placement_width = 1920.0;
          rotation = 0.0;
          type = "weather";

          settings = {
            background = false;
            forecast_days = 6;
            show_forecast = true;
          };
        };

        lockscreen-widget-0000000000000006 = {
          box_height = 48.0;
          box_width = 144.0;
          cx = 875.0;
          cy = 672.0;
          output = "eDP-1";
          placement_height = 1200.0;
          placement_width = 1920.0;
          rotation = 0.0;
          type = "button";

          settings = {
            background = true;
            command = "systemctl hibernate";
            glyph = "hibernate";
            label = "Hibernate";
            variant = "outline";
          };
        };
        lockscreen-widget-0000000000000007 = {
          box_height = 48.0;
          box_width = 144.0;
          cx = 1045.0;
          cy = 672.0;
          output = "eDP-1";
          placement_height = 1200.0;
          placement_width = 1920.0;
          rotation = 0.0;
          type = "button";

          settings = {
            background = true;
            command = "systemctl shutdown";
            glyph = "power";
            label = "Shut Down";
            variant = "destructive";
          };
        };
        lockscreen-widget-0000000000000008 = {
          box_height = 144.0;
          box_width = 192.0;
          cx = 192.0;
          cy = 328.0;
          output = "eDP-1";
          placement_height = 1200.0;
          placement_width = 1920.0;
          rotation = 0.0;
          type = "volume";

          settings = {
            background = false;
            device = "output";
            scroll_step = 5;
            shadow = true;
            show_device = false;
          };
        };
      };
    };
  };
}
