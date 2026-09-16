{inputs, ...}: {
  flake.homeModules.firefox = {
    system,
    lib,
    ...
  }: let
    hexToRgb = hex: let
      value = lib.removePrefix "#" hex;
      pairs = builtins.genList (i: builtins.substring (i * 2) 2 value) 3;
      hexToInt = lib.fromHexString;
    in {
      r = hexToInt (builtins.elemAt pairs 0);
      g = hexToInt (builtins.elemAt pairs 1);
      b = hexToInt (builtins.elemAt pairs 2);
    };

    catppuccin = {
      base = "#1e1e2e";
      mantle = "#181825";
      crust = "#11111b";
      text = "#cdd6f4";
      blue = "#89b4fa";
      overlay0 = "#6c7086";
    };
  in {
    programs.librewolf = {
      enable = true;
      settings = {
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = false;
        "privacy.fingerprintingProtection" = true;
        "privacy.fingerprintingProtection.override" = "+AllTargets, -CSSPrefersColorScheme";
        "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = false;
        "privacy.clearOnShutdown_v2.cache" = false;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        "network.cookie.lifetimePolicy" = 0;
        "browser.startup.page" = 3;
        "browser.sessionstore.resume_session_once" = false;
        "browser.sessionstore.resume_from_crash" = true;
        "ui.systemUsesDarkTheme" = 1;
        "extensions.autoDisableScopes" = 0;
        "font.name-list.emoji" = "Twemoji SVG, Twemoji Mozilla";
      };
      profiles.default.extensions = {
        force = true;

        packages = with inputs.firefox-addons.packages.${system}; [
          sponsorblock
          firefox-color
        ];

        settings."FirefoxColor@mozilla.com".settings = {
          firstRunDone = true;

          theme = {
            title = "Catppuccin Mocha Blue";

            colors = {
              toolbar = hexToRgb catppuccin.base;
              toolbar_text = hexToRgb catppuccin.text;
              frame = hexToRgb catppuccin.crust;
              tab_background_text = hexToRgb catppuccin.text;

              toolbar_field = hexToRgb catppuccin.mantle;
              toolbar_field_text = hexToRgb catppuccin.text;

              tab_line = hexToRgb catppuccin.blue;
              popup = hexToRgb catppuccin.base;
              popup_text = hexToRgb catppuccin.text;

              button_background_active = hexToRgb catppuccin.overlay0;

              frame_inactive = hexToRgb catppuccin.crust;

              icons_attention = hexToRgb catppuccin.blue;
              icons = hexToRgb catppuccin.blue;

              ntp_background = hexToRgb catppuccin.crust;
              ntp_text = hexToRgb catppuccin.text;

              popup_border = hexToRgb catppuccin.blue;
              popup_highlight_text = hexToRgb catppuccin.text;
              popup_highlight = hexToRgb catppuccin.overlay0;

              sidebar_border = hexToRgb catppuccin.blue;
              sidebar_highlight_text = hexToRgb catppuccin.crust;
              sidebar_highlight = hexToRgb catppuccin.blue;
              sidebar_text = hexToRgb catppuccin.text;
              sidebar = hexToRgb catppuccin.base;

              tab_background_separator = hexToRgb catppuccin.blue;
              tab_loading = hexToRgb catppuccin.blue;
              tab_selected = hexToRgb catppuccin.base;
              tab_text = hexToRgb catppuccin.text;

              toolbar_bottom_separator = hexToRgb catppuccin.base;
              toolbar_field_border_focus = hexToRgb catppuccin.blue;
              toolbar_field_border = hexToRgb catppuccin.base;

              toolbar_field_focus = hexToRgb catppuccin.base;
              toolbar_field_highlight_text = hexToRgb catppuccin.base;
              toolbar_field_highlight = hexToRgb catppuccin.blue;

              toolbar_field_separator = hexToRgb catppuccin.blue;
              toolbar_vertical_separator = hexToRgb catppuccin.blue;
            };

            images = {
              additional_backgrounds = ["./bg-000.svg"];
              custom_backgrounds = [];
            };
          };
        };
      };
    };
  };
}
