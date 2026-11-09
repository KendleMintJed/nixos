{
  self,
  inputs,
  ...
}: {
  flake.homeModules.firefox = {
    pkgs,
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
        "privacy.fingerprintingProtection.override" = "+AllTargets, -CSSPrefersColorScheme";
        "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = false;
        "privacy.clearOnShutdown_v2.cache" = false;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        "network.cookie.lifetimePolicy" = 0;
        "browser.startup.page" = 3;
        "browser.sessionstore.resume_session_once" = false;
        "browser.sessionstore.resume_from_crash" = true;
        "font.name-list.emoji" = "Twemoji SVG, Twemoji Mozilla";

        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };

      globalExtensions = with inputs.firefox-addons.packages.${system}; [
        sponsorblock
        firefox-color
      ];

      profiles.default = {
        search = {
          force = true;
          default = "duckduckgo";
          privateDefault = "ddg";
          order = ["duckduckgo" "ddg"];
          engines = {
            duckduckgo = {
              name = "DuckDuckGo";
              urls = [{template = "https://duckduckgo.com/?q={searchTerms}";}];
              icon = "https://duckduckgo.com/assets/icons/meta/DDG-icon_256x256.png";
              definedAliases = ["@duckduckgo" "@ddg"];
            };

            nix-packages = {
              name = "Nix Packages";
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };

            nixos-wiki = {
              name = "NixOS Wiki";
              urls = [{template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";}];
              iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
              definedAliases = ["@nw"];
            };

            mojeek.metaData.hidden = true;
            startpage.metaData.hidden = true;
          };
        };

        extensions = {
          force = true;

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

        userContent = with self.media.catppuccinMocha; ''
          @-moz-document url-prefix("about:"), url-prefix("chrome://") {
            body {
              background-color: ${crust} !important;
              color: ${text} !important;
            }

            .logo {
              background: image-set(url("file://${self.media.librewolfCatppuccin}")) !important;
            }

            * {
              --text-color: ${text} !important;
              --text-color-deemphasized: ${subtext0} !important;

              --button-text-color: ${text} !important;
              --button-text-color-active: ${text} !important;
              --button-text-color-disabled: ${text} !important;
              --button-text-color-hover: ${text} !important;
              --button-text-color-selected: ${text} !important;
              --button-text-color-primary: ${base} !important;
              --button-text-color-primary-active: ${base} !important;
              --button-text-color-primary-disabled: ${base} !important;
              --button-text-color-primary-hover: ${base} !important;
              --button-text-color-primary-selected: ${base} !important;

              --icon-color-information: ${base} !important;

              --border-color: ${text} !important;
              --border-color-interactive: ${text} !important;
              --border-color-deemphasized: ${subtext0} !important;

              --background-color-canvas: ${crust} !important;
              --background-color-box: ${base} !important;
              --background-color-box-info: ${surface0} !important;
              --background-color-information: ${blue} !important;

              --button-background-color-hover: ${surface0} !important;
              --button-background-color-active: ${base} !important;
              --button-background-color-primary-disabled: ${blue} !important;

              --table-background-color: ${mantle} !important;

              --color-accent-primary: ${blue} !important;
              --color-accent-primary-hover: ${lavender} !important;
              --color-accent-primary-active: ${blue} !important;

              --color-accent-secondary: ${sky} !important;
              --color-accent-secondary-hover: ${sapphire} !important;
              --color-accent-secondary-active: ${sky} !important;
            }
          }
        '';
      };
    };
  };
}
