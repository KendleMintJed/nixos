{
  self,
  inputs,
  ...
}: {
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

    catppuccin = lib.mapAttrs (_: hexToRgb) self.media.catppuccinMocha;
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

            colors = with catppuccin; {
              toolbar = base;
              toolbar_text = text;
              frame = crust;
              tab_background_text = text;

              toolbar_field = mantle;
              toolbar_field_text = text;

              tab_line = blue;
              popup = base;
              popup_text = text;

              button_background_active = overlay0;

              frame_inactive = crust;

              icons_attention = blue;
              icons = blue;

              ntp_background = crust;
              ntp_text = text;

              popup_border = blue;
              popup_highlight_text = text;
              popup_highlight = overlay0;

              sidebar_border = blue;
              sidebar_highlight_text = crust;
              sidebar_highlight = blue;
              sidebar_text = text;
              sidebar = base;

              tab_background_separator = blue;
              tab_loading = blue;
              tab_selected = base;
              tab_text = text;

              toolbar_bottom_separator = base;
              toolbar_field_border_focus = blue;
              toolbar_field_border = base;

              toolbar_field_focus = base;
              toolbar_field_highlight_text = base;
              toolbar_field_highlight = blue;

              toolbar_field_separator = blue;
              toolbar_vertical_separator = blue;
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
